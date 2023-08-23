import { Express } from "express";
import { Pool, QueryResult as PgQueryReturn } from 'pg';

import { QueryResult } from "@utils/interfaces/query/result.interface";
import { QueryError } from "@utils/interfaces/query/error.interface";
import { QueryReturn } from "@utils/interfaces/query/return.interface";
import ErrorsUtil from "@utils/errors.util";

export default class DatabaseUtil {
	static pool: Pool;

	static init(app: Express){
		this.pool = new Pool({
			host: app.get('dbHost'),
			user: app.get('dbUser'),
			password: app.get('dbPsswd'),
			port: app.get('dbPort'),
			max: 100,
			database: 'kentdb',
			connectionTimeoutMillis: 5000
		})
	}

    static async queryF<T>(func: string, values: (number|boolean|string|null)[], searched?:string) : Promise<QueryReturn<T>> {
		if(!func.match(/^f_[a-zA-Z_0-9]+$/)) throw new TypeError('Requested function does not have a correct name format');

        return new Promise<QueryReturn<T>>((resolve, reject) => {
            this.pool.query('SELECT kentdb.' + func + '(' + values.map((el, i) => '$' + (i+1)).join(',') + ')', values, (err: Error, res: PgQueryReturn<any>) => {
				if(err){
					const segs = err.message.match(/^\{\!\}(\{.*\})\{\!\}$/i);
					if(segs){
						const errJson: QueryError = JSON.parse(segs[1]);
						resolve({error: errJson});
					} else {
						console.error(err)
						resolve({error: ErrorsUtil._500({message: err.message})});
					}
				} else {
					if(res.rowCount === 1 && res.fields[0].name.startsWith('f_')){
						const resJson: QueryResult<T> = res.rows[0][res.fields[0].name];
						let finalRes: QueryReturn<T> = {};

						if(searched && resJson.data) finalRes.content = (resJson.data as any)[searched];
						else if(resJson.additional) finalRes.content = resJson.additional;
						if(resJson.inserted || resJson.updated || resJson.deleted){
							finalRes.stats = {
								inserted: resJson.inserted || 0,
								updated: resJson.updated || 0,
								deleted: resJson.deleted || 0
							}
						}

						resolve(finalRes);
					} else reject(new TypeError('Invalid database query return type'));
				}
            })
        });
    }
}
