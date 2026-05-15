<?php
declare(strict_types=1);

// JokeDelivery SDK utility: prepare_path

class JokeDeliveryPreparePath
{
    public static function call(JokeDeliveryContext $ctx): string
    {
        $point = $ctx->point;
        $parts = [];
        if ($point) {
            $p = \Voxgig\Struct\Struct::getprop($point, 'parts');
            if (is_array($p)) {
                $parts = $p;
            }
        }
        return \Voxgig\Struct\Struct::join($parts, '/', true);
    }
}
