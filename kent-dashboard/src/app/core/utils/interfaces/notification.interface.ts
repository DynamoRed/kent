import { Moment } from "moment";

export interface Notification {
	content: string;
	type: 'Success'|'Warning'|'Alert'|'Information';
	at: Moment;
	delay?: number;
}
