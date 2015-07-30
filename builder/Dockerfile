FROM alpine:latest
MAINTAINER Dan Kubb <dkubb@fastmail.com>

# Add repository for ghc 7.10.2
RUN echo "https://s3-us-west-2.amazonaws.com/alpine-ghc/7.10" >> /etc/apk/repositories
ADD ["https://raw.githubusercontent.com/mitchty/alpine-linux-ghc-bootstrap/master/example/mitch.tishmack%40gmail.com-55881c97.rsa.pub", "/etc/apk/keys/mitch.tishmack@gmail.com-55881c97.rsa.pub"]

# Install system dependencies
RUN ["apk", "update"]
RUN ["apk", "add", "docker", "ghc", "cabal-install", "zlib-dev"]

# Install stack
ENV PATH ${PATH}:/root/.cabal/bin
RUN cabal update
RUN cabal install stack
RUN stack update

VOLUME /src
WORKDIR /src

COPY ["build.sh", "/usr/local/sbin/"]
ENTRYPOINT ["/usr/local/sbin/build.sh"]
CMD ["--help"]
