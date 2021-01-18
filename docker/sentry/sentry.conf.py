from sentry.conf.server import *  # NOQA
from distutils.util import strtobool
import os


DATABASES = {
    "default": {
        "ENGINE": "sentry.db.postgres",
        "NAME": os.environ.get("POSTGRES_DB"),
        "USER": os.environ.get("POSTGRES_USER"),
        "PASSWORD": os.environ.get("POSTGRES_PASSWORD"),
        "HOST": os.environ.get("POSTGRES_HOST"),
        "PORT": int(os.environ.get("POSTGRES_PORT"))
    }
}

#########
# Redis #
#########

# Generic Redis configuration used as defaults for various things including:
# Buffers, Quotas, TSDB

redis_host = os.environ.get("REDIS_HOST")
redis_port = os.environ.get("REDIS_PORT")
SENTRY_OPTIONS.update({
    'redis.clusters': {
        'default': {
            'hosts': {
                0: {
                    'host': redis_host,
                    'password': '',
                    'port': str(redis_port),
                    'db': '0',
                },
            },
        },
    },
})


# You should not change this setting after your database has been created
# unless you have altered all schemas first
SENTRY_USE_BIG_INTS = True

###########
# General #
###########

# Instruct Sentry that this install intends to be run by a single organization
# and thus various UI optimizations should be enabled.
SENTRY_SINGLE_ORGANIZATION = True

SENTRY_OPTIONS["system.event-retention-days"] = int(env('SENTRY_EVENT_RETENTION_DAYS') or 90)

#########
# Queue #
#########

# See https://docs.getsentry.com/on-premise/server/queue/ for more
# information on configuring your queue broker and workers. Sentry relies
# on a Python framework called Celery to manage queues.
BROKER_URL = os.environ.get("BROKER_URL", "redis://:@" + redis_host + ":" + redis_port + "/0")

#########
# Cache #
#########

# Sentry currently utilizes two separate mechanisms. While CACHES is not a
# requirement, it will optimize several high throughput patterns.

# CACHES = {
#     "default": {
#         "BACKEND": "django.core.cache.backends.memcached.MemcachedCache",
#         "LOCATION": ["memcached:11211"],
#         "TIMEOUT": 3600,
#     }
# }

# A primary cache is required for things such as processing events
SENTRY_CACHE = "sentry.cache.redis.RedisCache"

kafka_broker_1 = os.environ.get("KAFKA_BROKER_1")
kafka_broker_2 = os.environ.get("KAFKA_BROKER_2")
kafka_broker_3 = os.environ.get("KAFKA_BROKER_3")

DEFAULT_KAFKA_OPTIONS = {
    "bootstrap.servers": kafka_broker_1 + "," + kafka_broker_2 + "," + kafka_broker_3,
    "message.max.bytes": 50000000,
    "socket.timeout.ms": 1000,
}

SENTRY_EVENTSTREAM = "sentry.eventstream.kafka.KafkaEventStream"
SENTRY_EVENTSTREAM_OPTIONS = {"producer_configuration": DEFAULT_KAFKA_OPTIONS}

KAFKA_CLUSTERS["default"] = DEFAULT_KAFKA_OPTIONS

###############
# Rate Limits #
###############

# Rate limits apply to notification handlers and are enforced per-project
# automatically.

SENTRY_RATELIMITER = "sentry.ratelimits.redis.RedisRateLimiter"

##################
# Update Buffers #
##################

# Buffers (combined with queueing) act as an intermediate layer between the
# database and the storage API. They will greatly improve efficiency on large
# numbers of the same events being sent to the API in a short amount of time.
# (read: if you send any kind of real data to Sentry, you should enable buffers)

SENTRY_BUFFER = "sentry.buffer.redis.RedisBuffer"

##########
# Quotas #
##########

# Quotas allow you to rate limit individual projects or the Sentry install as
# a whole.

SENTRY_QUOTAS = "sentry.quotas.redis.RedisQuota"

########
# TSDB #
########

# The TSDB is used for building charts as well as making things like per-rate
# alerts possible.

SENTRY_TSDB = "sentry.tsdb.redissnuba.RedisSnubaTSDB"

#########
# SNUBA #
#########

SENTRY_SEARCH = "sentry.search.snuba.EventsDatasetSnubaSearchBackend"
SENTRY_SEARCH_OPTIONS = {}
SENTRY_TAGSTORE_OPTIONS = {}

###########
# Digests #
###########

# The digest backend powers notification summaries.

SENTRY_DIGESTS = "sentry.digests.backends.redis.RedisBackend"

##############
# Web Server #
##############

