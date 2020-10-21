import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Inventario } from './../../models/inventario/inventario';
import { Observable } from 'rxjs';
import { Detalle } from './../../models/detalle/detalle';

@Injectable({
  providedIn: 'root'
})
export class DetalleService {

  private urlbase = 'http://apicomercial.pvivirtual.com/api/usuario/detalle';
  private urlbaseProducto = 'http://apicomercial.pvivirtual.com/api/usuario/producto';
  private urlbaseFactura = 'http://apicomercial.pvivirtual.com/api/usuario/factura';

  constructor(private Http: HttpClient) { }
  Get(id: number): Observable<Detalle[]> {
    return this.Http.get<Detalle[]>(this.urlbase + '/' + id);
  }

  GetProducto(id_articulo, id_tienda): Observable<Inventario> {
    return this.Http.get<Inventario>(this.urlbaseProducto + '/' + id_articulo + '/' + id_tienda);
  }
  Post(element): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }
  ChangeStatus(id_factura, estado): Observable<any> {
    return this.Http.patch<any>(this.urlbaseFactura + '/estado/' + id_factura + '/' + estado, null);
  }
  Delete(id_factura,id_articulo): Observable<any> {
    return this.Http.delete<any>(this.urlbase + '/' + id_factura+'/'+id_articulo);
  }
}

