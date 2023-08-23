import request from "supertest";

import app from "../src/server";
import ErrorsUtil from "../src/utils/errors.util";

describe("Basic api check at root", () => {
	test("Get welcoming message", async () => {
		const res = await request(app).get("/");
		expect(res.body).toEqual({status: "Welcome to our electrifying universe 🌩️"});
	});

	test("Check OAS exist and is accessible", async () => {
		const res = await request(app).get("/v1/oas");
		expect(res.body).not.toBeNull();
	});

	test("Go to unknown route -> then 404", async () => {
		const res = await request(app).get("/a_random_route");
		expect(res.body).toEqual(
			{ data:
				{ error: ErrorsUtil._404({}) }
			}
		);
	});
});
