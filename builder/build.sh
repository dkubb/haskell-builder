#!/usr/bin/env bash

set -feuo pipefail
IFS=$'\n\t'

if [ $# -eq 0 ] || [ "$1" == '--help' ] || [ "$1" == '-h' ]; then
  echo "Example:" \
       "docker run" \
       "-v \"\$(pwd):/src\"" \
       "-v /var/run/docker.sock:/var/run/docker.sock" \
       "dkubb/haskell-builder" \
       "<package-name>" \
       "[tag-name]"
  exit 1
fi

package="$1"
tag="${2-"$package":latest}"
ghc_options=${ghc_options:--static -optl-static -optl-pthread}
socket=/var/run/docker.sock
file=Dockerfile

echo "Building $package"
stack setup "$(ghc --numeric-version)" --skip-ghc-check
stack build --ghc-options "$ghc_options" -- .

# Strip all statically linked executables
find "$(stack path --dist-dir)/build" \
  -type f \
  -perm -u=x,g=x,o=x \
  -exec strip --strip-all --enable-deterministic-archives --preserve-dates {} +

if [ -S $socket ] && [ -r $socket ] && [ -w $socket ] && [ -f $file ] && [ -r $file ]; then
  ln -snf -- "$(stack path --dist-dir)/build" .
  docker build --tag "$tag" --file "$file" -- .
  echo "Created container $tag"
  echo "Usage: docker run -it --rm $tag"
fi
