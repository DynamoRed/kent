import { Routes, RouterModule } from '@angular/router';

import { AedComponent } from './pages/aed/aed.component';
import { OrdersComponent } from './pages/orders/orders.component';
import { DashboardComponent } from './dashboard.component';

const routes: Routes = [
	{
		path: '',
		redirectTo: 'home',
		pathMatch: 'full'
	},
	{
		path: 'home',
		component: DashboardComponent
	},
	{
		path: 'aed',
		component: AedComponent
	},
	{
		path: 'orders',
		component: OrdersComponent
	}
];

export const DashboardRoutingModule = RouterModule.forChild(routes);
