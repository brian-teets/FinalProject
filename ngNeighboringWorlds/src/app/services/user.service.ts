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

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

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
  index(): Observable<User>{
    return this.http.get<User>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.index(): error retrieving user: ' + err)
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

  update(id: number, user: User): Observable<User> {

    return this.http.put<User>(this.url + '/' + id, user).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error(
            'FlightService.update(): error updating Toedo: ' + err
          )
        );
      })
    )
    }
  updateProfile(user: User): Observable<User> {

    return this.http.put<User>(environment.baseUrl + "api/profile", user, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error(
            'UserService.update(): error updating UserProlie: ' + err
          )
        );
      })
    )
    }
  }
