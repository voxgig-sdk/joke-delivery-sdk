import { Context } from './Context';
declare class JokeDeliveryError extends Error {
    isJokeDeliveryError: boolean;
    sdk: string;
    code: string;
    ctx: Context;
    status: number;
    get notFound(): boolean;
    constructor(code: string, msg: string, ctx: Context);
}
export { JokeDeliveryError };
