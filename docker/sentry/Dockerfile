FROM getsentry/sentry:21.10.0

RUN  apt-get update && \
        apt-get install -y build-essential lcov valgrind libldap2-dev libsasl2-dev && \
        pip install sentry-ldap-auth

COPY sentry.conf.py /etc/sentry/sentry.conf.py

COPY GeoLite2-City.mmdb /etc/sentry/GeoLite2-City.mmdb