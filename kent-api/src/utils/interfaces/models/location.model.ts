export interface Location {
	place: string;
	address: {
		number: number;
		street: string;
		city: string;
		postal: number;
		country: string;
	};
	lat: number;
	lng: number;
}
