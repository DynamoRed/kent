import { Injectable } from '@angular/core';
import {
	HttpRequest,
	HttpHandler,
	HttpEvent,
	HttpInterceptor,
	HttpErrorResponse
} from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';

import { NotificationService } from '@services/notification.service';

@Injectable()
export class ErrorInterceptor implements HttpInterceptor {

	constructor(private _notificationService: NotificationService){}

	intercept(
		request: HttpRequest<any>,
		next: HttpHandler
	): Observable<HttpEvent<any>> {
		return next.handle(request).pipe(
			catchError((error: HttpErrorResponse) => {
				this._notificationService.show('_Loading_Failed_', 'Alert', 5);
				return throwError(error);
			})
		);
	}
}
