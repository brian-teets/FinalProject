import { CultureEvent } from 'src/app/models/culture-event';
export class User {
  id: number;
  fName: string | null;
  lName: string;
  email: string;
  phone: string;
  profileImgUrl: string;
  bannerImgUrl: string;
  biography: string;
  username: string;
  password: string;
  events: CultureEvent[];

  constructor(
    id: number = 0,
    fName: string = '',
    lName: string = '',
    email: string = '',
    phone: string = '',
    profileImgUrl: string = '',
    bannerImgUrl: string = '',
    biography: string = '',
    username: string = '',
    password: string = '',
    events: CultureEvent[] = []
  ) {
    this.id = id;
    this.fName = fName;
    this.lName = lName;
    this.email = email;
    this.phone = phone;
    this.profileImgUrl = profileImgUrl;
    this.bannerImgUrl = bannerImgUrl;
    this.biography = biography;
    this.username = username;
    this.password = password;
    this.events = events;
  }
}
