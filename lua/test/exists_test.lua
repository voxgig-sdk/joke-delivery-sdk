-- ProjectName SDK exists test

local sdk = require("joke-delivery_sdk")

describe("JokeDeliverySDK", function()
  it("should create test SDK", function()
    local testsdk = sdk.test(nil, nil)
    assert.is_not_nil(testsdk)
  end)
end)
