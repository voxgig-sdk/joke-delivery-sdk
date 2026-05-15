<?php
declare(strict_types=1);

// JokeDelivery SDK utility: feature_add

class JokeDeliveryFeatureAdd
{
    public static function call(JokeDeliveryContext $ctx, mixed $f): void
    {
        $ctx->client->features[] = $f;
    }
}
