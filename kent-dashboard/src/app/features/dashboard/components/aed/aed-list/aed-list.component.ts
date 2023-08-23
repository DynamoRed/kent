import { Component, Input, inject } from '@angular/core';
import { Clark } from '@app/core/utils/models/clark.model';
import { AedService } from '@services/aed.service';

@Component({
	selector: 'app-aed-list',
	templateUrl: './aed-list.component.html',
	styleUrls: ['./aed-list.component.sass']
})
export class AedListComponent {
	@Input() clarks: Clark[] = [];
	aedService: AedService = inject(AedService);
}
