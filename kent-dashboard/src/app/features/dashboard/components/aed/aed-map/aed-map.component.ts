import { AedService } from '@services/aed.service';
import { TopologyService } from '@services/topology.service';
import { Clark } from '@models/clark.model';
import { ClarkMarker } from '@utils/interfaces/clarkmarker.interface';
import { AedStatusTypes } from '@app/core/utils/enums/aed-status-types.enum';

import { Observable } from 'rxjs';
import { Component, Input, OnInit, inject } from '@angular/core';
import { TranslationService } from '@services/translation.service';
import { PreferencesService } from '@services/preferences.service';

@Component({
	selector: 'app-aed-map',
	templateUrl: './aed-map.component.html',
	styleUrls: ['./aed-map.component.sass']
})
export class AedMapComponent implements OnInit {

	@Input() clarks$!: Observable<Clark[]>;

	aedService: AedService = inject(AedService);
	preferencesService: PreferencesService = inject(PreferencesService);

	protected centerCoords: { lat: number; lng: number; } = { lat: 0, lng: 0 };

	markers: ClarkMarker[] = [];
	mapOptions: google.maps.MapOptions = {
		mapTypeId: 'hybrid',
		styles: [
			{
				featureType: "poi",
				stylers: [{ visibility: "off" }],
			},
		],
		maxZoom: 17,
		minZoom: 14,
		zoom: 15
	}

	constructor(private _topologyService: TopologyService, private _translationService: TranslationService){}

	ngOnInit(){
		this.mapOptions.zoom = this.preferencesService.isMobile() ? 14 : 15;
		this.mapOptions.minZoom = this.preferencesService.isMobile() ? 13 : 14;

		this._topologyService.getCenterCoords().subscribe(coords => this.centerCoords = coords);

		this.clarks$.subscribe(clarks => {
			this.markers = clarks.map(c => {
				return {
					serial: c.serial,
					position: {
						lat: c.location.latitude,
						lng: c.location.longitude
					},
					title: this.aedService.clarkElectrodesAreExpired(c.expiration) ? `${c.location.place} - ${this._translationService.get('_Expired_Pads_')}` : `${c.location.place} - ${this._translationService.get(c.status.details)} - ${this.aedService.translateStatusType(c.status.type)}`,
					options: {
						icon: this.aedService.clarkElectrodesAreExpired(c.expiration) ? this.aedService.getMatchingMapPin(AedStatusTypes.MAJOR_ERROR) : this.aedService.getMatchingMapPin(c.status.type)
					}
				}
			});
		});
	}
}
