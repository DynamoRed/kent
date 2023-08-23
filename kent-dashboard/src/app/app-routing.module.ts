import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { PageNotFoundComponent } from '@core/components/page-not-found/page-not-found.component';

const routes: Routes = [
	{
		path: '',
		redirectTo: '/dashboard/home',
		pathMatch: 'full'
	},
	{
		path: 'dashboard',
		loadChildren: () => import('@features/dashboard/dashboard.module').then(m => m.DashboardModule)
	},
	{
		path: 'page-not-found',
		component: PageNotFoundComponent
	},
	{
		path: '**',
		redirectTo: '/page-not-found',
		pathMatch: 'full'
	}
];

@NgModule({
	imports: [RouterModule.forRoot(routes, {
		useHash: false
	})],
	exports: [RouterModule],
	providers: []
})
export class AppRoutingModule { }
