export interface Location {
	place: string;
	address: {
		number: number;
		street: string;
		city: string;
		postal: number;
		country: string;
	};
	latitude: number;
	longitude: number;
}
