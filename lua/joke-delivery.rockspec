package = "voxgig-sdk-joke-delivery"
version = "0.0-1"
source = {
  url = "git://github.com/voxgig-sdk/joke-delivery-sdk.git"
}
description = {
  summary = "JokeDelivery SDK for Lua",
  license = "MIT"
}
dependencies = {
  "lua >= 5.3",
  "dkjson >= 2.5",
  "dkjson >= 2.5",
}
build = {
  type = "builtin",
  modules = {
    ["joke-delivery_sdk"] = "joke-delivery_sdk.lua",
    ["config"] = "config.lua",
    ["features"] = "features.lua",
  }
}
