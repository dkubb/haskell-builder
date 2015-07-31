# haskell-builder

A docker container for compiling statically linked binaries written in Haskell

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

## Usage

```bash
# Build the container that performs compilation
docker build --tag dkubb/haskell-builder builder

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
