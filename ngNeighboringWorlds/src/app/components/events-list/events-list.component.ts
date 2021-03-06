import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Address } from 'src/app/models/address';
import { CultureEvent } from 'src/app/models/culture-event';
import { EventTag } from 'src/app/models/event-tag';
import { Review } from 'src/app/models/review';
import { User } from 'src/app/models/user';
import { AddressService } from 'src/app/services/address.service';
import { EventTagService } from 'src/app/services/event-tag.service';
import { EventService } from 'src/app/services/event.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-events-list',
  templateUrl: './events-list.component.html',
  styleUrls: ['./events-list.component.css'],
  styles: [
    `
      .star {
        position: relative;
        display: inline-block;
        font-size: 3rem;
        color: #d3d3d3;
      }
      .full {
        color: red;
      }
      .half {
        position: absolute;
        display: inline-block;
        overflow: hidden;
        color: red;
      }
    `,
  ],
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
  review: Review = new Review();
  reviewContent: String | null = '';
  currentRate = 1;
  allTags: EventTag[] = [];
  eventTags: EventTag[] = [];
  newTag: EventTag = new EventTag();
  searchResults: CultureEvent[] = [];
  searchKeyword: String = '';
  loggedInUser: User = new User();
  searchUser: User = new User();

  constructor(
    private es: EventService,
    private as: AddressService,
    private us: UserService,
    private ets: EventTagService,
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
    this.ets.index().subscribe({
      next: (data) => {
        this.allTags = data;
      },
      error: (wrong) => {
        console.error('EventTagSelector.reload: error loading list');
        console.error(wrong);
      },
    });
  }

  refresh() {
    window.location.reload();
  }

  getEventCount(): number {
    return this.allEvents.length;
  }

  displayEventInfo(event: CultureEvent): void {
    this.selected = event;
    this.getSingleEventTags(this.selected.id);
    this.menuToggle = 'selected';
    this.checkForShowReview();
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
    this.refresh();
  }

  menuToggleShowSearch() {
    this.menuToggle = 'search';
    console.log(this.menuToggle);
    this.reload;
  }

  menuToggleCreateEvent() {
    this.menuToggle = 'createEvent';
    console.log(this.menuToggle);
    this.reload();
  }

  getLoggedInUser(): void {
    this.us.getLoggedInUser().subscribe({
      next: (loggedInUser) => {
        this.searchUser = loggedInUser;
      },
      error: (wrong) => {
        console.error(
          'error getting logged in user & populating array with users events'
        );
        console.error(wrong);
      },
    });
  }

  attend(cid: number) {
    this.menuToggle = 'showreview';
    console.log(cid);
    this.getLoggedInUser();
    this.es.attend(cid).subscribe({
      next: () => {
        this.reload();
      },
      error: (wrong) => {
        console.error(
          'error getting logged in user & populating array with users events'
        );
        console.error(wrong);
      },
    });
  }

  postReview(review: Review, eventId: number): void {
    this.es.postReview(review, eventId).subscribe({
      next: (newReview) => {
        this.currentRate = review.rating;
        this.reviewContent = review.reviewContent;
      },
      error: (wrong) => {
        console.error('error creating event');
        console.error(wrong);
      },
    });
  }

  createTag(tag: EventTag, cid: number): void {
    this.ets.create(tag, cid).subscribe({
      next: (data) => {
        console.log(data);
        // this.reload();
        this.newTag = new EventTag();
      },
      error: (wrong) => {
        console.error('EventListComponent.createTag: error creating EventTag');
        console.error(wrong);
      },
    });
    this.getSingleEventTags(cid);
  }

  getSingleEventTags(cid: number) {
    this.ets.getSingleEventTags(cid).subscribe({
      next: (data) => {
        this.eventTags = data;
        console.log(this.eventTags.length);
        // this.reload();
      },
      error: (wrong) => {
        console.error(
          'EventListComponent.getSingleEventTags: error loading list'
        );
        console.error(wrong);
      },
    });
  }

  checkForShowReview() {
    let loggedInUser = this.us.getLoggedInUser().subscribe({
      next: (loggedInUser) => {
        console.log(this.selected?.attendees);
        console.log(loggedInUser);

        if (this.selected?.attendees) {
          for (let i = 0; i < this.selected?.attendees?.length; i++) {
            if (this.selected.attendees[i].id === loggedInUser.id) {
              this.menuToggle = 'showreview';
            }
          }
        }
      },
      error: (wrong) => {
        console.error(
          'error getting logged in user & populating array with users events'
        );
        console.error(wrong);
      },
    });
  }

  searchByKeyword(keyword: String) {
    this.es.searchByKeyword(keyword).subscribe({
      next: (data) => {
        this.searchResults = data;
        this.menuToggle = 'search';
      },
      error: (wrong) => {
        console.error(
          'EventListComponent.getSingleEventTags: error loading list'
        );
        console.error(wrong);
      },
    });
  }
}
