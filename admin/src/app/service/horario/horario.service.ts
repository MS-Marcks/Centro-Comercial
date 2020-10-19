import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Horario } from './../../models/horario/horario';

@Injectable({
  providedIn: 'root'
})
export class HorarioService {

  private urlbase = 'http://localhost:3000/api/admin/horario';
  constructor(private Http: HttpClient) { }
  Get(): Observable<Horario[]> {
    return this.Http.get<Horario[]>(this.urlbase);
  }
  Post(element): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }
  Update(elemtent): Observable<any> {
    return this.Http.put<any>(this.urlbase, elemtent);
  }
  Delete(id: number): Observable<any> {
    return this.Http.delete<any>(this.urlbase + `/${id}`);
  }

}
