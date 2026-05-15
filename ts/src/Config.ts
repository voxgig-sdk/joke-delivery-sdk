
import { BaseFeature } from './feature/base/BaseFeature'
import { TestFeature } from './feature/test/TestFeature'



const FEATURE_CLASS: Record<string, typeof BaseFeature> = {
   test: TestFeature

}


class Config {

  makeFeature(this: any, fn: string) {
    const fc = FEATURE_CLASS[fn]
    const fi = new fc()
    // TODO: errors etc
    return fi
  }


  main = {
    name: 'ProjectName',
  }


  feature = {
     test:     {
      "options": {
        "active": false
      }
    }

  }


  options = {
    base: 'https://official-joke-api.appspot.com',

    auth: {
      prefix: 'Bearer',
    },

    headers: {
      "content-type": "application/json"
    },

    entity: {
      
      random_joke: {
      },

    }
  }


  entity = {
    "random_joke": {
      "fields": [
        {
          "name": "id",
          "req": true,
          "type": "`$INTEGER`",
          "active": true,
          "index$": 0
        },
        {
          "name": "punchline",
          "req": true,
          "type": "`$STRING`",
          "active": true,
          "index$": 1
        },
        {
          "name": "setup",
          "req": true,
          "type": "`$STRING`",
          "active": true,
          "index$": 2
        },
        {
          "name": "type",
          "req": true,
          "type": "`$STRING`",
          "active": true,
          "index$": 3
        }
      ],
      "name": "random_joke",
      "op": {
        "load": {
          "name": "load",
          "points": [
            {
              "method": "GET",
              "orig": "/random_joke",
              "parts": [
                "random_joke"
              ],
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "active": true,
              "args": {},
              "select": {},
              "index$": 0
            }
          ],
          "input": "data",
          "key$": "load"
        }
      },
      "relations": {
        "ancestors": []
      }
    }
  }
}


const config = new Config()

export {
  config
}

