export class DiscussionBoard {
  id: number;
  title: String;
  content: String;
  commentDate: String;
  userId: number;
  cultureEventId: number;
  inReplyToId: number;

  constructor(
    id: number = 0,
    title: String = '',
    content: String = '',
    commentDate: String = '',
    userId: number = 0,
    cultureEventId = 0,
    inReplyToId: number = 0
  ) {
    this.id = id;
    this.title = title;
    this.content = content;
    this.commentDate = commentDate;
    this.userId = userId;
    this.cultureEventId = cultureEventId;
    this.inReplyToId = inReplyToId;
  }
}
