# zenman94/ympd

ympd is a standalone MPD Web GUI written in C, utilizing Websockets and Bootstrap/JS https://github.com/notandy/ympd

v1.3.0 is from notandy repo : https://github.com/notandy/ympd

Others are from SuperBFG7 (master branch) : https://github.com/SuperBFG7/ympd

## Usage

```
docker create \
--name=ympd \
-e MPD_SERVER=<adress> -e MPD_PORT=<port>  \
-p 8080:8080 \
zenman94/ympd
```

## Parameters

* `-e MPD_SERVER` - adress of MPD server (default: localhost)
* `-e MPD_PORT` - port of MPD server (default: 6600)


