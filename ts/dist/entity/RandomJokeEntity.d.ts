import { JokeDeliveryEntityBase } from '../JokeDeliveryEntityBase';
import type { JokeDeliverySDK } from '../JokeDeliverySDK';
import type { Control } from '../types';
import type { RandomJoke, RandomJokeLoadMatch } from '../JokeDeliveryTypes';
declare class RandomJokeEntity extends JokeDeliveryEntityBase<RandomJoke> {
    constructor(client: JokeDeliverySDK, entopts: any);
    make(this: RandomJokeEntity): RandomJokeEntity;
    load(this: any, reqmatch?: RandomJokeLoadMatch, ctrl?: Control): Promise<RandomJokeEntity>;
}
export { RandomJokeEntity };
