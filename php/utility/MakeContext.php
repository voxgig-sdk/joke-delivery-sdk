<?php
declare(strict_types=1);

// JokeDelivery SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class JokeDeliveryMakeContext
{
    public static function call(array $ctxmap, ?JokeDeliveryContext $basectx): JokeDeliveryContext
    {
        return new JokeDeliveryContext($ctxmap, $basectx);
    }
}
