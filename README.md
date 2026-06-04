# JokeDelivery SDK

Fetch random setup-and-punchline jokes from a free, community-contributed REST API

> TypeScript, Python, PHP, Golang, Ruby, Lua SDKs, a CLI, an interactive REPL, and an MCP server for AI agents — all generated from one OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).

## About Joke Delivery API

The [Joke Delivery API](https://official-joke-api.appspot.com) is a small, free REST service that returns random jokes in JSON form. It is maintained by [David Katz](https://github.com/15Dkatz) and the open-source contributors of the [`official_joke_api`](https://github.com/15Dkatz/official_joke_api) project, and is hosted on Google App Engine.

What you get from the API:

- Single random jokes via `GET /random_joke`
- Each joke is an object with `id`, `type`, `setup`, and `punchline` fields
- Joke categories such as `programming` and `general` (the upstream repo also documents `/jokes/:type/random` and `/jokes/:id`)

The service requires no API key or authentication and CORS is enabled, so it can be called directly from browser code. No official rate limits are published; treat it as a best-effort community endpoint and cache responses where practical.

## Try it

**TypeScript**
```bash
npm install joke-delivery
```

**Python**
```bash
pip install joke-delivery-sdk
```

**PHP**
```bash
composer require voxgig/joke-delivery-sdk
```

**Golang**
```bash
go get github.com/voxgig-sdk/joke-delivery-sdk/go
```

**Ruby**
```bash
gem install joke-delivery-sdk
```

**Lua**
```bash
luarocks install joke-delivery-sdk
```

## 30-second quickstart

### TypeScript

```ts
import { JokeDeliverySDK } from 'joke-delivery'

const client = new JokeDeliverySDK({})

```

See the [TypeScript README](ts/README.md) for the
full guide, or scroll down for the same example in other languages.

## What's in the box

| Surface | Use it for | Path |
| --- | --- | --- |
| **SDK** (TypeScript, Python, PHP, Golang, Ruby, Lua) | App integration | `ts/` `py/` `php/` `go/` `rb/` `lua/` |
| **CLI** | Scripts, CI, ops, one-off API calls | `go-cli/` |
| **MCP server** | AI agents (Claude, Cursor, Cline) | `go-mcp/` |

## Use it from an AI agent (MCP)

The generated MCP server exposes every operation in this SDK as an
[MCP](https://modelcontextprotocol.io) tool that Claude, Cursor or Cline
can call directly. Build and register it:

```bash
cd go-mcp && go build -o joke-delivery-mcp .
```

Then add it to your agent's MCP config (Claude Desktop, Cursor, etc.):

```json
{
  "mcpServers": {
    "joke-delivery": {
      "command": "/abs/path/to/joke-delivery-mcp"
    }
  }
}
```

## Entities

The API exposes one entity:

| Entity | Description | API path |
| --- | --- | --- |
| **RandomJoke** | A single randomly selected joke returned from `GET /random_joke`, with `setup`, `punchline`, `type`, and `id` fields. | `/random_joke` |

Each entity supports the following operations where available: **load**,
**list**, **create**, **update**, and **remove**.

## Quickstart in other languages

### Python

```python
from jokedelivery_sdk import JokeDeliverySDK

client = JokeDeliverySDK({})


# Load a specific randomjoke
randomjoke, err = client.RandomJoke(None).load(
    {"id": "example_id"}, None
)
```

### PHP

```php
<?php
require_once 'jokedelivery_sdk.php';

$client = new JokeDeliverySDK([]);


// Load a specific randomjoke
[$randomjoke, $err] = $client->RandomJoke(null)->load(
    ["id" => "example_id"], null
);
```

### Golang

```go
import sdk "github.com/voxgig-sdk/joke-delivery-sdk/go"

client := sdk.NewJokeDeliverySDK(map[string]any{})

```

### Ruby

```ruby
require_relative "JokeDelivery_sdk"

client = JokeDeliverySDK.new({})


# Load a specific randomjoke
randomjoke, err = client.RandomJoke(nil).load(
  { "id" => "example_id" }, nil
)
```

### Lua

```lua
local sdk = require("joke-delivery_sdk")

local client = sdk.new({})


-- Load a specific randomjoke
local randomjoke, err = client:RandomJoke(nil):load(
  { id = "example_id" }, nil
)
```

## Unit testing in offline mode

Every SDK ships a test mode that swaps the HTTP transport for an
in-memory mock, so unit tests run offline.

### TypeScript

```ts
const client = JokeDeliverySDK.test()
const result = await client.RandomJoke().load({ id: 'test01' })
// result.ok === true, result.data contains mock data
```

### Python

```python
client = JokeDeliverySDK.test(None, None)
result, err = client.RandomJoke(None).load(
    {"id": "test01"}, None
)
```

### PHP

```php
$client = JokeDeliverySDK::test(null, null);
[$result, $err] = $client->RandomJoke(null)->load(
    ["id" => "test01"], null
);
```

### Golang

```go
client := sdk.TestSDK(nil, nil)
result, err := client.RandomJoke(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
```

### Ruby

```ruby
client = JokeDeliverySDK.test(nil, nil)
result, err = client.RandomJoke(nil).load(
  { "id" => "test01" }, nil
)
```

### Lua

```lua
local client = sdk.test(nil, nil)
local result, err = client:RandomJoke(nil):load(
  { id = "test01" }, nil
)
```

## How it works

Every SDK call runs the same five-stage pipeline:

1. **Point** — resolve the API endpoint from the operation definition.
2. **Spec** — build the HTTP specification (URL, method, headers, body).
3. **Request** — send the HTTP request.
4. **Response** — receive and parse the response.
5. **Result** — extract the result data for the caller.

A feature hook fires at each stage (e.g. `PrePoint`, `PreSpec`,
`PreRequest`), so features can inspect or modify the pipeline without
forking the SDK.

### Features

| Feature | Purpose |
| --- | --- |
| **TestFeature** | In-memory mock transport for testing without a live server |

Pass custom features via the `extend` option at construction time.

### Direct and Prepare

For endpoints the entity model doesn't cover, use the low-level methods:

- **`direct(fetchargs)`** — build and send an HTTP request in one step.
- **`prepare(fetchargs)`** — build the request without sending it.

Both accept a map with `path`, `method`, `params`, `query`,
`headers`, and `body`. See the [How-to guides](#how-to-guides) below.

## How-to guides

### Make a direct API call

When the entity interface does not cover an endpoint, use `direct`:

**TypeScript:**
```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})
console.log(result.data)
```

**Python:**
```python
result, err = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})
```

**PHP:**
```php
[$result, $err] = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example"],
]);
```

**Go:**
```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
```

**Ruby:**
```ruby
result, err = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example" },
})
```

**Lua:**
```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
```

## Per-language documentation

- [TypeScript](ts/README.md)
- [Python](py/README.md)
- [PHP](php/README.md)
- [Golang](go/README.md)
- [Ruby](rb/README.md)
- [Lua](lua/README.md)

## Using the Joke Delivery API

- Upstream: [https://official-joke-api.appspot.com](https://official-joke-api.appspot.com)
- API docs: [https://github.com/15Dkatz/official_joke_api](https://github.com/15Dkatz/official_joke_api)

- Upstream project [`15Dkatz/official_joke_api`](https://github.com/15Dkatz/official_joke_api) is published under the MIT License.
- Jokes were contributed by volunteers; the upstream README notes that "the majority of these jokes were contributed by joke-loving coders around the world."
- No attribution string is mandated by the API itself, but crediting the upstream project is courteous.
- This SDK is an independent client and is not affiliated with the upstream project.

---

Generated from the Joke Delivery API OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).
