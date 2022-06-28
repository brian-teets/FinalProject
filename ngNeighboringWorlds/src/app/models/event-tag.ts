import { CultureEvent } from './culture-event';
export class EventTag {
  id: number;
  keyword: String;
  events: CultureEvent[] | null;

  constructor(
    id: number = 0,
    keyword: String = '',
    events: CultureEvent[] = []
  ){
    this.id = id;
    this.keyword = keyword;
    this.events = events;
  }

}
