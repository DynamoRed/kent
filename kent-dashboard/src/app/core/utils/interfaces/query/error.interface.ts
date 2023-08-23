export interface QueryError {
	code: number;
	error: string;
	additional: JSON;
	info: 'execko';
}
