import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Cliente } from 'src/app/models/cliente/cliente';
import { HttpClient } from '@angular/common/http';
import { Factura } from './../../models/factura/factura';

@Injectable({
  providedIn: 'root'
})
export class FacturaService {

  private urlbase = 'http://localhost:3000/api/usuario/factura';
  private urlbaseCliente = 'http://localhost:3000/api/usuario/cliente';

  constructor(private Http: HttpClient) { }
  Get(id): Observable<Factura[]> {
    return this.Http.get<Factura[]>(this.urlbase + '/' + id);
  }
  GetFactura(id, id_factura): Observable<Factura> {
    return this.Http.get<Factura>(this.urlbase + '/' + id + '/' + id_factura);
  }
  GetCliente(id: number): Observable<Cliente> {
    return this.Http.get<Cliente>(this.urlbaseCliente + '/' + id);
  }

  Post(element): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }
  ChangeStatus(id_factura, estado): Observable<any> {
    return this.Http.patch<any>(this.urlbase + '/estado/' + id_factura + '/' + estado,null);
  }
  Delete(id): Observable<any> {
    return this.Http.delete<any>(this.urlbase + '/' + id);
  }
}

