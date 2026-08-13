# JokeDelivery SDK utility: make_context

from jokedelivery_sdk.core.context import JokeDeliveryContext


def make_context_util(ctxmap, basectx):
    return JokeDeliveryContext(ctxmap, basectx)
