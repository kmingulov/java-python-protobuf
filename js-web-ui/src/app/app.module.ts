import { NgModule } from '@angular/core';

import { HttpClientModule } from '@angular/common/http';

import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { MatCardModule } from '@angular/material/card';
import { MatListModule } from '@angular/material/list';

import { LogComponent } from './log.component';

@NgModule({
  declarations: [
    LogComponent
  ],

  imports: [
    BrowserAnimationsModule,
    BrowserModule,

    HttpClientModule,

    MatCardModule,
    MatListModule
  ],

  providers: [],
  bootstrap: [ LogComponent ]
})
export class AppModule { }
