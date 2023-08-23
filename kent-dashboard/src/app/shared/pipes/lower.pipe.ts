import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
	name: 'lower'
})
export class LowerPipe implements PipeTransform {
	transform = (str: string): string => str.toLowerCase();
}
