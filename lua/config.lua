-- JokeDelivery SDK configuration

-- Build a fresh, fully materialised config table. Every call rebuilds the
-- whole structure, so prefer require("config_shared") unless you need a
-- private copy you intend to mutate.
local function make_config()
  return {
    main = {
      name = "JokeDelivery",
      slug = "joke-delivery",
      version = "0.0.1",
      target = "lua",
    },
    feature = {
      ["test"] = {
        ["options"] = {
          ["active"] = false,
        },
        ["transport"] = "base",
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
            ["name"] = "id",
            ["req"] = true,
            ["short"] = "Unique identifier for the joke",
            ["type"] = "`$INTEGER`",
          },
          {
            ["name"] = "punchline",
            ["req"] = true,
            ["short"] = "The punchline or answer part of the joke",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "setup",
            ["req"] = true,
            ["short"] = "The setup or question part of the joke",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "type",
            ["req"] = true,
            ["short"] = "The category or type of joke",
            ["type"] = "`$STRING`",
          },
        },
        ["name"] = "random_joke",
        ["op"] = {
          ["load"] = {
            ["input"] = "data",
            ["name"] = "load",
            ["points"] = {
              {
                ["args"] = {},
                ["kind"] = "http",
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
              },
            },
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
