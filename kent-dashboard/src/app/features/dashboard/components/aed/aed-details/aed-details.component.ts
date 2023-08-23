import { AedService } from '@services/aed.service';
import { Clark } from '@models/clark.model';
import { AedStatusTypes } from '@enums/aed-status-types.enum';
import { PreferencesService } from '@services/preferences.service';

import { Component, Input, OnInit, inject } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';

@Component({
	selector: 'app-aed-details',
	templateUrl: './aed-details.component.html',
	styleUrls: ['./aed-details.component.sass']
})
export class AedDetailsComponent implements OnInit {
	@Input() loading: boolean = true;

	protected style: 'Grid'|'List'|'Map' = "List";
	protected filter: AedStatusTypes | undefined = undefined;
	protected expiredFilter: boolean = false;

	protected clarksSubject: BehaviorSubject<Clark[]> = new BehaviorSubject<Clark[]>([]);
	clarks$: Observable<Clark[]> = this.clarksSubject.asObservable();
	clarks: Clark[] = [];

	aedService: AedService = inject(AedService);
	preferencesService: PreferencesService = inject(PreferencesService);

	ngOnInit(){
		this.style = this.preferencesService.isMobile() ? 'Grid' : 'List';
		this.clarks$.subscribe(clarks => this.clarks = clarks);
		this.aedService.getAllClarks().subscribe(clarks => {
			this.clarks = clarks;
			this.clarksSubject.next(clarks);
		})
	}

	enableView = (style: 'Grid'|'List'|'Map'): string => this.style = style;
	selectFilter = (filter: AedStatusTypes) => {
		this.expiredFilter = false;
		this.filter === filter ? this.filter = undefined : this.filter = filter;
		this.aedService.filterClarksByStatus(this.filter).subscribe(clarks => this.clarksSubject.next(clarks));
	}
	updateSearch = (event: Event) => this.aedService.filterClarks((event.target as HTMLInputElement).value).subscribe(clarks => this.clarksSubject.next(clarks));
	toggleExpiredFilter = () => {
		this.filter = undefined;
		this.expiredFilter = !this.expiredFilter;
		this.aedService.filterClarksByExpiration(this.expiredFilter).subscribe(clarks => this.clarksSubject.next(clarks));
	};
}
