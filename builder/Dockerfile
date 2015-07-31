FROM mitchty/alpine-ghc:latest
MAINTAINER Dan Kubb <dkubb@fastmail.com>

ENTRYPOINT ["/usr/local/sbin/build.sh"]
CMD ["--help"]

VOLUME /src
WORKDIR /src

RUN ["apk", "add", "--update-cache", "docker"]
RUN ["cabal", "install", "stack"]
RUN ["stack", "update"]

COPY ["build.sh", "/usr/local/sbin/"]
