import { DiscussionBoard } from '../../models/discussion-board';
import { Component, OnInit } from '@angular/core';
import { DiscussionBoardService } from 'src/app/services/discussion-board.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-discussion-board',
  templateUrl: './discussion-board.component.html',
  styleUrls: ['./discussion-board.component.css']
})
export class DiscussionBoardComponent implements OnInit {

  allComments: DiscussionBoard[] = [];
  myComments: DiscussionBoard[] = [];
  selected: DiscussionBoard | null = null;
  newComment: DiscussionBoard = new DiscussionBoard();
  editComment: DiscussionBoard | null = null;
  menuToggle: string = 'all';

  constructor(
    private commentServ: DiscussionBoardService,
    private userServ: UserService

  ) { }


  ngOnInit(): void {
    this.reload();
  }

  reload() {
    this.commentServ.index().subscribe({
      next: (data) => {
        this.allComments = data;
      },
      error: (wrong) => {
        console.error('Culture-EventComponent.reload: error loading list');
        console.error(wrong);
      },
    });
  }

  getCommentCount(): number {
    return this.allComments.length;
  }

  displayComment(comment: DiscussionBoard): void {
    this.selected = comment;
    this.menuToggle = 'selected';
  }

  addComment(comment: DiscussionBoard): void {

    this.commentServ.create(comment).subscribe({
      next: (createdComment) => {
        this.selected = createdComment;
        this.reload();
      },
      error: (wrong) => {
        console.error('error creating comment');
        console.error(wrong);
      },
    });
    this.reload();
    this.newComment = new DiscussionBoard();
    this.displayComment(comment);
  }

  setEditEvent(): void {
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
