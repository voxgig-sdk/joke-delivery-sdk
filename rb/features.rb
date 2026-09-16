# JokeDelivery SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/ratelimit_feature'
require_relative 'feature/retry_feature'
require_relative 'feature/test_feature'
require_relative 'feature/timeout_feature'


module JokeDeliveryFeatures
  def self.make_feature(name)
    case name
    when "base"
      JokeDeliveryBaseFeature.new
    when "ratelimit"
      JokeDeliveryRatelimitFeature.new
    when "retry"
      JokeDeliveryRetryFeature.new
    when "test"
      JokeDeliveryTestFeature.new
    when "timeout"
      JokeDeliveryTimeoutFeature.new
    else
      JokeDeliveryBaseFeature.new
    end
  end
end
