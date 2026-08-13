package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/joke-delivery-sdk/go"
	"github.com/voxgig-sdk/joke-delivery-sdk/go/core"

	vs "github.com/voxgig-sdk/joke-delivery-sdk/go/utility/struct"
)

func TestRandomJokeEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.RandomJoke(nil)
		if ent == nil {
			t.Fatal("expected non-nil RandomJokeEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := random_jokeBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"load"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "random_joke." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		// The basic flow consumes synthetic IDs from the fixture. In live mode
		// without an *_ENTID env override, those IDs hit the live API and 4xx.
		if setup.syntheticOnly {
			t.Skip("live entity test uses synthetic IDs from fixture — set JOKE_DELIVERY_TEST_RANDOM_JOKE_ENTID JSON to run live")
			return
		}
		client := setup.client

		// Bootstrap entity data from existing test data (no create step in flow).
		randomJokeRef01DataRaw := vs.Items(core.ToMapAny(vs.GetPath("existing.random_joke", setup.data)))
		var randomJokeRef01Data map[string]any
		if len(randomJokeRef01DataRaw) > 0 {
			randomJokeRef01Data = core.ToMapAny(randomJokeRef01DataRaw[0][1])
		}
		// Discard guards against Go's unused-var check when the flow's steps
		// happen not to consume the bootstrap data (e.g. list-only flows).
		_ = randomJokeRef01Data

		// LOAD
		randomJokeRef01Ent := client.RandomJoke(nil)
		randomJokeRef01MatchDt0 := map[string]any{
			"id": randomJokeRef01Data["id"],
		}
		randomJokeRef01DataDt0Loaded, err := randomJokeRef01Ent.Load(randomJokeRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		randomJokeRef01DataDt0LoadResult := core.ToMapAny(entityData(randomJokeRef01DataDt0Loaded))
		if randomJokeRef01DataDt0LoadResult == nil {
			t.Fatal("expected load result to be a map")
		}
		if randomJokeRef01DataDt0LoadResult["id"] != randomJokeRef01Data["id"] {
			t.Fatal("expected load result id to match")
		}

	})
}

func random_jokeBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "random_joke", "RandomJokeTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read random_joke test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse random_joke test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"random_joke01", "random_joke02", "random_joke03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Detect ENTID env override before envOverride consumes it. When live
	// mode is on without a real override, the basic test runs against synthetic
	// IDs from the fixture and 4xx's. Surface this so the test can skip.
	entidEnvRaw := os.Getenv("JOKE_DELIVERY_TEST_RANDOM_JOKE_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"JOKE_DELIVERY_TEST_RANDOM_JOKE_ENTID": idmap,
		"JOKE_DELIVERY_TEST_LIVE":      "FALSE",
		"JOKE_DELIVERY_TEST_EXPLAIN":   "FALSE",
	})

	idmapResolved := core.ToMapAny(env["JOKE_DELIVERY_TEST_RANDOM_JOKE_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["JOKE_DELIVERY_TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
			},
			extra,
		})
		client = sdk.NewJokeDeliverySDK(core.ToMapAny(mergedOpts))
	}

	live := env["JOKE_DELIVERY_TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["JOKE_DELIVERY_TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}
