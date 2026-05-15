package voxgigjokedeliverysdk

import (
	"github.com/voxgig-sdk/joke-delivery-sdk/core"
	"github.com/voxgig-sdk/joke-delivery-sdk/entity"
	"github.com/voxgig-sdk/joke-delivery-sdk/feature"
	_ "github.com/voxgig-sdk/joke-delivery-sdk/utility"
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
var NewBaseFeature = feature.NewBaseFeature
var NewTestFeature = feature.NewTestFeature
