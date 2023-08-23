import { Express } from "express";

import { ClarkRouter } from "@routes/clarks.routes";
import { StatusesRouter } from "@routes/statuses.routes";

export default class RouterUtil {
    static init(app: Express): void {
		const version = app.get('version');

		app.use('/' + version + '/clarks', ClarkRouter);
		app.use('/' + version + '/statuses', StatusesRouter);
    }
};
