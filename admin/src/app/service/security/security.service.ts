import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SecurityService {
  private URI = 'http://apicomercial.pvivirtual.com/api/admin/';

  constructor(private http: HttpClient) { }

  login(user): Observable<any> {
    return this.http.post<any>(this.URI + 'session', user);
  }

  loginOut(): void {
    localStorage.removeItem('token');
  }

  logein(): boolean {
    return !!localStorage.getItem('token');
  }

  gettoken(): string {
    return localStorage.getItem('token');
  }
}
