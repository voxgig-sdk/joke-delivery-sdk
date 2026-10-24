# RandomJoke entity test

require "minitest/autorun"
require "json"
require_relative "../JokeDelivery_sdk"
require_relative "runner"

class RandomJokeEntityTest < Minitest::Test
  # main.kit.test.live.strict is true (the default is true): a live
  # request that fails, or a live test missing an input it needs,
  # fails the test.
  # An account with no record for a test to read skips it either way.
  LIVE_STRICT = true

  def test_create_instance
    testsdk = JokeDeliverySDK.test(nil, nil)
    ent = testsdk.RandomJoke(nil)
    assert !ent.nil?
  end

  def test_validate
    cfg = JokeDeliveryConfig.shared_config
    unless cfg["feature"].is_a?(Hash) && cfg["feature"].key?("validate")
      skip("feature not present in this SDK: validate")
    end
    client = JokeDeliverySDK.test(nil, { "feature" => { "validate" => { "active" => true } } })
    err = assert_raises(StandardError) do
      client.RandomJoke(nil).load({ "id" => "x" }, nil)
    end
    assert_equal "validate_failed", err.code
  end

  def test_basic_flow
    setup = random_joke_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["load"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "random_joke." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    if setup[:live]
      Runner.live_miss(LIVE_STRICT, "Live entity test blocked: " + "the flow loads a random_joke record it has no list to find")
    end
    client = setup[:client]

    # Bootstrap entity data from existing test data.
    random_joke_ref01_data_raw = Vs.items(Helpers.to_map(
      Vs.getpath(setup[:data], "existing.random_joke")))
    random_joke_ref01_data = nil
    if random_joke_ref01_data_raw.length > 0
      random_joke_ref01_data = Helpers.to_map(random_joke_ref01_data_raw[0][1])
    end

    # LOAD
    random_joke_ref01_ent = client.RandomJoke(nil)
    random_joke_ref01_match_dt0 = {
      "id" => random_joke_ref01_data["id"],
    }
    random_joke_ref01_data_dt0_loaded = random_joke_ref01_ent.load(random_joke_ref01_match_dt0, nil)
    random_joke_ref01_data_dt0_load_result = Helpers.to_map(random_joke_ref01_data_dt0_loaded.respond_to?(:data_get) ? random_joke_ref01_data_dt0_loaded.data_get : random_joke_ref01_data_dt0_loaded)
    assert !random_joke_ref01_data_dt0_load_result.nil?
    assert_equal random_joke_ref01_data_dt0_load_result["id"], random_joke_ref01_data["id"]

  end
end

def random_joke_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "random_joke", "RandomJokeTestData.json")
  entity_data_source = File.read(entity_data_file, encoding: "UTF-8")
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = JokeDeliverySDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["random_joke01", "random_joke02", "random_joke03"],
    {
      "`$PACK`" => ["", {
        "`$KEY`" => "`$COPY`",
        "`$VAL`" => ["`$FORMAT`", "upper", "`$COPY`"],
      }],
    }
  )

  # Whether *_ENTID supplied the idmap, read before env_override consumes
  # it: without it, the ids a live flow binds are the fixture's synthetic ones.
  entid_env_raw = ENV["JOKE_DELIVERY_TEST_RANDOM_JOKE_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "JOKE_DELIVERY_TEST_RANDOM_JOKE_ENTID" => idmap,
    "JOKE_DELIVERY_TEST_LIVE" => "FALSE",
    "JOKE_DELIVERY_TEST_EXPLAIN" => "FALSE",
  })

  idmap_resolved = Helpers.to_map(
    env["JOKE_DELIVERY_TEST_RANDOM_JOKE_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["JOKE_DELIVERY_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      # FIRST, so the generated fields below win: sdk-test-control.json's
      # test.client.options adds to the live client, it does not redirect it.
      Runner.live_client_options,
      {
      },
      extra || {},
    ])
    client = JokeDeliverySDK.new(Helpers.to_map(merged_opts))
  end

  live = env["JOKE_DELIVERY_TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["JOKE_DELIVERY_TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end
