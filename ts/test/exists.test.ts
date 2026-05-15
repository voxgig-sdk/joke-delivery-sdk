
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { JokeDeliverySDK } from '..'


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await JokeDeliverySDK.test()
    equal(null !== testsdk, true)
  })

})
