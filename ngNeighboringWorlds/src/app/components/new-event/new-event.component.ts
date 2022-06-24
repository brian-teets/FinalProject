import { Component, OnInit } from '@angular/core';
import { Address } from './../../models/address';
import { CultureEvent } from './../../models/culture-event';
import { AddressService } from './../../services/address.service';
import { EventService } from './../../services/event.service';
import { UserService } from './../../services/user.service';

@Component({
  selector: 'app-new-event',
  templateUrl: './new-event.component.html',
  styleUrls: ['./new-event.component.css'],
})
export class NewEventComponent implements OnInit {
  eventList: CultureEvent[] = [];
  selected: CultureEvent | null = null;
  newEvent: CultureEvent = new CultureEvent();
  newEventAddress: Address = new Address();
  editEvent: CultureEvent | null = null;
  eventAddress: Address = new Address();

  constructor(
    private es: EventService,
    private as: AddressService,
    private us: UserService
  ) {}

  ngOnInit(): void {
    this.reload();
  }

  reload() {
    this.es.index().subscribe({
      next: (data) => {
        this.eventList = data;
      },
      error: (wrong) => {
        console.error('Culture-EventComponent.reload: error loading list');
        console.error(wrong);
      },
    });
  }

  getEventCount(): number {
    return this.eventList.length;
  }

  displayEventInfo(event: CultureEvent): void {
    this.selected = event;
  }

  addEvent(event: CultureEvent, eventAddress: Address): void {
    event.address = eventAddress;

    this.es.create(event).subscribe({
      next: (createdEvent) => {
      this.selected = createdEvent;
      this.reload();
      },
      error: (wrong) => {
        console.error('error creating event');
        console.error(wrong);
      },
    });
    this.reload();
    this.newEvent = new CultureEvent();
    this.displayEventInfo(event);
  }

  setEditEvent(): void {
    this.editEvent = Object.assign({}, this.selected);
  }
  updateEvent(event: CultureEvent, setSelected: boolean = true): void {
    if (event.id != null) {
      this.es.update(event).subscribe({
        next: (updatedEvent) => {
          this.reload();
          this.editEvent = null;
          if (setSelected) {
            this.selected = updatedEvent;
          }
        },
        error: (wrong) => {
          console.error('error completing event');
          console.error(wrong);
        },
      });
    }
  }

  deleteEvent(id: number): void {
    console.log('in delete');
    this.es.destroy(id).subscribe({
      next: () => {
        this.reload();
      },
      error: (wrong) => {
        console.error('error deleting event');
        console.error(wrong);
      },
    });
  }
}
