import { Injectable } from '@angular/core';
import { Cliente } from './../../models/cliente/cliente';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ClienteService {
  private urlbase = 'https://www.apicomercial.pvivirtual.com/api/admin/cliente';
  constructor(private Http: HttpClient) { }

  Get(): Observable<Cliente[]> {
    return this.Http.get<Cliente[]>(this.urlbase);
  }
  Post(element: Cliente): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }

}

