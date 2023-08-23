import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { CookieService } from 'ngx-cookie-service';

type LanguageCode = 'fr'|'en';
type Translations = {[k in LanguageCode]: {[k: string]: string}};

@Injectable({
	providedIn: 'root'
})
export class TranslationService {
    private _languages: LanguageCode[] = ['fr', 'en'];
	private _selectedLang: LanguageCode;
	private _translations: Translations;

	constructor(private _http: HttpClient, private _cookieService: CookieService){
		this._translations = this._initTranslations();
		const cookiedLang = this._cookieService.get('_preferred_lang') as LanguageCode;
		this._selectedLang = this._languages.indexOf(cookiedLang) >= 0 ? cookiedLang : 'en';
	}

	private _initTranslations = () => {
		const empty: Partial<Translations> = {};
		for(const l of this._languages) empty[l] = {};
		return empty as Translations;
	}

	setLang = (lang: LanguageCode) => {
		this._selectedLang = lang;
		this._cookieService.set('_preferred_lang', lang);
		window.location.reload();
	}
	getLangName = (lang: LanguageCode) => this._translations[lang]['_Lang_Name_'];
	getLang = (): LanguageCode => this._selectedLang;
	getLangs = (): LanguageCode[] => this._languages;

	loadTranslations = (lang: string): Observable<any> => this._http.get(`assets/langs/${lang}.json`);
	load = () => this._languages.forEach(lang => this.loadTranslations(lang).subscribe(translations => this._translations[lang] = translations));

	get = (key: string): string => this._translations[this._selectedLang][key] || 'No translation found';
}
