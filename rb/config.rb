# JokeDelivery SDK configuration

module JokeDeliveryConfig
  def self.make_config
    {
      "main" => {
        "name" => "JokeDelivery",
      },
      "feature" => {
        "test" => {
          "options" => {
            "active" => false,
          },
        },
      },
      "options" => {
        "base" => "https://official-joke-api.appspot.com",
        "auth" => {
          "prefix" => "Bearer",
        },
        "headers" => {
          "content-type" => "application/json",
        },
        "entity" => {
          "random_joke" => {},
        },
      },
      "entity" => {
        "random_joke" => {
          "fields" => [
            {
              "active" => true,
              "name" => "id",
              "req" => true,
              "type" => "`$INTEGER`",
              "index$" => 0,
            },
            {
              "active" => true,
              "name" => "punchline",
              "req" => true,
              "type" => "`$STRING`",
              "index$" => 1,
            },
            {
              "active" => true,
              "name" => "setup",
              "req" => true,
              "type" => "`$STRING`",
              "index$" => 2,
            },
            {
              "active" => true,
              "name" => "type",
              "req" => true,
              "type" => "`$STRING`",
              "index$" => 3,
            },
          ],
          "name" => "random_joke",
          "op" => {
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "active" => true,
                  "args" => {},
                  "method" => "GET",
                  "orig" => "/random_joke",
                  "parts" => [
                    "random_joke",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "load",
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
      },
    }
  end


  def self.make_feature(name)
    require_relative 'features'
    JokeDeliveryFeatures.make_feature(name)
  end
end
