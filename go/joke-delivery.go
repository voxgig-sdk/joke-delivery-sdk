package voxgigjokedeliverysdk

import (
	"github.com/voxgig-sdk/joke-delivery-sdk/go/core"
	"github.com/voxgig-sdk/joke-delivery-sdk/go/entity"
	"github.com/voxgig-sdk/joke-delivery-sdk/go/feature"
	_ "github.com/voxgig-sdk/joke-delivery-sdk/go/utility"
)

// Type aliases preserve external API.
type JokeDeliverySDK = core.JokeDeliverySDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type JokeDeliveryEntity = core.JokeDeliveryEntity
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type JokeDeliveryError = core.JokeDeliveryError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewRandomJokeEntityFunc = func(client *core.JokeDeliverySDK, entopts map[string]any) core.JokeDeliveryEntity {
		return entity.NewRandomJokeEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewJokeDeliverySDK = core.NewJokeDeliverySDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig

// No-arg convenience constructors. Go has no default-argument syntax,
// so these aliases let callers write `sdk.New()` / `sdk.Test()`
// instead of `sdk.NewJokeDeliverySDK(nil)` / `sdk.TestSDK(nil, nil)`
// for the common no-options case.
func New() *JokeDeliverySDK  { return NewJokeDeliverySDK(nil) }
func Test() *JokeDeliverySDK { return TestSDK(nil, nil) }
var NewBaseFeature = feature.NewBaseFeature
var NewTestFeature = feature.NewTestFeature
