<?php
declare(strict_types=1);

// JokeDelivery SDK base feature

class JokeDeliveryBaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    // Positions this feature when added via the client `extend` option:
    // "__before__" / "__after__" / "__replace__" name an already-added
    // feature (mirrors the ts feature `_options`). Declared so setting it
    // on an extension instance avoids the dynamic-property deprecation.
    public ?array $_options = null;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(JokeDeliveryContext $ctx, array $options): void {}
    public function PostConstruct(JokeDeliveryContext $ctx): void {}
    public function PostConstructEntity(JokeDeliveryContext $ctx): void {}
    public function SetData(JokeDeliveryContext $ctx): void {}
    public function GetData(JokeDeliveryContext $ctx): void {}
    public function GetMatch(JokeDeliveryContext $ctx): void {}
    public function SetMatch(JokeDeliveryContext $ctx): void {}
    public function PrePoint(JokeDeliveryContext $ctx): void {}
    public function PreSpec(JokeDeliveryContext $ctx): void {}
    public function PreRequest(JokeDeliveryContext $ctx): void {}
    public function PreResponse(JokeDeliveryContext $ctx): void {}
    public function PreResult(JokeDeliveryContext $ctx): void {}
    public function PreDone(JokeDeliveryContext $ctx): void {}
    public function PreUnexpected(JokeDeliveryContext $ctx): void {}
}
