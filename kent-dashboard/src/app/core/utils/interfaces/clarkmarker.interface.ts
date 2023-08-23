export interface ClarkMarker {
	serial: string;
	position: {
		lat: number;
		lng: number;
	};
	title: string;
	options: {
		icon: string;
	};
}
