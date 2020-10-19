import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Compra } from 'src/app/models/compra/compra';
import { Observable } from 'rxjs';
import { Inventario } from 'src/app/models/inventario/inventario';
import { Proveedor } from 'src/app/models/proveedor/proveedor';

@Injectable({
  providedIn: 'root'
})
export class CompraService {
  private urlbase = 'http://localhost:3000/api/admin/compras';
  private urlbaseinvetario = 'http://localhost:3000/api/admin/inventario';
  private urlbaseproveedor = 'http://localhost:3000/api/admin/proveedor';
  constructor(private Http: HttpClient) { }

  Get(): Observable<Compra[]> {
    return this.Http.get<Compra[]>(this.urlbase);
  }
  Post(element): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }
  GetArticulo(id: number): Observable<Inventario>{
    return this.Http.get<Inventario>(this.urlbaseinvetario + '/' + id);
  }
  GetProveedor(id: number): Observable<Proveedor>{
    return this.Http.get<Proveedor>(this.urlbaseproveedor + '/' + id);
  }
}

