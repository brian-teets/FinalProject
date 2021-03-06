import { DatePipe } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { catchError, Observable, throwError } from 'rxjs';
import { CultureEvent } from 'src/app/models/culture-event';
import { UserService } from 'src/app/services/user.service';
import { environment } from 'src/environments/environment';
import { Review } from '../models/review';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root',
})
export class EventService {
  // private baseUrl = 'http://localhost:8083/';
  private url = environment.baseUrl + 'api/culture-events';
  datePipe: any;

  constructor(
    private http: HttpClient,
    private auth: AuthService,
    private route: ActivatedRoute,
    private router: Router,
    private datepipe: DatePipe,
    private us: UserService
  ) {}

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  index(): Observable<CultureEvent[]> {
    return this.http.get<CultureEvent[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'CultureEventService.index(): error retrieving list of CultureEvents: ' +
                err
            )
        );
      })
    );
  }

  create(event: CultureEvent): Observable<CultureEvent> {
    return this.http
      .post<CultureEvent>(this.url, event, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'CultureEventService.create(): error creating CultureEvent: ' +
                  err
              )
          );
        })
      );
  }

  update(CultureEvent: CultureEvent): Observable<CultureEvent> {
    let completeDate = '';

    return this.http
      .put<CultureEvent>(
        this.url + '/' + CultureEvent.id,
        CultureEvent,
        this.getHttpOptions()
      )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'CultureEventService.update(): error updating CultureEvent: ' +
                  err
              )
          );
        })
      );
  }

  destroy(id: number): Observable<void> {
    return this.http
      .delete<void>(this.url + '/' + id, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'CultureEventService.destroy(): error deleting CultureEvent: ' +
                  err
              )
          );
        })
      );
  }

  show(id: number): Observable<CultureEvent> {
    return this.http
      .get<CultureEvent>(this.url + '/' + id, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'CultureEventService.show(): error retrieving CultureEvent: ' +
                  err
              )
          );
        })
      );
  }

  attend(cid: number) {
    return this.http
      .post(
        environment.baseUrl + 'api/culture-events' + '/' + cid + '/attendees',
        null,
        this.getHttpOptions()
      )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'EventService.update(): error updating Attendee: ' + err
              )
          );
        })
      );
  }
  // culture-events/{cid}/reviews
  postReview(review: Review, eventId: number){
    return this.http
    .post(
      environment.baseUrl + 'api/culture-events' + '/' + eventId + '/reviews',
      review,
      this.getHttpOptions()
    )
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'EventService.postReview(): error adding a new review: ' + err
            )
        );
      })
    );
  }

  searchByKeyword(keyword: String): Observable<CultureEvent[]>{
    return this.http
    .get<CultureEvent[]>(
      environment.baseUrl + 'api/culture-events' + '/search/' + keyword,
      this.getHttpOptions()
    )
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'EventService.searchByKeyword(): error searching: ' + err
            )
        );
      })
    );
  }



}
