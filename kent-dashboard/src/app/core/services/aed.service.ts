import { Injectable } from '@angular/core';
import { Clark } from '@models/clark.model';
import { Statuses } from '@models/status.model';
import { AedStatusTypes } from '@enums/aed-status-types.enum';
import { AedStatusUtil } from '@utils/aed-status.util';
import { StringUtil } from '@utils/string.util';
import { ApiService } from '@services/api.service';
import { TranslationService } from '@services/translation.service';
import { NotificationService } from '@services/notification.service';

import * as moment from 'moment';
import { BehaviorSubject, Observable, map } from 'rxjs';

@Injectable({
	providedIn: 'root'
})
export class AedService {
	private _selectedSerialSubject: BehaviorSubject<string> = new BehaviorSubject<string>('');
	private _selectedSerial$: Observable<string> = this._selectedSerialSubject.asObservable();

	private _clarksSubject: BehaviorSubject<Clark[]> = new BehaviorSubject<Clark[]>([]);
	private _clarks$: Observable<Clark[]> = this._clarksSubject.asObservable();

	private _statusesSubject: BehaviorSubject<Statuses[]> = new BehaviorSubject<Statuses[]>([]);
	private _statuses$: Observable<Statuses[]> = this._statusesSubject.asObservable();

	constructor(
		private _apiService: ApiService,
		private _translationService: TranslationService,
		private _notificationService: NotificationService
	){
		this.retrieveClarks().subscribe(clarks => this._clarksSubject.next((clarks.data.content as Clark[]).sort((a, b) => moment(a.expiration, 'YYYY-MM-DD').isBefore(moment(b.expiration, 'YYYY-MM-DD')) ? -1 : 1)));
		this.retrieveStatuses().subscribe(statuses => this._statusesSubject.next((statuses.data.content as Statuses[]).sort((a, b) => moment(b.at, 'YYYY-MM-DD[T]hh:mm:ss.ssssss').isBefore(moment(a.at, 'YYYY-MM-DD[T]hh:mm:ss.ssssss')) ? -1 : 1)));

		let oldSelectedSerial: string;
		setInterval(() => {
			this.retrieveClarks().subscribe(clarks => this._clarksSubject.next((clarks.data.content as Clark[]).sort((a, b) => moment(a.expiration, 'YYYY-MM-DD').isBefore(moment(b.expiration, 'YYYY-MM-DD')) ? -1 : 1)));
			this.retrieveStatuses().subscribe(statuses => this._statusesSubject.next((statuses.data.content as Statuses[]).sort((a, b) => moment(b.at, 'YYYY-MM-DD[T]hh:mm:ss.ssssss').isBefore(moment(a.at, 'YYYY-MM-DD[T]hh:mm:ss.ssssss')) ? -1 : 1)));

			if(oldSelectedSerial === this._selectedSerialSubject.getValue()) this._selectedSerialSubject.next(this._selectedSerialSubject.getValue());
			else oldSelectedSerial = this._selectedSerialSubject.getValue();
		}, 2.5*1000);
	}

	retrieveStatuses = () => this._apiService.get<any>('statuses');
	retrieveClarks = () => this._apiService.get<any>('clarks');
	retrieveClarkStatuses = (clarkId: string) => this._apiService.get<any>('clarkStatus', {uuid: clarkId});
	sendClarkRemplacementStatus = (clarkId: string) => this._apiService.get<any>('clarkReplacementStatus', {uuid: clarkId}).subscribe(() => {
		this._selectedSerialSubject.next(this._selectedSerialSubject.getValue());
		this._notificationService.show('_Status_Updated_', 'Success');
	});

	getAllStatuses = (): Observable<Statuses[]> => this._statuses$;
	getAllClarks = (): Observable<Clark[]> => this._clarks$;
	getClarkBySerial = (serial: string): Observable<Clark | undefined> => this._clarks$.pipe(
		map((clarks) => clarks.find(c => c.serial.toUpperCase() === serial.toUpperCase()))
	);
	getClarkById = (uuid: string): Observable<Clark | undefined> => this._clarks$.pipe(
		map((clarks) => clarks.find(c => c.id.toUpperCase() === uuid.toUpperCase()))
	);
	filterClarks = (search: string): Observable<Clark[]> => this._clarks$.pipe(
		map((clarks) =>
			clarks.filter(c =>
				c.serial.toUpperCase().includes(search.toUpperCase()) ||
				StringUtil.removeAccents(this.clarkCompleteAddress(c).toUpperCase()).replaceAll(' ', '').includes(StringUtil.removeAccents(search.toUpperCase()).replaceAll(' ', '')) ||
				StringUtil.removeAccents(c.location.place.toUpperCase()).replaceAll(' ', '').includes(StringUtil.removeAccents(search.toUpperCase()).replaceAll(' ', ''))
			)
		)
	);
	filterClarksByStatus = (statusType: AedStatusTypes | undefined): Observable<Clark[]> => this._clarks$.pipe(
		map(clarks => statusType === undefined ? clarks : clarks.filter(c => (c.status.type === statusType || (statusType === 2 && this.clarkElectrodesAreExpired(c.expiration))) && !(statusType === 0 && this.clarkElectrodesAreExpired(c.expiration))))
	);
	filterClarksByExpiration = (active: boolean): Observable<Clark[]> => this._clarks$.pipe(
		map(clarks => active ? clarks.filter(c => this.clarkElectrodesAreExpired(c.expiration)) : clarks)
	);

	getStatusTypes = (): typeof AedStatusTypes => AedStatusTypes;
	getStatusTypesValues = (): any[] => Object.values(AedStatusTypes).filter(s => !isNaN(Number(s)));

	formatDate = (date: string, detailled?: boolean) => detailled ? moment(date).format(this._translationService.get('_Detailled_Date_Format_')) :  moment(date).format(this._translationService.get('_Date_Format_'));
	clarkCompleteAddress = (clark: Clark): string => `${clark.location.address.number} ${clark.location.address.street}, ${clark.location.address.postal} ${clark.location.address.city}, ${clark.location.address.country}`;
	clarkElectrodesAreExpired = (expirationDate: string): boolean => moment(expirationDate, 'YYYY-MM-DD').isBefore(moment());
	translateStatusType = (statusType: AedStatusTypes): string => (this._translationService.get(AedStatusUtil.toText(statusType)));
	statusTypeToValue = (statusType: AedStatusTypes): any => statusType === AedStatusTypes.FUNCTIONAL ? 'functional' : statusType === AedStatusTypes.MINOR_ERROR ? 'warning' : statusType === AedStatusTypes.MAJOR_ERROR ? 'alert' : 'offline';
	getMatchingMapPin = (statusType: AedStatusTypes): string => `/assets/medias/pin-${this.statusTypeToValue(statusType)}.png`;

	getSelectedSerial = (): Observable<string> => this._selectedSerial$;
	setSelectedSerial = (serial: string): void => this._selectedSerialSubject.next(serial);
}
