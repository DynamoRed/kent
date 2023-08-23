import { Pipe, PipeTransform } from '@angular/core';
import { TranslationService } from '@services/translation.service';

@Pipe({
	name: 'translate'
})
export class TranslationPipe implements PipeTransform {
	constructor(private _translationService: TranslationService) {}

	transform = (key: string): string => this._translationService.get(key);
}
