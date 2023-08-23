import { Component, OnInit, inject } from '@angular/core';
import { AedService } from '@services/aed.service';

@Component({
	selector: 'app-dashboard-details',
	templateUrl: './details.component.html',
	styleUrls: ['./details.component.sass']
})
export class DetailsComponent implements OnInit {
	stats: {functional: number; major: number; minor: number; offline: number; } = { functional: 0, major: 0, minor: 0, offline: 0 }

	aedService: AedService = inject(AedService);

	ngOnInit(){
		this.aedService.getAllClarks().subscribe(clarks => {
			this.stats = {
				functional: clarks.filter(c => c.status.type === 0).length,
				major: clarks.filter(c => c.status.type === 1).length,
				minor: clarks.filter(c => c.status.type === 2).length,
				offline: clarks.filter(c => c.status.type === 3).length
			}
		})
	}

}
