import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TranslationPipe } from './pipes/translation.pipe';
import { LowerPipe } from './pipes/lower.pipe';

@NgModule({
	declarations: [
		TranslationPipe,
		LowerPipe
	],
	exports: [
		TranslationPipe,
		LowerPipe
	],
	imports: [
		CommonModule
	]
})
export class SharedModule { }
