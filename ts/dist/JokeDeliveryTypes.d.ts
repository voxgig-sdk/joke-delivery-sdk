export interface RandomJoke {
    id: number;
    punchline: string;
    setup: string;
    type: string;
}
export interface RandomJokeLoadMatch {
    id: number;
    punchline?: string;
    setup?: string;
    type?: string;
}
