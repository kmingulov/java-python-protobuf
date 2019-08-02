import { Component, Injectable } from '@angular/core';
import { interval } from 'rxjs';

import { LogService } from './log.service';
import { LogMessage } from '../proto/logservice_pb';

@Component({
  selector: 'app-root',
  templateUrl: './log.component.html',
  styleUrls: [ './log.component.css' ]
})
@Injectable()
export class LogComponent {

  private cssClassByLevelId: string[] = [ 'log-debug', 'log-info', 'log-warn', 'log-error' ];
  private iconIdByLevelId: string[] = [ 'bug_report', 'info', 'warning', 'error' ];

  private messages: LogMessage[] = [];
  private isLoading = false;
  private isError = false;

  constructor(private logService: LogService) {
    this.triggerUpdate();
    interval(5000).subscribe(() => this.triggerUpdate());
  }

  private triggerUpdate() {
    if (this.isLoading) {
      return;
    }

    this.isLoading = true;

    this.logService.lastMessages(10)
      .subscribe(
        list => {
          this.messages = list.getMessageList().reverse();
          this.isLoading = false;
          this.isError = false;
        },
        error => {
          this.messages = [];
          this.isLoading = false;
          this.isError = true;
        }
      );
  }

}
