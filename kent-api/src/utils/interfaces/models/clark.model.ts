import { Location } from "./location.model"

export interface Clark {
	id: string;
	serial: string;
	status: number;
	expiration: string;
	location: Location;
}
