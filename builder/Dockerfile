FROM mitchty/alpine-ghc:latest
MAINTAINER Dan Kubb <dkubb@fastmail.com>

RUN ["apk", "add", "--update-cache", "docker"]
RUN ["cabal", "install", "stack"]
RUN ["stack", "update"]

WORKDIR /src

COPY ["build.sh", "/usr/local/sbin/"]
ENTRYPOINT ["/usr/local/sbin/build.sh"]
CMD ["--help"]
