import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css'],
})
export class NavigationComponent implements OnInit {
  public isCollapsed = false;

  constructor(private auth: AuthService, private router: Router) {}

  ngOnInit(): void {}

  logout() {
    console.log('logging out');
    this.router.navigateByUrl('/home');
    this.auth.logout();
  }

  loggedIn(): boolean {
    return this.auth.checkLogin();
  }
}
