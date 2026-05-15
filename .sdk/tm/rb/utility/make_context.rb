# JokeDelivery SDK utility: make_context
require_relative '../core/context'
module JokeDeliveryUtilities
  MakeContext = ->(ctxmap, basectx) {
    JokeDeliveryContext.new(ctxmap, basectx)
  }
end
