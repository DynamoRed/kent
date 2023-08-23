import { Component, OnInit, inject } from '@angular/core';
import { NotificationService } from '@services/notification.service';

@Component({
	selector: 'app-notifications',
	templateUrl: './notifications.component.html',
	styleUrls: ['./notifications.component.sass']
})
export class NotificationsComponent implements OnInit {
	ids: string[] = [];
	notificationService: NotificationService = inject(NotificationService);

	ngOnInit(){
		this.notificationService.notifications().subscribe(notifications => this.ids = Array.from(notifications.keys()))
	}
}
