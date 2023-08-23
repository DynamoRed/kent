import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { v4 as uuidv4 } from 'uuid';

import { Notification } from '@utils/interfaces/notification.interface'
import * as moment from 'moment';

@Injectable({
	providedIn: 'root'
})
export class NotificationService {
	private _notifications: Map<string, Notification> = new Map<string, Notification>();
	private _notificationsSubject = new Subject<Map<string, Notification>>();
	private _notifications$ = this._notificationsSubject.asObservable();

	show = (content: string, type?: 'Success'|'Warning'|'Alert'|'Information', delay?: number) => {
		const notificationUuid = uuidv4();

		console.log('Display new notification -> ', content)

		this._notifications.set(notificationUuid, {content: content, type: type || 'Information', delay: delay || 5, at: moment()});
		this._notificationsSubject.next(this._notifications);

		setTimeout(() => {
			this._notifications.delete(notificationUuid);
			this._notificationsSubject.next(this._notifications);
		}, (delay || 3)*1000)
	}

	notifications = (): Observable<Map<string, Notification>> => this._notifications$;
	get = (uuid: string) => this._notifications.get(uuid);
}
