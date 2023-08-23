import { Component, Input, OnInit, inject } from '@angular/core';
import { NotificationService } from '@services/notification.service';
import { Notification } from '@utils/interfaces/notification.interface';

@Component({
	selector: 'app-notification',
	templateUrl: './notification.component.html',
	styleUrls: ['./notification.component.sass']
})
export class NotificationComponent implements OnInit {
	@Input() id: string = '';
	notification: Notification | undefined;
	notificationService: NotificationService = inject(NotificationService);

	ngOnInit(){
		this.notification = this.notificationService.get(this.id);
	}
}
