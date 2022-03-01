FROM alpine:edge

# See -> https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Nerd Fonts Patcher" \
      org.opencontainers.image.description="Patches developer targeted fonts with a high number of glyphs (icons)." \
      org.opencontainers.image.url="https://www.nerdfonts.com/" \
      org.opencontainers.image.source="https://github.com/icy-comet/dockered-nerdfonts-patcher" \
      org.opencontainers.image.licenses="MIT"

# See -> https://wiki.alpinelinux.org/wiki/Package_management#Packages_and_Repositories
RUN echo https://dl-cdn.alpinelinux.org/alpine/edge/main > /etc/apk/repositories && \
    echo https://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo https://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories

# See -> https://pkgs.alpinelinux.org/packages
RUN apk update && apk upgrade && \
    apk add fontforge && \
    apk add unzip && \
    apk add py3-pip && \
    pip install configparser

ENV PYTHONIOENCODING=utf-8

VOLUME /in /out

WORKDIR /patcher

ADD https://github.com/ryanoasis/nerd-fonts/releases/download/2.2.0-RC/FontPatcher.zip fp.zip

RUN unzip fp.zip && rm fp.zip && sed -i "s/python/python3/" ./font-patcher

COPY ./entrypoint.sh /

COPY ./helper.sh .

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]

CMD ["-h"]
