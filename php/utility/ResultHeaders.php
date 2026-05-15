<?php
declare(strict_types=1);

// JokeDelivery SDK utility: result_headers

class JokeDeliveryResultHeaders
{
    public static function call(JokeDeliveryContext $ctx): ?JokeDeliveryResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
