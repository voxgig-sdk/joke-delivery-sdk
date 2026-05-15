-- JokeDelivery SDK error

local JokeDeliveryError = {}
JokeDeliveryError.__index = JokeDeliveryError


function JokeDeliveryError.new(code, msg, ctx)
  local self = setmetatable({}, JokeDeliveryError)
  self.is_sdk_error = true
  self.sdk = "JokeDelivery"
  self.code = code or ""
  self.msg = msg or ""
  self.ctx = ctx
  self.result = nil
  self.spec = nil
  return self
end


function JokeDeliveryError:error()
  return self.msg
end


function JokeDeliveryError:__tostring()
  return self.msg
end


return JokeDeliveryError
