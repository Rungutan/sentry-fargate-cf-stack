FROM getsentry/sentry:21.6.2

RUN  apt-get update && \
        apt-get install -y build-essential lcov valgrind libldap2-dev libsasl2-dev && \
        pip install sentry-ldap-auth

COPY sentry.conf.py /etc/sentry/sentry.conf.py

RUN  mkdir -p /geoip/