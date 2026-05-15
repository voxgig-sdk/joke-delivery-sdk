<?php
declare(strict_types=1);

// JokeDelivery SDK utility: prepare_body

class JokeDeliveryPrepareBody
{
    public static function call(JokeDeliveryContext $ctx): mixed
    {
        if ($ctx->op->input === 'data') {
            return ($ctx->utility->transform_request)($ctx);
        }
        return null;
    }
}
