import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Address } from 'src/app/models/address';
import { CultureEvent } from 'src/app/models/culture-event';
import { AddressService } from 'src/app/services/address.service';
import { EventService } from 'src/app/services/event.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-events-list',
  templateUrl: './events-list.component.html',
  styleUrls: ['./events-list.component.css'],
})
export class EventsListComponent implements OnInit {
  allEvents: CultureEvent[] = [];
  myEvents: CultureEvent[] = [];
  selected: CultureEvent | null = null;
  newEvent: CultureEvent = new CultureEvent();
  newEventAddress: Address = new Address();
  editEvent: CultureEvent | null = null;
  eventAddress: Address = new Address();
  menuToggle: string = 'all';

  constructor(
    private es: EventService,
    private as: AddressService,
    private us: UserService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.reload();
  }

  reload() {
    this.es.index().subscribe({
      next: (data) => {
        this.allEvents = data;
      },
      error: (wrong) => {
        console.error('Culture-EventComponent.reload: error loading list');
        console.error(wrong);
      },
    });
  }

  getEventCount(): number {
    return this.allEvents.length;
  }

  displayEventInfo(event: CultureEvent): void {
    this.selected = event;
    this.menuToggle = 'selected';
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

  getMyEvents() {
    this.myEvents = [];
    this.us.getLoggedInUser().subscribe({
      next: (loggedInUser) => {
        this.allEvents.forEach((event) => {
          if (loggedInUser.id == event.host?.id) {
            this.myEvents.push(event);
          }
        });
        this.menuToggle = 'mine';
        console.log(this.myEvents);
      },
      error: (wrong) => {
        console.error(
          'error getting logged in user & populating array with users events'
        );
        console.error(wrong);
      },
    });
  }

  setSelectedEvent(): void {
    this.selected = Object.assign({}, this.selected);
  }

  menuToggleShowAll() {
    this.menuToggle = 'all';
    console.log(this.menuToggle);
    this.reload;
  }

  menuToggleShowPast() {
    this.menuToggle = 'past';
    console.log(this.menuToggle);
    this.reload;
  }
}
