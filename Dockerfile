FROM alpine:3.7
MAINTAINER Gaëtan Ars <zenman94@free.fr>

ENV YMPD_VERSION 1.3.0

RUN apk add --no-cache --virtual=build-dependencies \
	build-base \
	openssl-dev \
	cmake \
	musl-dev \
	libmpdclient-dev \
	curl \
	tar && \
apk add --no-cache \
	libmpdclient \
	libssl1.0 && \
mkdir -p /tmp/source/ympd && \
curl -Sl "https://codeload.github.com/notandy/ympd/tar.gz/v${YMPD_VERSION}" | tar xz -C \
	/tmp/source/ympd  --strip-components=1 && \
cd /tmp/source/ympd && mkdir build && cd build && cmake .. -DCMAKE_INSTALL_PREFIX:PATH=/usr && make && make install && \
apk del --purge build-dependencies && \
cd /tmp && rm -rf /tmp/*

ENV MPD_SERVER=localhost
ENV MPD_PORT=6600
ENV WEBPORT=8080

EXPOSE $WEBPORT
CMD /usr/bin/ympd -h $MPD_SERVER -p $MPD_PORT -w $WEBPORT
