
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { JokeDeliverySDK } from '..'


describe('exists', async () => {

  test('test-mode', () => {
    const testsdk = JokeDeliverySDK.test()
    equal(testsdk instanceof JokeDeliverySDK, true,
      'JokeDeliverySDK.test() must return a client synchronously')
  })

})
