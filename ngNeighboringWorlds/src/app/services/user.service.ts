import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  private url = environment.baseUrl + 'api/users';

  constructor(private http: HttpClient, private auth: AuthService) {}

  getUserById(id: number): Observable<User> {
    return this.http.get<User>(`${this.url}/${id}`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'UserService.getUserById(): error retrieving user: ' + err
            )
        );
      })
    );
  }

  getLoggedInUser(): Observable<User> {
    if (!this.auth.checkLogin()) {
      return throwError(() => {
        new Error('Not logged in.');
      });
    }
    let httpOptions = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-with': 'XMLHttpRequest',
      },
    };
    return this.http
      .get<User>(environment.baseUrl + 'authenticate', httpOptions)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'UserService.getUserById(): error retrieving user: ' + err
              )
          );
        })
      );
  }
}
