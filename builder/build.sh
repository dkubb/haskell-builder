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
ghc_options=${ghc_options:--O2 -threaded -optl-static -optl-s}
socket=/var/run/docker.sock
file=Dockerfile

echo "Building $package"
stack build --ghc-options "$ghc_options" -- .

if [ -S $socket -a -r $socket -a -w $socket -a -f $file -a -r $file ]; then
  ln -snf -- "$(stack path --dist-dir)/build" .
  docker build --tag "$tag" --file "$file" -- .
  echo "Created container $tag"
fi
