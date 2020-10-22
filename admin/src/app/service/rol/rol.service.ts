import { Injectable } from '@angular/core';
import { Rol } from './../../models/rol/rol';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class RolService {
  private urlbase = 'https://www.apicomercial.pvivirtual.com/api/admin/rol';
  constructor(private Http: HttpClient) { }

  Get(): Observable<Rol[]> {
    return this.Http.get<Rol[]>(this.urlbase);
  }
  Post(element: Rol): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }
  Update(element: Rol): Observable<any> {
    return this.Http.put<any>(this.urlbase, element);
  }
  Delete(id: number): Observable<any> {
    return this.Http.delete<any>(this.urlbase + `/${id}`);
  }
}

