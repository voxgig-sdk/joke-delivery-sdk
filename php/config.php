<?php
declare(strict_types=1);

// JokeDelivery SDK configuration

class JokeDeliveryConfig
{
    public static function make_config(): array
    {
        return [
            "main" => [
                "name" => "JokeDelivery",
            ],
            "feature" => [
                "test" => [
          'options' => [
            'active' => false,
          ],
        ],
            ],
            "options" => [
                "base" => "https://official-joke-api.appspot.com",
                "headers" => [
          'content-type' => 'application/json',
        ],
                "entity" => [
                    "random_joke" => [],
                ],
            ],
            "entity" => [
        'random_joke' => [
          'fields' => [
            [
              'name' => 'id',
              'req' => true,
              'type' => '`$INTEGER`',
              'active' => true,
              'index$' => 0,
            ],
            [
              'name' => 'punchline',
              'req' => true,
              'type' => '`$STRING`',
              'active' => true,
              'index$' => 1,
            ],
            [
              'name' => 'setup',
              'req' => true,
              'type' => '`$STRING`',
              'active' => true,
              'index$' => 2,
            ],
            [
              'name' => 'type',
              'req' => true,
              'type' => '`$STRING`',
              'active' => true,
              'index$' => 3,
            ],
          ],
          'name' => 'random_joke',
          'op' => [
            'load' => [
              'name' => 'load',
              'points' => [
                [
                  'method' => 'GET',
                  'orig' => '/random_joke',
                  'parts' => [
                    'random_joke',
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'active' => true,
                  'args' => [],
                  'select' => [],
                  'index$' => 0,
                ],
              ],
              'input' => 'data',
              'key$' => 'load',
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
      ],
        ];
    }


    public static function make_feature(string $name)
    {
        require_once __DIR__ . '/features.php';
        return JokeDeliveryFeatures::make_feature($name);
    }
}
