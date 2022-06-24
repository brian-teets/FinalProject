import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  currentUser: User = new User();

  constructor(
    private userService: UserService,
    private currentRoute: ActivatedRoute,
    private router: Router
  ) { }

  ngOnInit(): void {
    let userIdStr = this.currentRoute.snapshot.paramMap.get('userId');
    if (userIdStr) {
      let userId = Number.parseInt(userIdStr);
      if (!isNaN(userId)) {
        this.userService.getUserById(userId).subscribe({
          next: (user) => {
            this.currentUser = user;
          },
          error: (fail) => {
            console.error('UserProfileComponent.ngOnit: error getting user by id:');
            console.error(fail);
            this.router.navigateByUrl('userIdNotFound');
          }
        });

      }
      else {
        console.error('UserProfileComponent.ngOnit: invalid user id:');
        this.router.navigateByUrl('invalidUserId')
      }
    }
    else {
      this.userService.getLoggedInUser().subscribe({
        next: (user) => {
          this.currentUser = user;
        },
        error: (fail) => {
          console.error('UserProfileComponent.ngOnit: error getting logged in user:');
          console.error(fail);
          this.router.navigateByUrl('notLoggedIn');
        }
      });
    }
  }

  displayUser(user: User): void {
    this.currentUser = user;
  }

}