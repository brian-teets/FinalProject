import { DiscussionBoard } from './../models/discussion-board';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';
import { UserService } from './user.service';
import { Observable, catchError, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DiscussionBoardService {
  private url = environment.baseUrl + 'api/'
  private deleteUrl = environment.baseUrl
//culture-events/{cuid}/comments

  constructor(
    private http: HttpClient,
    private auth: AuthService,
    private route: ActivatedRoute,
    private router: Router,
    private userServ: UserService
  ) { }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  index(): Observable<DiscussionBoard[]> {
    return this.http.get<DiscussionBoard[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'DiscussionBoardService.index(): error retrieving list of UserComment: ' +
                err
            )
        );
      })
    );
  }

  getCommentsForEvent(eventId: number): Observable<DiscussionBoard[]> {
    return this.http.get<DiscussionBoard[]>(this.url + `culture-events/${eventId}/comments`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'DiscussionBoardService.index(): error retrieving list of UserComment: ' +
                err
            )
        );
      })
    );
  }

  create(comment: DiscussionBoard, eventId: number): Observable<DiscussionBoard> {
    return this.http
      .post<DiscussionBoard>(this.url + "culture-events/" + eventId + "/comments", comment, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'DiscussionBoardService.create(): error creating UserComment: ' +
                  err
              )
          );
        })
      );
  }

  update(DiscussionBaord: DiscussionBoard): Observable<DiscussionBoard> {
    let completeDate = '';

    return this.http
      .put<DiscussionBoard>(
        this.url + '/' + DiscussionBaord.id,
        DiscussionBaord,
        this.getHttpOptions()
      )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'DiscussionBoard.update(): error updating UserCOmment: ' +
                  err
              )
          );
        })
      );
  }
  destroy(id: number): Observable<void> {
    return this.http
      .delete<void>(this.deleteUrl + "api/comments/" + id, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'DiscussionBoardService.destroy(): error deleting UserComment: ' +
                  err
              )
          );
        })
      );
  }

  show(id: number): Observable<DiscussionBoard> {
    return this.http
      .get<DiscussionBoard>(this.url + '/' + id, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'DiscussionBoardService.show(): error retrieving UserComment: ' +
                  err
              )
          );
        })
      );
  }


}
