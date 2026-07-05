# frozen_string_literal: true

# Typed models for the JokeDelivery SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# RandomJoke entity data model.
#
# @!attribute [rw] id
#   @return [Integer]
#
# @!attribute [rw] punchline
#   @return [String]
#
# @!attribute [rw] setup
#   @return [String]
#
# @!attribute [rw] type
#   @return [String]
RandomJoke = Struct.new(
  :id,
  :punchline,
  :setup,
  :type,
  keyword_init: true
)

# Request payload for RandomJoke#load.
#
# @!attribute [rw] id
#   @return [Integer]
#
# @!attribute [rw] punchline
#   @return [String, nil]
#
# @!attribute [rw] setup
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
RandomJokeLoadMatch = Struct.new(
  :id,
  :punchline,
  :setup,
  :type,
  keyword_init: true
)

