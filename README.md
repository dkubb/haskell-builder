# haskell-builder

A docker container for compiling statically linked binaries written in Haskell.

This project is inspired by [golang-builder](https://github.com/CenturyLinkLabs/golang-builder)
for Go, but provides the same result for Haskell binaries.

## Overview

An example dockerfile:

```dockerfile
FROM scratch
COPY ["build/hello/hello", "/usr/bin/"]
ENTRYPOINT ["/usr/bin/hello"]
```

## Requirements

A project must include the following files:

```.
├── Dockerfile
├── example.cabal
├── stack.yaml
└── ...
```

A `Dockerfile` is optional, when present a container will be created.

## Usage

```bash
# Pull the docker container
docker pull dkubb/haskell-builder

# OR build it with:
# docker build --tag dkubb/haskell-builder builder

# Change to the directory containing the project
cd example

# Build an example container
docker run \
  -v "$(pwd):/src" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --rm \
  dkubb/haskell-builder \
  hello

# Run the binary inside the docker container
docker run -it --rm hello:latest
```

## Thanks

Thanks to Mitch Tishmack ([mitchy](https://github.com/mitchty)) for his
[Alpine Linux GHC port](https://github.com/mitchty/alpine-linux-ghc-bootstrap)
which provides the base docker image for this project.
