import { Injectable } from '@angular/core';
import { ApiService } from '@services/api.service';
import { Coords } from '@utils/interfaces/coords.interface';
import { BehaviorSubject, Observable } from 'rxjs';

@Injectable({
	providedIn: 'root'
})
export class TopologyService {
	private _centerCoordsSubject: BehaviorSubject<Coords> = new BehaviorSubject<Coords>({lat: 0, lng: 0});
	private _centerCoords$: Observable<Coords> = this._centerCoordsSubject.asObservable();

	constructor(private _apiService: ApiService) {
		this._retrieveCenterCoords().subscribe(coords => this._centerCoordsSubject.next(coords.data.content));
	}

	private _retrieveCenterCoords = () => this._apiService.get<any>('clarkCenterCoords');
	getCenterCoords = (): Observable<Coords> => this._centerCoords$;
}
