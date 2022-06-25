import { User } from 'src/app/models/user';
import { Address } from './address';

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
  host: User | null;
  address: Address | null;

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
    createdDate: String = '',
    lastUpdated: String = '',
    host: User | null = new User(),
    address: Address | null = new Address()
  ) {
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
    this.host = host;
    this.address = address;
  }
}
