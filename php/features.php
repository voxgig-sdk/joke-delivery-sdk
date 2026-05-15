<?php
declare(strict_types=1);

// JokeDelivery SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';


class JokeDeliveryFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new JokeDeliveryBaseFeature();
            case "test":
                return new JokeDeliveryTestFeature();
            default:
                return new JokeDeliveryBaseFeature();
        }
    }
}
