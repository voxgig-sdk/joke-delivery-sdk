"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.JokeDeliveryError = void 0;
class JokeDeliveryError extends Error {
    isJokeDeliveryError = true;
    sdk = 'JokeDelivery';
    code;
    ctx;
    status = -1;
    // `err.notFound` rather than a magic number at every call site.
    get notFound() { return 404 === this.status; }
    constructor(code, msg, ctx) {
        super(msg);
        this.code = code;
        this.ctx = ctx;
    }
}
exports.JokeDeliveryError = JokeDeliveryError;
//# sourceMappingURL=JokeDeliveryError.js.map