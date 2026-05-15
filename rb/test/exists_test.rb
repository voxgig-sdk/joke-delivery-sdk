# JokeDelivery SDK exists test

require "minitest/autorun"
require_relative "../JokeDelivery_sdk"

class ExistsTest < Minitest::Test
  def test_create_test_sdk
    testsdk = JokeDeliverySDK.test(nil, nil)
    assert !testsdk.nil?
  end
end
