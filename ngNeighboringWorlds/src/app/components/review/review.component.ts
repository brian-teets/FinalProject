import { CultureEvent } from 'src/app/models/culture-event';
import { Component, OnInit } from '@angular/core';
import { Review } from 'src/app/models/review';
import { User } from 'src/app/models/user';
import { EventService } from 'src/app/services/event.service';
import { UserService } from 'src/app/services/user.service';


@Component({
  selector: 'app-review',
  templateUrl: './review.component.html',
  styleUrls: ['./review.component.css'],
  styles: [`
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
  `]
})
export class ReviewComponent implements OnInit {

  review: Review = new Review();
  reviewContent: String | null = '';
  currentRate = 1;

  constructor(private userServ: UserService,
    private evtServ: EventService) {}

  ngOnInit(): void {
  }

  postReview(review: Review, eventId: number): void{

    this.evtServ.postReview(review, eventId).subscribe({
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



  }

