import { QueryError } from "./error.interface";

export interface QueryReturn<T> {
	content?: T;
	error?: QueryError;
	stats?: {
		inserted?: number;
		updated?: number;
		deleted?: number;
	};
}
