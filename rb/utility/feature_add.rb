# JokeDelivery SDK utility: feature_add
module JokeDeliveryUtilities
  FeatureAdd = ->(ctx, f) {
    ctx.client.features << f
  }
end
