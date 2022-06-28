import { Injectable } from '@angular/core';
import { UserService } from 'src/app/services/user.service';
import { CultureEvent } from './../models/culture-event';
import { HttpClient } from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';
import { DatePipe } from '@angular/common';
import { ActivatedRoute, Router } from '@angular/router';
import { EventTag } from '../models/event-tag';

@Injectable({
  providedIn: 'root'
})
export class EventTagService {

  private url = environment.baseUrl + 'api/';

  constructor(
    private http: HttpClient,
    private auth: AuthService,
    private route: ActivatedRoute,
    private router: Router) { }

    getHttpOptions() {
      let options = {
        headers: {
          Authorization: 'Basic ' + this.auth.getCredentials(),
          'X-Requested-With': 'XMLHttpRequest',
        },
      };
      return options;
    }

    index(): Observable<EventTag[]> {
      return this.http.get<EventTag[]>(this.url + 'tags', this.getHttpOptions()).pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'Event-TagService.index(): error retrieving list of EventTags: ' +
                  err
              )
          );
        })
      );
    }

    getSingleEventTags(cid: number): Observable<EventTag[]> {
      return this.http.get<EventTag[]>(this.url + '/culture-events/' + cid + '/tags', this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'Event-TagService.getEventTags(): error getting Event Tags: ' +
                  err
              )
          );
        })
      );
    }

    create(newTag: EventTag, cid: number): Observable<EventTag> {

      return this.http
        .post<EventTag>(this.url + '/culture-events/' + cid + '/tags', newTag, this.getHttpOptions())
        .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError(
              () =>
                new Error(
                  'Event-TagService.create(): error creating Event Tag: ' +
                    err
                )
            );
          })
        );
    }

    destroy(cid: number, keyword: String): Observable<void> {
      return this.http
        .delete<void>(this.url + '/culture-events/' + cid + '/tags/' + keyword, this.getHttpOptions())
        .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError(
              () =>
                new Error(
                  'Event-TagService.destroy(): error deleting Event-Tag: ' +
                    err
                )
            );
          })
        );
    }


}
