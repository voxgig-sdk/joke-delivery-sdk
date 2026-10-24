# JokeDelivery SDK utility: prepare_body
require_relative 'media'
module JokeDeliveryUtilities
  PrepareBody = ->(ctx) {
    return nil unless ctx.op.input == "data"
    return JokeDeliveryUtilities.raw_body(ctx.reqdata) if JokeDeliveryUtilities.raw_request?(ctx.point)
    ctx.utility.transform_request.call(ctx)
  }
end
