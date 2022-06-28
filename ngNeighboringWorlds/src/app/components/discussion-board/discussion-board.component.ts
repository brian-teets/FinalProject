import { DatePipe } from '@angular/common';
import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { CultureEvent } from 'src/app/models/culture-event';
import { User } from 'src/app/models/user';
import { DiscussionBoardService } from 'src/app/services/discussion-board.service';
import { EventService } from 'src/app/services/event.service';
import { UserService } from 'src/app/services/user.service';
import { DiscussionBoard } from '../../models/discussion-board';

@Component({
  selector: 'app-discussion-board',
  templateUrl: './discussion-board.component.html',
  styleUrls: ['./discussion-board.component.css'],
})
export class DiscussionBoardComponent implements OnInit {
  allComments: DiscussionBoard[] = [];
  myComments: DiscussionBoard[] = [];
  selected: DiscussionBoard | null = null;
  newComment: DiscussionBoard = new DiscussionBoard();
  editComment: DiscussionBoard | null = null;
  menuToggle: string = 'all';
  currentUser: User | null = new User();
  @Input() currentEvent: CultureEvent = new CultureEvent();
  commentEvent: CultureEvent = new CultureEvent();


  constructor(
    private commentServ: DiscussionBoardService,
    private userServ: UserService,
    private currentRoute: ActivatedRoute,
    private router: Router,
    private date: DatePipe,
    private eventServ: EventService
  ) {}

  ngOnInit(): void {
    this.reload();
    let userIdStr = this.currentRoute.snapshot.paramMap.get('userId');
    if (userIdStr) {
      let userId = Number.parseInt(userIdStr);
      if (!isNaN(userId)) {
        this.userServ.getUserById(userId).subscribe({
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
      this.userServ.getLoggedInUser().subscribe({
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
    console.log('In reload: ');
    this.commentServ.getCommentsForEvent(this.currentEvent.id).subscribe({
      next: (data) => {
        this.allComments = data;
        console.log('In reload: ');
        console.log(data);

      },
      error: (wrong) => {
        console.error('Discussion Component.reload: error loading list');
        console.error(wrong);
      },
    });
  }

  getCommentCount(): number {
    return this.allComments.length;
  }

  getCommentDate(): String {
    return this.newComment.commentDate;
  }

  displayComment(comment: DiscussionBoard): void {
    this.selected = comment;
    this.menuToggle = 'selected';
  }

  addComment(comment: DiscussionBoard, eventId: number): void {
    console.log(comment);
    console.log(comment.content);
    this.commentServ.create(comment, eventId).subscribe({
      next: (createdComment) => {
        this.selected = createdComment;
        this.reload();
        this.newComment = new DiscussionBoard();
        this.displayComment(comment);
      },
      error: (wrong) => {
        console.error('error creating comment');
        console.error(wrong);
      },
    });
    // this.reload();
  }

  setEditComment(): void {
    this.editComment = Object.assign({}, this.selected);
  }
  updateComment(comment: DiscussionBoard, setSelected: boolean = true): void {
    if (comment.id != null) {
      this.commentServ.update(comment).subscribe({
        next: (updatedComment) => {
          this.reload();
          this.editComment = null;
          if (setSelected) {
            this.selected = updatedComment;
          }
        },
        error: (wrong) => {
          console.error('error completing event');
          console.error(wrong);
        },
      });
    }
  }

  deleteComment(id: number): void {
    console.log('in delete');
    this.commentServ.destroy(id).subscribe({
      next: () => {
        this.reload();
      },
      error: (wrong) => {
        console.error('error deleting comment');
        console.error(wrong);
      },
    });
  }
}
