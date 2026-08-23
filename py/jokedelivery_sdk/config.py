# JokeDelivery SDK configuration


_shared_config = None


def shared_config():
    """Return the process-wide config, built once on first use.

    The SDK reads the config on every request and never writes to it, so one
    instance is shared by every client rather than rebuilt per client.

    The returned dict is shared: treat it as read-only. Callers that need to
    mutate should use make_config, which always returns a fresh copy.
    """
    global _shared_config
    if _shared_config is None:
        _shared_config = make_config()
    return _shared_config


def make_config():
    """Build a fresh, fully materialised config dict.

    Every call rebuilds the whole structure, so prefer shared_config unless
    you need a private copy you intend to mutate.
    """
    return {
        "main": {
            "name": "JokeDelivery",
            "slug": "joke-delivery",
            "version": "0.0.1",
            "target": "py",
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
            "name": "id",
            "req": True,
            "short": "Unique identifier for the joke",
            "type": "`$INTEGER`",
          },
          {
            "name": "punchline",
            "req": True,
            "short": "The punchline or answer part of the joke",
            "type": "`$STRING`",
          },
          {
            "name": "setup",
            "req": True,
            "short": "The setup or question part of the joke",
            "type": "`$STRING`",
          },
          {
            "name": "type",
            "req": True,
            "short": "The category or type of joke",
            "type": "`$STRING`",
          },
        ],
        "name": "random_joke",
        "op": {
          "load": {
            "input": "data",
            "name": "load",
            "points": [
              {
                "args": {},
                "kind": "http",
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
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
