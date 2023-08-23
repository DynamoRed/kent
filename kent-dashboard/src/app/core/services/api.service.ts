import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, lastValueFrom } from 'rxjs';

import { EndpointsConfig } from '@utils/interfaces/config/endpoints.interface';
import { ConfigService } from '@services/config.service';
import { NotificationService } from './notification.service';

@Injectable({
	providedIn: 'root'
})
export class ApiService {
	private readonly _endpointsUrl = "assets/config/endpoints.config.json";
	private _endpoints!: EndpointsConfig;

	constructor(
		private _configService: ConfigService,
		private _http: HttpClient
	){}

	load = async (): Promise<void> => this._endpoints = await lastValueFrom(this._http.get<any>(this._endpointsUrl));

	private getEndpoint(key: keyof EndpointsConfig, params?: {[k: string]: string}): string {
		let endpoint = this._endpoints[key];
		for(const k in params) endpoint = endpoint.replace(`:${k}`, params[k]);
		return endpoint;
	}

	private formatUrl = (endpoint: string) => `${this._configService.get('api')}/v${this._configService.get('apiVersion')}${endpoint}`;

	get = <T>(endpointKey: keyof EndpointsConfig, params?: { [key: string]: string }): Observable<T> =>this._http.get<T>(this.formatUrl(this.getEndpoint(endpointKey, params)));
	post = <T>(endpointKey: keyof EndpointsConfig, params: { [key: string]: string }, data: any): Observable<T> => this._http.post<T>(this.formatUrl(this.getEndpoint(endpointKey, params)), data);
	put = <T>(endpointKey: keyof EndpointsConfig, params: { [key: string]: string }, data: any): Observable<T> => this._http.put<T>(this.formatUrl(this.getEndpoint(endpointKey, params)), data);
	delete = <T>(endpointKey: keyof EndpointsConfig, params: { [key: string]: string }): Observable<T> => this._http.delete<T>(this.formatUrl(this.getEndpoint(endpointKey, params)));
}
