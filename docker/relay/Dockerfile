FROM getsentry/relay:21.10.0

COPY docker-alt-entrypoint.sh /docker-entrypoint.sh

RUN  mkdir -p /geoip/

COPY GeoLite2-City.mmdb /geoip/GeoLite2-City.mmdb
