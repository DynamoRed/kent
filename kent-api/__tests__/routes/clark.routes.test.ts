import request from "supertest";

import app from "../../src/server";
import ErrorsUtil from "../../src/utils/errors.util";

const baseRoute = "/v1/clarks";
const testUuidValid = "875f6eb1-271b-4080-93c5-966987577a0d";

describe("Check routes for clarks", () => {
	test("GET List all -> 200", async () => {
		const res = await request(app).get(baseRoute);
		expect(res.statusCode).toEqual(200);
		expect(res.body).not.toBeNull();
	});

	test("GET Get center coords -> 200", async () => {
		const res = await request(app).get(baseRoute + "/center");
		expect(res.statusCode).toEqual(200);
	});

	test("GET Get one -> 200", async () => {
		const res = await request(app).get(baseRoute + "/" + testUuidValid);
		expect(res.statusCode).toEqual(200);
		expect(res.body['data']['content']['serial']).toEqual('CLA87561271');
		expect(res.body['data']['content']['id']).toEqual(testUuidValid);
	});

	test("GET Get clark statuses -> 200", async () => {
		const res = await request(app).get(baseRoute + "/" + testUuidValid + "/status");
		expect(res.statusCode).toEqual(200);
	});

	test("GET Get one with invalid ID -> 412", async () => {
		const res = await request(app).get(baseRoute + "/invalid_uuid");
		expect(res.body).toEqual(
			{ data:
				{ error: ErrorsUtil._412({}) }
			}
		);
	});

	test("PATCH Not allowed method on base -> 405", async () => {
		const res = await request(app).patch(baseRoute);
		expect(res.body).toEqual(
			{ data:
				{ error: ErrorsUtil._405({}) }
			}
		);
	});

	test("PATCH Not allowed method on /center -> 405", async () => {
		const res = await request(app).patch(baseRoute + '/center');
		expect(res.body).toEqual(
			{ data:
				{ error: ErrorsUtil._405({}) }
			}
		);
	});

	test("PATCH Not allowed method on /:id -> 405", async () => {
		const res = await request(app).patch(baseRoute + "/" + testUuidValid);
		expect(res.body).toEqual(
			{ data:
				{ error: ErrorsUtil._405({}) }
			}
		);
	});
});
