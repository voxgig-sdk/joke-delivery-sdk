
import { BaseFeature } from './feature/base/BaseFeature'
import { TestFeature } from './feature/test/TestFeature'



const FEATURE_CLASS: Record<string, typeof BaseFeature> = {
   test: TestFeature,

}


class Config {

  makeFeature(this: any, fn: string) {
    const fc = FEATURE_CLASS[fn]
    const fi = new fc()
    // TODO: errors etc
    return fi
  }

  // False for a feature added at runtime via options.extend (station's
  // adopt path) - the constructor uses this to skip makeFeature for names
  // no generated class backs.
  hasFeature(this: any, fn: string) {
    return null != FEATURE_CLASS[fn]
  }


  main = {
    name: 'JokeDelivery',
        slug: "joke-delivery",
    version: "0.0.1",
    target: "ts",

  }


  feature = {
     test:     {
      "options": {
        "active": false
      },
      "transport": "base"
    },

  }


  options = {
    base: "https://official-joke-api.appspot.com",

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
          "short": "Unique identifier for the joke",
          "type": "`$INTEGER`"
        },
        {
          "name": "punchline",
          "req": true,
          "short": "The punchline or answer part of the joke",
          "type": "`$STRING`"
        },
        {
          "name": "setup",
          "req": true,
          "short": "The setup or question part of the joke",
          "type": "`$STRING`"
        },
        {
          "name": "type",
          "req": true,
          "short": "The category or type of joke",
          "type": "`$STRING`"
        }
      ],
      "name": "random_joke",
      "op": {
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "args": {},
              "kind": "http",
              "method": "GET",
              "orig": "/random_joke",
              "parts": [
                "random_joke"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
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

