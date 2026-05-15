<?php
declare(strict_types=1);

// JokeDelivery SDK utility: result_body

class JokeDeliveryResultBody
{
    public static function call(JokeDeliveryContext $ctx): ?JokeDeliveryResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
