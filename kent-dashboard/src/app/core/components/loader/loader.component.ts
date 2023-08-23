import { Component, inject } from '@angular/core';
import { LoaderService } from '@services/loader.service';

@Component({
	selector: 'app-loader',
	templateUrl: './loader.component.html',
	styleUrls: ['./loader.component.sass']
})
export class LoaderComponent {
	protected loaderService: LoaderService = inject(LoaderService);
}
