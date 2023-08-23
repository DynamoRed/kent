import { Injectable } from '@angular/core';
import { HttpRequest, HttpHandler, HttpEvent, HttpInterceptor } from '@angular/common/http';
import { Observable, finalize, switchMap, tap, timer } from 'rxjs';

import { LoaderService } from '@services/loader.service';

@Injectable()
export class LoaderInterceptor implements HttpInterceptor {
	constructor(private _loaderService: LoaderService) {}

	intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
		this._loaderService.enableLoading();

		return next.handle(request).pipe(
			finalize(() => this._loaderService.disableLoading())
		);
	}
}
