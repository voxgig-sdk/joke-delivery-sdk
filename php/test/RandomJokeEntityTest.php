<?php
declare(strict_types=1);

// RandomJoke entity test

require_once __DIR__ . '/../jokedelivery_sdk.php';
require_once __DIR__ . '/Runner.php';

use PHPUnit\Framework\TestCase;
use Voxgig\Struct\Struct as Vs;

class RandomJokeEntityTest extends TestCase
{
    public function test_create_instance(): void
    {
        $testsdk = JokeDeliverySDK::test(null, null);
        $ent = $testsdk->RandomJoke(null);
        $this->assertNotNull($ent);
    }

    public function test_basic_flow(): void
    {
        $setup = random_joke_basic_setup(null);
        // Per-op sdk-test-control.json skip.
        $_live = !empty($setup["live"]);
        foreach (["load"] as $_op) {
            [$_shouldSkip, $_reason] = Runner::is_control_skipped("entityOp", "random_joke." . $_op, $_live ? "live" : "unit");
            if ($_shouldSkip) {
                $this->markTestSkipped($_reason ?? "skipped via sdk-test-control.json");
                return;
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live mode
        // without an *_ENTID env override, those IDs hit the live API and 4xx.
        if (!empty($setup["synthetic_only"])) {
            $this->markTestSkipped("live entity test uses synthetic IDs from fixture — set JOKEDELIVERY_TEST_RANDOM_JOKE_ENTID JSON to run live");
            return;
        }
        $client = $setup["client"];

        // Bootstrap entity data from existing test data.
        $random_joke_ref01_data_raw = Vs::items(Helpers::to_map(
            Vs::getpath($setup["data"], "existing.random_joke")));
        $random_joke_ref01_data = null;
        if (count($random_joke_ref01_data_raw) > 0) {
            $random_joke_ref01_data = Helpers::to_map($random_joke_ref01_data_raw[0][1]);
        }

        // LOAD
        $random_joke_ref01_ent = $client->RandomJoke(null);
        $random_joke_ref01_match_dt0 = [
            "id" => $random_joke_ref01_data["id"],
        ];
        [$random_joke_ref01_data_dt0_loaded, $err] = $random_joke_ref01_ent->load($random_joke_ref01_match_dt0, null);
        $this->assertNull($err);
        $random_joke_ref01_data_dt0_load_result = Helpers::to_map($random_joke_ref01_data_dt0_loaded);
        $this->assertNotNull($random_joke_ref01_data_dt0_load_result);
        $this->assertEquals($random_joke_ref01_data_dt0_load_result["id"], $random_joke_ref01_data["id"]);

    }
}

function random_joke_basic_setup($extra)
{
    Runner::load_env_local();

    $entity_data_file = __DIR__ . '/../../.sdk/test/entity/random_joke/RandomJokeTestData.json';
    $entity_data_source = file_get_contents($entity_data_file);
    $entity_data = json_decode($entity_data_source, true);

    $options = [];
    $options["entity"] = $entity_data["existing"];

    $client = JokeDeliverySDK::test($options, $extra);

    // Generate idmap.
    $idmap = [];
    foreach (["random_joke01", "random_joke02", "random_joke03"] as $k) {
        $idmap[$k] = strtoupper($k);
    }

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against synthetic
    // IDs from the fixture and 4xx's. Surface this so the test can skip.
    $entid_env_raw = getenv("JOKEDELIVERY_TEST_RANDOM_JOKE_ENTID");
    $idmap_overridden = $entid_env_raw !== false && str_starts_with(trim($entid_env_raw), "{");

    $env = Runner::env_override([
        "JOKEDELIVERY_TEST_RANDOM_JOKE_ENTID" => $idmap,
        "JOKEDELIVERY_TEST_LIVE" => "FALSE",
        "JOKEDELIVERY_TEST_EXPLAIN" => "FALSE",
    ]);

    $idmap_resolved = Helpers::to_map(
        $env["JOKEDELIVERY_TEST_RANDOM_JOKE_ENTID"]);
    if ($idmap_resolved === null) {
        $idmap_resolved = Helpers::to_map($idmap);
    }

    if ($env["JOKEDELIVERY_TEST_LIVE"] === "TRUE") {
        $merged_opts = Vs::merge([
            [
            ],
            $extra ?? [],
        ]);
        $client = new JokeDeliverySDK(Helpers::to_map($merged_opts));
    }

    $live = $env["JOKEDELIVERY_TEST_LIVE"] === "TRUE";
    return [
        "client" => $client,
        "data" => $entity_data,
        "idmap" => $idmap_resolved,
        "env" => $env,
        "explain" => $env["JOKEDELIVERY_TEST_EXPLAIN"] === "TRUE",
        "live" => $live,
        "synthetic_only" => $live && !$idmap_overridden,
        "now" => (int)(microtime(true) * 1000),
    ];
}
