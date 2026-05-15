
import { Context } from './Context'


class JokeDeliveryError extends Error {

  isJokeDeliveryError = true

  sdk = 'JokeDelivery'

  code: string
  ctx: Context

  constructor(code: string, msg: string, ctx: Context) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

export {
  JokeDeliveryError
}

