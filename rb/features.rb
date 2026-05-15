# JokeDelivery SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/test_feature'


module JokeDeliveryFeatures
  def self.make_feature(name)
    case name
    when "base"
      JokeDeliveryBaseFeature.new
    when "test"
      JokeDeliveryTestFeature.new
    else
      JokeDeliveryBaseFeature.new
    end
  end
end
