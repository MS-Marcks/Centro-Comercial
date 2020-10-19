import { Injectable } from '@angular/core';
import { Descripcion } from './../../models/descripcion/descripcion';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class DescripcionService {
  private urlbase = 'http://localhost:3000/api/admin/descripcion';
  constructor(private Http: HttpClient) { }

  Get(): Observable<Descripcion[]> {
    return this.Http.get<Descripcion[]>(this.urlbase);
  }
  Post(element): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }
  Update(element): Observable<any> {
    return this.Http.put<any>(this.urlbase, element);
  }
  Delete(id: number): Observable<any> {
    return this.Http.delete<any>(this.urlbase + `/${id}`);
  }
}
