import { APP_INITIALIZER, NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { CoreModule } from '@core/core.module';
import { SharedModule } from '@shared/shared.module';

import { ConfigService } from '@services/config.service';
import { ApiService } from '@services/api.service';
import { TranslationService } from '@services/translation.service';
import { CookieService } from 'ngx-cookie-service';

export const loadConfig = (configService: ConfigService) => () => configService.load();
export const loadApi = (apiService: ApiService) => () => apiService.load();
export const loadTranslations = (translationService: TranslationService) => () => translationService.load();

@NgModule({
	declarations: [
		AppComponent,
	],
	imports: [
		BrowserModule,
		AppRoutingModule,

		CoreModule,
		SharedModule,
		BrowserAnimationsModule
	],
	providers: [
		CookieService,
		ConfigService,
		{
			provide: APP_INITIALIZER,
			useFactory: loadConfig,
			deps: [ConfigService],
			multi: true
		},
		ApiService,
		{
			provide: APP_INITIALIZER,
			useFactory: loadApi,
			deps: [ApiService],
			multi: true
		},
		TranslationService,
		{
			provide: APP_INITIALIZER,
			useFactory: loadTranslations,
			deps: [TranslationService],
			multi: true
		}
	],
	bootstrap: [AppComponent]
})
export class AppModule { }
