-- ProjectName SDK configuration

local function make_config()
  return {
    main = {
      name = "JokeDelivery",
    },
    feature = {
      ["test"] = {
        ["options"] = {
          ["active"] = false,
        },
      },
    },
    options = {
      base = "https://official-joke-api.appspot.com",
      headers = {
        ["content-type"] = "application/json",
      },
      entity = {
        ["random_joke"] = {},
      },
    },
    entity = {
      ["random_joke"] = {
        ["fields"] = {
          {
            ["active"] = true,
            ["name"] = "id",
            ["req"] = true,
            ["type"] = "`$INTEGER`",
            ["index$"] = 0,
          },
          {
            ["active"] = true,
            ["name"] = "punchline",
            ["req"] = true,
            ["type"] = "`$STRING`",
            ["index$"] = 1,
          },
          {
            ["active"] = true,
            ["name"] = "setup",
            ["req"] = true,
            ["type"] = "`$STRING`",
            ["index$"] = 2,
          },
          {
            ["active"] = true,
            ["name"] = "type",
            ["req"] = true,
            ["type"] = "`$STRING`",
            ["index$"] = 3,
          },
        },
        ["name"] = "random_joke",
        ["op"] = {
          ["load"] = {
            ["input"] = "data",
            ["name"] = "load",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {},
                ["method"] = "GET",
                ["orig"] = "/random_joke",
                ["parts"] = {
                  "random_joke",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "load",
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
    },
  }
end


local function make_feature(name)
  local features = require("features")
  local factory = features[name]
  if factory ~= nil then
    return factory()
  end
  return features.base()
end


-- Attach make_feature to the SDK class
local function setup_sdk(SDK)
  SDK._make_feature = make_feature
end


return make_config