SENTRY_WEB_HOST = "0.0.0.0"
SENTRY_WEB_PORT = 9000
SENTRY_PUBLIC = True
SENTRY_WEB_OPTIONS = {
    "http": "%s:%s" % (SENTRY_WEB_HOST, SENTRY_WEB_PORT),
    "protocol": "uwsgi",
    # This is needed to prevent https://git.io/fj7Lw
    "uwsgi-socket": None,
    "http-keepalive": True,
    "memory-report": False,
    # 'workers': 3,  # the number of web workers
}

###########
# SSL/TLS #
###########

# If you're using a reverse SSL proxy, you should enable the X-Forwarded-Proto
# header and enable the settings below

# SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
# SESSION_COOKIE_SECURE = True
# CSRF_COOKIE_SECURE = True
# SOCIAL_AUTH_REDIRECT_IS_HTTPS = True

# End of SSL/TLS settings

############
# Features #
############


SENTRY_FEATURES = {
  "auth:register": True
}
SENTRY_FEATURES["projects:sample-events"] = False
SENTRY_FEATURES.update(
    {
        feature: True
        for feature in (
            "organizations:org-subdomains",
            "organizations:advanced-search",
            "organizations:android-mappings",
            "organizations:api-keys",
            "organizations:boolean-search",
            "organizations:related-events",
            "organizations:alert-filters",
            "organizations:custom-symbol-sources",
            "organizations:data-forwarding",
            "organizations:discover",
            "organizations:discover-basic",
            "organizations:discover-query",
            "organizations:enterprise-perf",
            "organizations:event-attachments",
            "organizations:events",
            "organizations:global-views",
            "organizations:incidents",
            "organizations:integrations-event-hooks",
            "organizations:integrations-issue-basic",
            "organizations:integrations-issue-sync",
            "organizations:integrations-alert-rule",
            "organizations:integrations-chat-unfurl",
            "organizations:integrations-incident-management",
            "organizations:integrations-vsts-limited-scopes",
            "organizations:internal-catchall",
            "organizations:invite-members",
            "organizations:large-debug-files",
            "organizations:monitors",
            "organizations:onboarding",
            "organizations:org-saved-searches",
            "organizations:performance-view",
            "organizations:relay",
            "organizations:rule-page",
            "organizations:set-grouping-config",
            "organizations:slack-migration",
            "organizations:sso-basic",
            "organizations:sso-rippling",
            "organizations:sso-saml2",
            "organizations:symbol-sources",
            "organizations:transaction-comparison",
            "organizations:trends",
            "organizations:usage-stats-graph",
            "organizations:dynamic-issue-counts",
            "organizations:releases-v2",
            "organizations:artifacts-in-settings",
            "organizations:transaction-events",
            "organizations:invite-members-rate-limits",

            "projects:alert-filters",
            "projects:custom-inbound-filters",
            "projects:data-forwarding",
            "projects:discard-groups",
            "projects:issue-alerts-targeting",
            "projects:minidump",
            "projects:rate-limits",
            "projects:sample-events",
            "projects:servicehooks",
            "projects:similarity-view",
            "projects:similarity-indexing",
            "projects:similarity-view-v2",
            "projects:similarity-indexing-v2",
            "projects:reprocessing-v2",
        )
    }
)

#######################
# Email Configuration #
#######################
# SENTRY_OPTIONS['mail.backend'] = os.getenv("SENTRY_EMAIL_BACKEND")
# SENTRY_OPTIONS['mail.use-tls'] = bool(strtobool(os.getenv("SENTRY_EMAIL_USE_TLS", "true")))
# SENTRY_OPTIONS['mail.username'] = os.getenv("SENTRY_EMAIL_USERNAME")
# SENTRY_OPTIONS['mail.password'] = os.getenv("SENTRY_EMAIL_PASSWORD")
# SENTRY_OPTIONS['mail.port'] = int(os.getenv("SENTRY_EMAIL_PORT"))
# SENTRY_OPTIONS['mail.host'] = os.getenv("SENTRY_EMAIL_HOST")
# SENTRY_OPTIONS['mail.from'] = os.getenv("SENTRY_EMAIL_FROM")

#########################
# Bitbucket Integration #
########################

# BITBUCKET_CONSUMER_KEY = 'YOUR_BITBUCKET_CONSUMER_KEY'
# BITBUCKET_CONSUMER_SECRET = 'YOUR_BITBUCKET_CONSUMER_SECRET'

#########
# Relay #
#########
SENTRY_RELAY_WHITELIST_PK = []
SENTRY_RELAY_OPEN_REGISTRATION = True


