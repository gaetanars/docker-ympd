FROM alpine
MAINTAINER Gaëtan Ars <zenman94@free.fr>

ENV YMPD_VERSION 1.3.0
WORKDIR /ympd

RUN apk add --update build-base openssl-dev cmake musl-dev libmpdclient-dev curl tar \
	&& curl -Sl "https://codeload.github.com/notandy/ympd/tar.gz/v${YMPD_VERSION}" | tar xz \
	&& cd ympd-${YMPD_VERSION} && mkdir build && cd build \
	&& cmake .. -DCMAKE_INSTALL_PREFIX:PATH=/usr \
	&& make \	
	&& rm -rf /var/cache/apk/* \
	&& apk del build-base openssl-dev cmake musl-dev libmpdclient-dev wget tar

ENV MPD_SERVER=localhost
ENV MPD_PORT=6600
ENV WEBPORT=8080

EXPOSE 8080 
CMD ./ympd -h $MPD_SERVER -p $MPD_PORT -w $WEBPORT
