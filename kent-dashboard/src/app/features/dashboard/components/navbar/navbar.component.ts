import { Component, Input, inject } from '@angular/core';
import { PreferencesService } from '@services/preferences.service';

@Component({
	selector: 'app-navbar',
	templateUrl: './navbar.component.html',
	styleUrls: ['./navbar.component.sass']
})
export class NavbarComponent {
	private _extentedView: boolean = false;

	preferencesService: PreferencesService = inject(PreferencesService);

	isExtented = () => this._extentedView;
	toggleExtend = () => this._extentedView = !this._extentedView;
}
