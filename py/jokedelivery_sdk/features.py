# JokeDelivery SDK feature factory

from jokedelivery_sdk.feature.base_feature import JokeDeliveryBaseFeature
from jokedelivery_sdk.feature.ratelimit_feature import JokeDeliveryRatelimitFeature
from jokedelivery_sdk.feature.retry_feature import JokeDeliveryRetryFeature
from jokedelivery_sdk.feature.test_feature import JokeDeliveryTestFeature
from jokedelivery_sdk.feature.timeout_feature import JokeDeliveryTimeoutFeature


_FEATURES = {
    "base": lambda: JokeDeliveryBaseFeature(),
    "ratelimit": lambda: JokeDeliveryRatelimitFeature(),
    "retry": lambda: JokeDeliveryRetryFeature(),
    "test": lambda: JokeDeliveryTestFeature(),
    "timeout": lambda: JokeDeliveryTimeoutFeature(),
}


def _make_feature(name):
    factory = _FEATURES.get(name)
    if factory is not None:
        return factory()
    return _FEATURES["base"]()


# True when this SDK was generated with the named feature class - the
# constructor's tolerance for extend-carried features reads this (an
# active name with no generated class must not become a BaseFeature
# stray when an extend instance carries it).
def _has_feature(name):
    return name in _FEATURES
