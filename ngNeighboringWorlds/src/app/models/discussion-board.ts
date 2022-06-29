import { User } from 'src/app/models/user';
export class DiscussionBoard {
  id: number;
  title: String;
  content: String;
  commentDate: String;
  user: User;
  cultureEventId: number;
  inReplyToId: number;

  constructor(
    id: number = 0,
    title: String = '',
    content: String = '',
    commentDate: String = '',
    userId: number = 0,
    cultureEventId = 0,
    inReplyToId: number = 0,
    user: User = new User()
  ) {
    this.id = id;
    this.title = title;
    this.content = content;
    this.commentDate = commentDate;
    this.cultureEventId = cultureEventId;
    this.inReplyToId = inReplyToId;
    this.user = user;
  }
}
