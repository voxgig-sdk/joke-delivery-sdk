# JokeDelivery SDK configuration


def make_config():
    return {
        "main": {
            "name": "JokeDelivery",
        },
        "feature": {
            "test": {
        "options": {
          "active": False,
        },
      },
        },
        "options": {
            "base": "https://official-joke-api.appspot.com",
            "auth": {
                "prefix": "Bearer",
            },
            "headers": {
        "content-type": "application/json",
      },
            "entity": {
                "random_joke": {},
            },
        },
        "entity": {
      "random_joke": {
        "fields": [
          {
            "active": True,
            "name": "id",
            "req": True,
            "type": "`$INTEGER`",
            "index$": 0,
          },
          {
            "active": True,
            "name": "punchline",
            "req": True,
            "type": "`$STRING`",
            "index$": 1,
          },
          {
            "active": True,
            "name": "setup",
            "req": True,
            "type": "`$STRING`",
            "index$": 2,
          },
          {
            "active": True,
            "name": "type",
            "req": True,
            "type": "`$STRING`",
            "index$": 3,
          },
        ],
        "name": "random_joke",
        "op": {
          "load": {
            "input": "data",
            "name": "load",
            "points": [
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/random_joke",
                "parts": [
                  "random_joke",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
            ],
            "key$": "load",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
