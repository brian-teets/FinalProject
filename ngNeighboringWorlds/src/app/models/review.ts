import { CultureEvent } from 'src/app/models/culture-event';
import { User } from './user';
export class Review {

 rating: number;
 reviewContent: String;
 reviewDate: String;
 user: User;
 cultureEvent: CultureEvent;

 constructor(
  rating: number = 0,
  reviewContent: String = '',
  reviewDate: String = '',
  user: User = new User(),
  cultureEvent: CultureEvent = new CultureEvent()
 ){
  this.rating = rating;
  this.reviewContent = reviewContent;
  this.reviewDate = reviewDate;
  this.user = user;
  this.cultureEvent = cultureEvent;
 }
}
