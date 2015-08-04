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
ghc_options=${ghc_options:--O2 -threaded -static -optl-pthread -optl-static -optl-s}
ld_options=${ld_options:--static -pthread}
socket=/var/run/docker.sock
file=Dockerfile

echo "Building $package"
until cabal install --jobs --only-dependencies; do :; done
cabal configure --disable-executable-dynamic --disable-shared --ghc-options "$ghc_options" --ld-options "$ld_options"
cabal build --jobs

if [ -S $socket -a -r $socket -a -w $socket -a -f $file -a -r $file ]; then
  docker build --tag "$tag" --file "$file" -- .
  echo "Created container $tag"
  echo "Usage: docker run -it --rm $tag"
fi
