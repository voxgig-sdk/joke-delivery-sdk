<?php
declare(strict_types=1);

// Typed models for the JokeDelivery SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** RandomJoke entity data model. */
class RandomJoke
{
    public int $id;
    public string $punchline;
    public string $setup;
    public string $type;
}

/** Request payload for RandomJoke#load. */
class RandomJokeLoadMatch
{
    public int $id;
    public ?string $punchline = null;
    public ?string $setup = null;
    public ?string $type = null;
}

