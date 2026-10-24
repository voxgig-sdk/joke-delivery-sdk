import { RandomJokeEntity } from './entity/RandomJokeEntity';
export type * from './JokeDeliveryTypes';
import { inspect } from 'node:util';
import type { Context, Feature } from './types';
import { config } from './Config';
import { JokeDeliveryEntityBase } from './JokeDeliveryEntityBase';
import { Utility } from './utility/Utility';
import { BaseFeature } from './feature/base/BaseFeature';
declare const stdutil: Utility;
type DirectResult = {
    ok: false;
    err: any;
    status?: undefined;
    headers?: undefined;
    data?: undefined;
} | {
    ok: boolean;
    status: number;
    headers: any;
    data: any;
    err?: any;
};
declare class JokeDeliverySDK {
    _mode: string;
    _options: any;
    _utility: Utility;
    _features: Feature[];
    _rootctx: Context;
    constructor(options?: any);
    options(): any;
    utility(): any;
    prepare(fetchargs?: any): Promise<any>;
    direct(fetchargs?: any): Promise<DirectResult>;
    _rawRequest(fetchargs?: any): Promise<DirectResult>;
    graphql(query: string, variables?: any, ctrl?: any): Promise<any>;
    RandomJoke(entopts?: Record<string, any>): RandomJokeEntity;
    static test(testoptsarg?: any, sdkoptsarg?: any): JokeDeliverySDK;
    tester(testopts?: any, sdkopts?: any): JokeDeliverySDK;
    toJSON(): {
        name: string;
    };
    toString(): string;
    [inspect.custom](): string;
}
declare const SDK: typeof JokeDeliverySDK;
export { stdutil, config, BaseFeature, JokeDeliveryEntityBase, JokeDeliverySDK, SDK, };
export type { DirectResult };
