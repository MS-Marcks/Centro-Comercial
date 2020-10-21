import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Usuario } from 'src/app/models/usuario/usuario';
import { Horario } from './../../models/horario/horario';

@Injectable({
  providedIn: 'root'
})
export class HorarioService {

  private urlbase = 'http://apicomercial.pvivirtual.com/api/admin/horario';
  private urlbaseuuid = 'http://apicomercial.pvivirtual.com/api/admin/usuario';
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

  GetUuid(id: string): Observable<Usuario> {
    return this.Http.get<Usuario>(this.urlbaseuuid + '/' + id);
  }
}
