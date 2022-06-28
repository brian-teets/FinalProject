import { EventTagService } from './../../services/event-tag.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Address } from 'src/app/models/address';
import { CultureEvent } from 'src/app/models/culture-event';
import { User } from 'src/app/models/user';
import { EventService } from 'src/app/services/event.service';
import { UserService } from 'src/app/services/user.service';
import { EventTag } from 'src/app/models/event-tag';

@Component({
  selector: 'app-eventtagselector',
  templateUrl: './eventtagselector.component.html',
  styleUrls: ['./eventtagselector.component.css'],
})
export class EventtagselectorComponent implements OnInit {
  allTags: EventTag[] = [];
  eventTags: EventTag[] = [];
  newTag: EventTag = new EventTag;



  constructor(private ets: EventTagService,
              private router: Router) {}

  ngOnInit(): void {
    this.reload();
  }

  reload() {
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

  getSingleEventTags(cid: number){
    this.ets.getSingleEventTags(cid).subscribe({
      next: (data) => {
        this.eventTags = data;
        this.reload();
      },
      error: (wrong) => {
        console.error('EventTagSelector.showSingleEventTags: error loading list');
        console.error(wrong);
      },
    });
  }

  create(cid: number, newTagToCreate: EventTag){
    this.ets.create(newTagToCreate, cid).subscribe({
      next: (data) => {
        this.reload();
        this.newTag = new EventTag();
        console.log('Success')
      },
      error: (wrong) => {
        console.error('EventTagSelector.create: error creating tag');
        console.error(wrong);
      },
    });
  }





}
