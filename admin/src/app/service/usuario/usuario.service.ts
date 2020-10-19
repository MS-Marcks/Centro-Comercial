import { Injectable } from '@angular/core';
import { Usuario } from './../../models/usuario/usuario';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { Persona } from 'src/app/models/persona/persona';
import { Rol } from 'src/app/models/rol/rol';

@Injectable({
  providedIn: 'root'
})
export class UsuarioService {
  private urlbase = 'http://localhost:3000/api/admin/usuario';
  private urlbaseper = 'http://localhost:3000/api/admin/persona';
  private urlbaserol = 'http://localhost:3000/api/admin/rol';
  constructor(private Http: HttpClient) { }

  Get(): Observable<Usuario[]> {
    return this.Http.get<Usuario[]>(this.urlbase);
  }
  Post(element): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }
  GetPersona(id: number): Observable<Persona> {
    return this.Http.get<Persona>(this.urlbaseper + '/' + id);
  }
  GetRol(id: number): Observable<Rol> {
    return this.Http.get<Rol>(this.urlbaserol + '/' + id );
  }

}


