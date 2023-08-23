import { Injectable } from '@angular/core';

@Injectable({
	providedIn: 'root'
})
export class PreferencesService {
	private _popup: boolean = false;

	popupIsOpened = () => this._popup;
	toggle = (status: boolean) => this._popup = status;

	isMobile = () => /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
}
