import { Injectable } from '@angular/core';
import { Asignacion } from './../../models/asignacion/asignacion';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AsignacionService {

  private urlbase = 'http://localhost:3000/api/admin/asigaciontienda';

  constructor(private Http: HttpClient) { }

  Get(): Observable<Asignacion[]> {
    return this.Http.get<Asignacion[]>(this.urlbase);
  }
  Post(element): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }
  Delete(id_tienda: number, uuid: string): Observable<any> {
    return this.Http.delete<any>(this.urlbase + `/${id_tienda}/${uuid}`);
  }
}


