package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewRandomJokeEntityFunc func(client *JokeDeliverySDK, entopts map[string]any) JokeDeliveryEntity

