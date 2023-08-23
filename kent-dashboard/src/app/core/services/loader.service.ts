import { Injectable } from '@angular/core';

@Injectable({
	providedIn: 'root'
})
export class LoaderService {
	private _loadingCount: number = 0;

	enableLoading = () => this._loadingCount++;
	disableLoading = () => this._loadingCount--;

	isLoading = () => this._loadingCount;
}
