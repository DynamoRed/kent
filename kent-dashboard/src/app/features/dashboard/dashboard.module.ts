import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SharedModule } from '@shared/shared.module';
import { GoogleMapsModule } from '@angular/google-maps'

import { OrdersComponent } from './pages/orders/orders.component';
import { AedComponent } from './pages/aed/aed.component';
import { DashboardRoutingModule } from './dashboard-routing.module';
import { NavbarComponent } from './components/navbar/navbar.component';
import { AedListComponent } from './components/aed/aed-list/aed-list.component';
import { AedGridComponent } from './components/aed/aed-grid/aed-grid.component';
import { AedDetailsComponent } from './components/aed/aed-details/aed-details.component';
import { AedMapComponent } from './components/aed/aed-map/aed-map.component';
import { AedDetailComponent } from './components/aed/aed-detail/aed-detail.component';
import { SettingsComponent } from './components/settings/settings.component';
import { NotificationsComponent } from './components/notifications/notifications.component';
import { NotificationComponent } from './components/notifications/notification/notification.component';
import { DashboardComponent } from './dashboard.component';
import { DetailsComponent } from './components/dashboard/details/details.component';
import { StatusComponent } from './components/dashboard/details/status/status.component';

@NgModule({
	declarations: [
		OrdersComponent,
		AedComponent,
		NavbarComponent,
		AedListComponent,
		AedGridComponent,
		AedDetailsComponent,
		AedMapComponent,
		AedDetailComponent,
  SettingsComponent,
  NotificationsComponent,
  NotificationComponent,
  DashboardComponent,
  DetailsComponent,
  StatusComponent
	],
	imports: [
		DashboardRoutingModule,

		CommonModule,
		SharedModule,

		GoogleMapsModule
	]
})
export class DashboardModule { }
