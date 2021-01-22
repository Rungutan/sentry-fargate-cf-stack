FROM getsentry/sentry:21.1.0

RUN  apt-get update && \
        apt-get install -y build-essential lcov valgrind libldap2-dev libsasl2-dev && \
        pip install sentry-ldap-auth

COPY docker/sentry/sentry.conf.py /etc/sentry/sentry.conf.py

