"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const node_path_1 = __importDefault(require("node:path"));
const Fs = __importStar(require("node:fs"));
const node_test_1 = require("node:test");
const node_assert_1 = __importDefault(require("node:assert"));
const live_runner_1 = require("../../live-runner");
const live_entity_1 = require("../../live-entity");
const __1 = require("../../..");
const utility_1 = require("../../utility");
(0, utility_1.loadEnvLocal)(__dirname + '/../../../.env.local');
(0, node_test_1.describe)('RandomJokeEntity', async () => {
    // Per-test live pacing. Delay is read from sdk-test-control.json's
    // `test.live.delayMs`; only sleeps when JOKE_DELIVERY_TEST_LIVE=TRUE.
    (0, node_test_1.afterEach)((0, utility_1.liveDelay)('JOKE_DELIVERY_TEST_LIVE'));
    (0, node_test_1.test)('instance', async () => {
        const testsdk = __1.JokeDeliverySDK.test();
        const ent = testsdk.RandomJoke();
        (0, node_assert_1.default)(null != ent);
    });
    (0, node_test_1.test)('basic', async (t) => {
        const live = 'TRUE' === process.env.JOKE_DELIVERY_TEST_LIVE;
        for (const op of ['load']) {
            if (!live && (0, utility_1.maybeSkipControl)(t, 'entityOp', 'random_joke.' + op, live))
                return;
        }
        const setup = basicSetup();
        if (setup.live) {
            return (0, live_entity_1.runLiveEntity)(setup, { "active": true, "alias": { "field": {} }, "fields": { "id": { "a": true, "h": "Id", "n": "id", "r": true, "sh": "Unique identifier for the joke", "t": "`$INTEGER`", "key$": "id", "index$": 0 }, "punchline": { "a": true, "h": "Punchline", "n": "punchline", "r": true, "sh": "The punchline or answer part of the joke", "t": "`$STRING`", "key$": "punchline", "index$": 1 }, "setup": { "a": true, "h": "Setup", "n": "setup", "r": true, "sh": "The setup or question part of the joke", "t": "`$STRING`", "key$": "setup", "index$": 2 }, "type": { "a": true, "h": "Type", "n": "type", "r": true, "sh": "The category or type of joke", "t": "`$STRING`", "key$": "type", "index$": 3 } }, "id": { "field": "id", "name": "id" }, "name": "random_joke", "op": { "load": { "input": "data", "name": "load", "points": [{ "a": true, "co": { "id": "GET /random_joke", "source": "openapi3", "version": 2 }, "g": {}, "k": "http", "m": "GET", "o": "/random_joke", "q": {}, "r": {}, "s": [{ "lit": "random_joke" }], "t": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "load" } }, "relations": { "ancestors": [] }, "key$": "random_joke", "name__orig": "random_joke", "Name": "RandomJoke", "name_": "random_joke", "name-": "random-joke", "NAME": "RANDOM_JOKE", "index$": 0 }, { "active": true, "entity": "random_joke", "key$": "BasicRandomJokeFlow", "kind": "basic", "name": "BasicRandomJokeFlow", "param": {}, "step": [{ "a": true, "d": {}, "i": { "ref": "random_joke_ref01", "srcdatavar": "random_joke_ref01_data", "suffix": "_dt0" }, "m": {}, "o": "load", "s": [], "v": [{ "apply": "TextFieldMark", "def": { "mark": "Mark01-random_joke_ref01" } }], "index$": 0 }] }, 'RandomJoke', { "GET /random_joke": { "protocol": "http", "operationId": "getRandomJoke", "responses": { "200": { "description": "Successful response with a random joke", "content": { "application/json": { "schema": { "type": "object", "required": ["type", "setup", "punchline", "id"], "properties": { "type": { "description": "The category or type of joke", "example": "general", "key$": "type", "type": "string" }, "setup": { "description": "The setup or question part of the joke", "example": "What did the dog say to the two trees?", "key$": "setup", "type": "string" }, "punchline": { "description": "The punchline or answer part of the joke", "example": "Bark bark.", "key$": "punchline", "type": "string" }, "id": { "description": "Unique identifier for the joke", "example": 170, "key$": "id", "type": "integer" } }, "x-ref": "#/components/schemas/Joke", "index$": 0 }, "example": { "type": "general", "setup": "What did the dog say to the two trees?", "punchline": "Bark bark.", "id": 170 } } } }, "500": { "description": "Internal server error" } }, "parameters": [], "securitySource": "unspecified" } });
        }
        const client = setup.client;
        const struct = setup.struct;
        const isempty = struct.isempty;
        const select = struct.select;
        let random_joke_ref01_data = Object.values(setup.data.existing.random_joke)[0];
        // LOAD
        const random_joke_ref01_ent = client.RandomJoke();
        const random_joke_ref01_match_dt0 = {};
        random_joke_ref01_match_dt0.id = random_joke_ref01_data.id;
        const random_joke_ref01_data_dt0 = (await random_joke_ref01_ent.load(random_joke_ref01_match_dt0)).data();
        (0, node_assert_1.default)(random_joke_ref01_data_dt0.id === random_joke_ref01_data.id);
    });
});
function basicSetup(extra) {
    // TODO: fix test def options
    const options = {}; // null
    // TODO: needs test utility to resolve path
    const entityDataFile = node_path_1.default.resolve(__dirname, '../../../../.sdk/test/entity/random_joke/RandomJokeTestData.json');
    // TODO: file ready util needed?
    const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8');
    // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
    const entityData = JSON.parse(entityDataSource);
    options.entity = entityData.existing;
    let client = __1.JokeDeliverySDK.test(options, extra);
    const struct = client.utility().struct;
    const merge = struct.merge;
    const transform = struct.transform;
    let idmap = transform(['random_joke01', 'random_joke02', 'random_joke03'], {
        '`$PACK`': ['', {
                '`$KEY`': '`$COPY`',
                '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
            }]
    });
    const env = (0, utility_1.envOverride)({
        'JOKE_DELIVERY_TEST_RANDOM_JOKE_ENTID': idmap,
        'JOKE_DELIVERY_TEST_LIVE': 'FALSE',
        'JOKE_DELIVERY_TEST_EXPLAIN': 'FALSE',
    });
    idmap = env['JOKE_DELIVERY_TEST_RANDOM_JOKE_ENTID'];
    const live = 'TRUE' === env.JOKE_DELIVERY_TEST_LIVE;
    const transport = (0, live_runner_1.createLiveTransport)();
    if (live) {
        const rawIds = process.env['JOKE_DELIVERY_TEST_RANDOM_JOKE_ENTID'];
        idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {};
        if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
            throw new Error('Live ENTID must be a JSON object');
        }
        client = new __1.JokeDeliverySDK(merge([
            // FIRST, so the generated fields below win: sdk-test-control.json's
            // test.client.options adds to the live client, it does not redirect it.
            (0, utility_1.liveClientOptions)(),
            {},
            // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
            // last entry is undefined, and basicSetup is normally called with no
            // argument at all - so a bare 'extra' silently discarded the apikey
            // and server values above and handed the SDK undefined. Harmless
            // while there was nothing in that object; not harmless now.
            extra || {},
            { system: { fetch: transport.fetch } }
        ]));
    }
    const setup = {
        idmap,
        env,
        options,
        client,
        struct,
        data: entityData,
        explain: 'TRUE' === env.JOKE_DELIVERY_TEST_EXPLAIN,
        live,
        transport,
        now: Date.now(),
    };
    return setup;
}
//# sourceMappingURL=RandomJokeEntity.test.js.map