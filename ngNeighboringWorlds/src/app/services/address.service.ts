import { Address } from './../models/address';
import { DatePipe } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from './auth.service';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class AddressService {

    // private baseUrl = 'http://localhost:8083/';
    private url = environment.baseUrl + 'api/address'; //check if exists!
    datePipe: any;

  constructor(
    private http: HttpClient,
    private auth: AuthService,
    private route: ActivatedRoute,
    private router: Router,
    private datepipe: DatePipe
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

    index(): Observable<Address[]> {
      return this.http.get<Address[]>(this.url, this.getHttpOptions()).pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'AddressService.index(): error retrieving list of Addresss: ' + err
              )
          );
        })
      );
    }

    create(address: Address): Observable<Address> {
      return this.http.post<Address>(this.url, Address, this.getHttpOptions()).pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () => new Error('AddressService.create(): error creating Address: ' + err)
          );
        })
      );
    }

}
