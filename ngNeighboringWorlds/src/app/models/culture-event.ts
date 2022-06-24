import { Time } from "@angular/common";
import { Timestamp } from "rxjs";

export class CultureEvent {

id: number;
eventDate: String;
title: String;
capacity: number;
purpose: String;
description: String;
startTime: String;
endTime: String;
coverImgUrl: String;
active: boolean;
createdDate: String;
lastUpdated: String;

constructor(
  id: number = 0,
  eventDate: String = '',
  title: String = '',
  capacity: number = 0,
  purpose: String = '',
  description: String = '',
  startTime: String = '',
  endTime: String = '',
  coverImgUrl: String = '',
  active: boolean = true,
  createdDate: String ='',
  lastUpdated: String =''

){
  this.id = id;
  this.eventDate = eventDate;
  this.title = title;
  this.capacity = capacity;
  this.purpose = purpose;
  this.description = description;
  this.startTime = startTime;
  this.endTime = endTime;
  this.coverImgUrl = coverImgUrl;
  this.active = active;
  this.createdDate = createdDate;
  this.lastUpdated = lastUpdated;
}


}
