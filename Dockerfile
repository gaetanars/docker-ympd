FROM alpine:3.7
MAINTAINER Gaëtan Ars <zenman94@free.fr>

ENV YMPD_VERSION v1.3.0
WORKDIR /ympd

RUN apk update \
	&& apk upgrade \
	&& apk --no-cache add build-base openssl-dev cmake musl-dev libmpdclient-dev wget tar \
	
	&& wget "https://github.com/notandy/ympd/archive/${YMPD_VERSION}.tar.gz" \
	&& tar -xzf  ${YMPD_VERSION}.tar.gz && cd ${YMPD_VERSION} && mkdir build && cd build \
	&& cmake .. -DCMAKE_INSTALL_PREFIX:PATH=/usr \
	&& make \	
	
	&& rm -rf /var/cache/apk/* \
	&& apk del build-base openssl-dev cmake musl-dev libmpdclient-dev wget tar;
	
ENV MPD_SERVER=localhost
ENV MPD_PORT=6600
ENV WEBPORT=8080

EXPOSE 8080 
CMD ./ympd -h $MPD_SERVER -p $MPD_PORT -w $WEBPORT