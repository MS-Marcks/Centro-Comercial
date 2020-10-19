import { Injectable } from '@angular/core';
import { Asignacion } from './../../models/asignacion/asignacion';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Tienda } from 'src/app/models/tienda/tienda';
import { Usuario } from 'src/app/models/usuario/usuario';

@Injectable({
  providedIn: 'root'
})
export class AsignacionService {

  private urlbase = 'http://localhost:3000/api/admin/asigaciontienda';
  private urlbasetienda = 'http://localhost:3000/api/admin/tienda';
  private urlbaseuuid = 'http://localhost:3000/api/admin/usuario';

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
  GetTienda(id: number): Observable<Tienda> {
    return this.Http.get<Tienda>(this.urlbasetienda + '/' + id);
  }
  GetUuid(id: string): Observable<Usuario> {
    return this.Http.get<Usuario>(this.urlbaseuuid + '/' + id);
  }
}


