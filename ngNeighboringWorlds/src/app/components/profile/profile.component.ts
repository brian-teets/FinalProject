import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Address } from 'src/app/models/address';
import { CultureEvent } from 'src/app/models/culture-event';
import { User } from 'src/app/models/user';
import { EventService } from 'src/app/services/event.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  // selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css'],
})
export class ProfileComponent implements OnInit {
  currentUser: User = new User();
  editUser: User | null = null;
  profileEditToggle: String = 'mine';

  allEvents: CultureEvent[] = [];
  myEvents: CultureEvent[] = [];
  attendingEvents: CultureEvent[] = [];
  selected: CultureEvent | null = null;
  newEvent: CultureEvent = new CultureEvent();
  newEventAddress: Address = new Address();
  editEvent: CultureEvent | null = null;
  eventAddress: Address = new Address();

  attendeesList: User[] = [];

  constructor(
    private userService: UserService,
    private currentRoute: ActivatedRoute,
    private router: Router,
    private es: EventService,
    private us: UserService
  ) {}

  ngOnInit(): void {
    this.reload();
    let userIdStr = this.currentRoute.snapshot.paramMap.get('userId');
    if (userIdStr) {
      let userId = Number.parseInt(userIdStr);
      if (!isNaN(userId)) {
        this.userService.getUserById(userId).subscribe({
          next: (user) => {
            this.currentUser = user;
          },
          error: (fail) => {
            console.error(
              'UserProfileComponent.ngOnit: error getting user by id:'
            );
            console.error(fail);
            this.router.navigateByUrl('userIdNotFound');
          },
        });
      } else {
        console.error('UserProfileComponent.ngOnit: invalid user id:');
        this.router.navigateByUrl('invalidUserId');
      }
    } else {
      this.userService.getLoggedInUser().subscribe({
        next: (user) => {
          this.currentUser = user;
        },
        error: (fail) => {
          console.error(
            'UserProfileComponent.ngOnit: error getting logged in user:'
          );
          console.error(fail);
          this.router.navigateByUrl('notLoggedIn');
        },
      });
    }
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

  displayUser(user: User): void {
    this.currentUser = user;
  }

  setEditUser(): void {
    this.profileEditToggle = 'hide';
    this.editUser = Object.assign({}, this.currentUser);
  }

  updateUser(user: User, setSelected: boolean = true): void {
    this.userService.updateProfile(user).subscribe({
      next: (updatedUser) => {
        this.displayUser(user);
        this.editUser = null;
        if (setSelected) {
          this.currentUser = updatedUser;
        }
        this.profileEditToggle = 'mine';
      },
      error: (fail) => {
        console.error('error completing todo');
        console.error(fail);
      },
    });
  }

  toggleProfileEdit() {
    this.profileEditToggle = 'show';
  }

  getEventCount(): number {
    return this.allEvents.length;
  }

  displayEventInfo(event: CultureEvent): void {
    this.selected = event;
    this.profileEditToggle = 'mine';
    this.reload();
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

  setSelectedEvent(): void {
    this.selected = Object.assign({}, this.selected);
  }

  getMyEvents() {
    this.myEvents = [];
    this.profileEditToggle = 'mine';
    this.us.getLoggedInUser().subscribe({
      next: (loggedInUser) => {
        this.allEvents.forEach((event) => {
          if (loggedInUser.id == event.host?.id) {
            this.myEvents.push(event);
            this.reload();
          }
        });
        console.log(this.profileEditToggle);
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

  getAttendingEvents() {
    this.profileEditToggle = 'attending';

    this.us.getLoggedInUser().subscribe({
      next: (loggedInUser) => {
        this.allEvents.forEach((event) => {
          event.attendees?.forEach((attendee) => {
            if (attendee.username == loggedInUser.username)
              this.attendingEvents.push(event);
          });
        });
      },
      error: (wrong) => {
        console.error(
          'error getting logged in user & populating array with users events'
        );
        console.error(wrong);
      },
    });
  }

  getPastEvents(): void {
    this.profileEditToggle = 'past';
    this.allEvents = [];
    this.myEvents = [];
    this.reload();
  }
}
