import { Component, OnInit, inject } from '@angular/core';

import { AedService } from '@services/aed.service';
import { Statuses } from '@models/status.model';
import { PreferencesService } from '@services/preferences.service';

@Component({
	selector: 'app-dashboard-details-status',
	templateUrl: './status.component.html',
	styleUrls: ['./status.component.sass']
})
export class StatusComponent implements OnInit {
	statuses: Statuses[] = [];
	aedService: AedService = inject(AedService);
	preferencesService: PreferencesService = inject(PreferencesService);

	ngOnInit(){
		this.aedService.getAllStatuses().subscribe(statuses => this.statuses = statuses);
	}

	getClarkSerial = (uuid: string): string => 'CLA' + uuid.replace(/[^0-9]/g, '').substring(0, 8);
}
