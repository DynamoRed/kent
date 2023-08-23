import { Location } from "./location.model"
import { Statuses } from "./status.model";

export interface Clark {
	id: string;
	serial: string;
	status: Statuses;
	expiration: string;
	location: Location;
}
