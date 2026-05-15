# JokeDelivery SDK feature factory

from feature.base_feature import JokeDeliveryBaseFeature
from feature.test_feature import JokeDeliveryTestFeature


def _make_feature(name):
    features = {
        "base": lambda: JokeDeliveryBaseFeature(),
        "test": lambda: JokeDeliveryTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
