import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

import { map } from 'rxjs/operators';

import { LogMessageList } from '../proto/logservice_pb';

@Injectable({
  providedIn: 'root'
})
export class LogService {
  constructor(private httpClient: HttpClient) { }

  lastMessages(n: number) {
    return this.httpClient
      .get(
        '/api/last/' + n,
        {
          headers: { Accept: '*/*' },
          responseType: 'arraybuffer'
        }
      )
      .pipe(map(arr => LogMessageList.deserializeBinary(arr as Uint8Array)));
  }
}
