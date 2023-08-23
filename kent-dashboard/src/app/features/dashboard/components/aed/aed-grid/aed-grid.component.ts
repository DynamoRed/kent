import { Component, Input, inject } from '@angular/core';
import { Clark } from '@app/core/utils/models/clark.model';
import { AedService } from '@services/aed.service';

@Component({
	selector: 'app-aed-grid',
	templateUrl: './aed-grid.component.html',
	styleUrls: ['./aed-grid.component.sass']
})
export class AedGridComponent {
	@Input() clarks: Clark[] = [];
	aedService: AedService = inject(AedService);
}
