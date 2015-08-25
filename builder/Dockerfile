FROM mitchty/alpine-ghc:latest
MAINTAINER Dan Kubb <dkubb@fastmail.com>

VOLUME /src
WORKDIR /src

RUN ["apk", "add", "--update-cache", "docker=1.6.2-r0"]

COPY ["build.sh", "/usr/local/sbin/"]

ENTRYPOINT ["/usr/local/sbin/build.sh"]
CMD ["--help"]
