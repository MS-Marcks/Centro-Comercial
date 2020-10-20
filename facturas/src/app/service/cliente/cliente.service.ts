import { Injectable } from '@angular/core';
import { Cliente } from './../../models/cliente/cliente';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ClienteService {
  private urlbase = 'http://localhost:3000/api/usuario/cliente';
  constructor(private Http: HttpClient) { }

  Get(): Observable<Cliente[]> {
    return this.Http.get<Cliente[]>(this.urlbase);
  }
  Post(element: Cliente): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }

}

