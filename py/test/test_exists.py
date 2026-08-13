# JokeDelivery SDK exists test

import pytest
from jokedelivery_sdk import JokeDeliverySDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = JokeDeliverySDK.test(None, None)
        assert testsdk is not None
