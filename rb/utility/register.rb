# JokeDelivery SDK utility registration
require_relative '../core/utility_type'
require_relative 'clean'
require_relative 'done'
require_relative 'make_error'
require_relative 'feature_add'
require_relative 'feature_hook'
require_relative 'feature_init'
require_relative 'fetcher'
require_relative 'make_fetch_def'
require_relative 'make_context'
require_relative 'make_options'
require_relative 'make_request'
require_relative 'make_response'
require_relative 'make_result'
require_relative 'make_point'
require_relative 'make_spec'
require_relative 'make_url'
require_relative 'param'
require_relative 'prepare_auth'
require_relative 'prepare_body'
require_relative 'prepare_headers'
require_relative 'prepare_method'
require_relative 'prepare_params'
require_relative 'prepare_path'
require_relative 'prepare_query'
require_relative 'result_basic'
require_relative 'result_body'
require_relative 'result_headers'
require_relative 'transform_request'
require_relative 'transform_response'

JokeDeliveryUtility.registrar = ->(u) {
  u.clean = JokeDeliveryUtilities::Clean
  u.done = JokeDeliveryUtilities::Done
  u.make_error = JokeDeliveryUtilities::MakeError
  u.feature_add = JokeDeliveryUtilities::FeatureAdd
  u.feature_hook = JokeDeliveryUtilities::FeatureHook
  u.feature_init = JokeDeliveryUtilities::FeatureInit
  u.fetcher = JokeDeliveryUtilities::Fetcher
  u.make_fetch_def = JokeDeliveryUtilities::MakeFetchDef
  u.make_context = JokeDeliveryUtilities::MakeContext
  u.make_options = JokeDeliveryUtilities::MakeOptions
  u.make_request = JokeDeliveryUtilities::MakeRequest
  u.make_response = JokeDeliveryUtilities::MakeResponse
  u.make_result = JokeDeliveryUtilities::MakeResult
  u.make_point = JokeDeliveryUtilities::MakePoint
  u.make_spec = JokeDeliveryUtilities::MakeSpec
  u.make_url = JokeDeliveryUtilities::MakeUrl
  u.param = JokeDeliveryUtilities::Param
  u.prepare_auth = JokeDeliveryUtilities::PrepareAuth
  u.prepare_body = JokeDeliveryUtilities::PrepareBody
  u.prepare_headers = JokeDeliveryUtilities::PrepareHeaders
  u.prepare_method = JokeDeliveryUtilities::PrepareMethod
  u.prepare_params = JokeDeliveryUtilities::PrepareParams
  u.prepare_path = JokeDeliveryUtilities::PreparePath
  u.prepare_query = JokeDeliveryUtilities::PrepareQuery
  u.result_basic = JokeDeliveryUtilities::ResultBasic
  u.result_body = JokeDeliveryUtilities::ResultBody
  u.result_headers = JokeDeliveryUtilities::ResultHeaders
  u.transform_request = JokeDeliveryUtilities::TransformRequest
  u.transform_response = JokeDeliveryUtilities::TransformResponse
}
