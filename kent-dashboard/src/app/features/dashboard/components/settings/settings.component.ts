import { Component, Input, inject } from '@angular/core';
import { PreferencesService } from '@services/preferences.service';
import { TranslationService } from '@services/translation.service';

@Component({
	selector: 'app-settings',
	templateUrl: './settings.component.html',
	styleUrls: ['./settings.component.sass']
})
export class SettingsComponent {
	@Input() opened: boolean = false;

	translationService: TranslationService = inject(TranslationService);
	preferencesService: PreferencesService = inject(PreferencesService);
}
