import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { lastValueFrom } from 'rxjs';

import { AppConfig } from '@utils/interfaces/config/app.interface';

@Injectable({
	providedIn: 'root'
})
export class ConfigService {
	private readonly _configUrl = "assets/config/app.config.json";
	private _config!: AppConfig;

	constructor(private _http: HttpClient){}

	load = async (): Promise<void> => this._config = await lastValueFrom(this._http.get<any>(this._configUrl));
	get = (key: keyof AppConfig): string => this._config[key];
}
