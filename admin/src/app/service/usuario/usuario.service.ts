import { Injectable } from '@angular/core';
import { Usuario } from './../../models/usuario/usuario';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class UsuarioService {
  private urlbase = 'http://localhost:3000/api/admin/usuario';
  constructor(private Http: HttpClient) { }

  Get(): Observable<Usuario[]> {
    return this.Http.get<Usuario[]>(this.urlbase);
  }
  Post(element): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }

}


