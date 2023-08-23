import { QueryError } from "./error.interface";

export interface QueryReturn<T> {
	content?: T;
	error?: QueryError;
}
