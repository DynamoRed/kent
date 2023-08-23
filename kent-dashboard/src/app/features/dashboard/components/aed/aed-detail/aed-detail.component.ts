import { AedStatusTypes } from '@enums/aed-status-types.enum';
import { Clark } from '@models/clark.model';
import { Statuses } from '@models/status.model';
import { AedService } from '@services/aed.service';
import { TranslationService } from '@services/translation.service';
import { NotificationService } from '@services/notification.service';

import { Component, OnInit, inject } from '@angular/core';

@Component({
	selector: 'app-aed-detail',
	templateUrl: './aed-detail.component.html',
	styleUrls: ['./aed-detail.component.sass']
})
export class AedDetailComponent implements OnInit {

	aedService: AedService = inject(AedService);
	protected clark: Clark|undefined = undefined;
	protected statuses: Statuses[]|undefined = undefined;

	marker: any;
	mapOptions: google.maps.MapOptions = {
		mapTypeId: 'hybrid',
		styles: [
			{
				featureType: "poi",
				stylers: [{ visibility: "off" }],
			},
		],
		maxZoom: 18,
		minZoom: 15,
		zoom: 17,
		center: { lat: 48.943, lng: 2.68 },
		streetViewControl: false
	};

	constructor(private _translationService: TranslationService, private _notificationService: NotificationService){}

	ngOnInit(){
		this.aedService.getSelectedSerial().subscribe(serial => {
			this.aedService.getClarkBySerial(serial).subscribe(clark => this.clark = clark);
			if(!this.clark) return;

			this.aedService.retrieveClarkStatuses(this.clark.id).subscribe(statuses => this.statuses = statuses.data.content);
			this.mapOptions.center = { lat: this.clark.location.latitude || 48.943, lng: this.clark.location.longitude || 2.68 };
			this.marker = {
				serial: this.clark.serial,
				position: {
					lat: this.clark.location.latitude || 48.943,
					lng: this.clark.location.longitude || 2.68
				},
				title: this.aedService.clarkElectrodesAreExpired(this.clark.expiration) ? `${this.clark.location.place} - ${this._translationService.get('_Expired_Pads_')}` : `${this.clark.location.place}`,
				options: {
					icon: this.aedService.clarkElectrodesAreExpired(this.clark.expiration) ? this.aedService.getMatchingMapPin(AedStatusTypes.MAJOR_ERROR) : this.aedService.getMatchingMapPin(this.clark.status.type)
				}
			};
		});
	}

	closePopup = (): void => this.aedService.setSelectedSerial('');
	replacePads = () => {
		this.aedService.sendClarkRemplacementStatus(this.clark?.id || '');
		this._notificationService.show('_Status_Updated_', 'Success');
	}
}
