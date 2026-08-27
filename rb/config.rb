# JokeDelivery SDK configuration

module JokeDeliveryConfig
  # Return the process-wide config, built once on first use. The SDK reads
  # the config on every request and never writes to it, so one instance is
  # shared by every client rather than rebuilt per client.
  #
  # The returned hash is shared: treat it as read-only. Callers that need to
  # mutate should use make_config, which always returns a fresh copy.
  def self.shared_config
    @shared_config ||= make_config
  end


  # Build a fresh, fully materialised config hash. Every call rebuilds the
  # whole structure, so prefer shared_config unless you need a private copy
  # you intend to mutate.
  def self.make_config
    {
      "main" => {
        "name" => "JokeDelivery",
        "slug" => "joke-delivery",
        "version" => "0.0.1",
        "target" => "rb",
      },
      "feature" => {
        "test" => {
          "options" => {
            "active" => false,
          },
          "transport" => "base",
        },
      },
      "options" => {
        "base" => "https://official-joke-api.appspot.com",
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
              "name" => "id",
              "req" => true,
              "short" => "Unique identifier for the joke",
              "type" => "`$INTEGER`",
            },
            {
              "name" => "punchline",
              "req" => true,
              "short" => "The punchline or answer part of the joke",
              "type" => "`$STRING`",
            },
            {
              "name" => "setup",
              "req" => true,
              "short" => "The setup or question part of the joke",
              "type" => "`$STRING`",
            },
            {
              "name" => "type",
              "req" => true,
              "short" => "The category or type of joke",
              "type" => "`$STRING`",
            },
          ],
          "name" => "random_joke",
          "op" => {
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
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
                },
              ],
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
