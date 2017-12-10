## prepare build env
FROM        alpine:3.5 AS base
RUN     apk  add --no-cache --update libgcc libstdc++ ca-certificates libcrypto1.0 libssl1.0 libgomp expat

FROM        base AS build
RUN     buildDeps="autoconf \
                   automake \
                   bash \
                   binutils \
                   bzip2 \
                   cmake \
                   curl \
                   coreutils \
                   file \
                   g++ \
                   gcc \
                   gperf \
                   libtool \
                   make \
                   python \
                   openssl-dev \
                   tar \
                   yasm \
                   zlib-dev \
                   expat-dev" && \
        apk  add --no-cache --update ${buildDeps}

WORKDIR /tmp/workdir
COPY ./build.sh ./
COPY ./silk ./silk
RUN ["/tmp/workdir/build.sh"]

MAINTAINER  Kevin He <freefacefly@gmail.com>

FROM jrottenberg/ffmpeg:3.4-alpine
RUN     buildDeps="bash" && \
        apk  add --update ${buildDeps}
COPY conv.sh /
COPY --from=build /tmp/workdir/silk/decoder /bin/silkdec
RUN chmod a+x /bin/silkdec
WORKDIR /
ENTRYPOINT ["./conv.sh"]