import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Inventario } from 'src/app/models/inventario/inventario';
import { Tienda } from 'src/app/models/tienda/tienda';
import { Tipo } from 'src/app/models/tipo/tipo';

@Injectable({
  providedIn: 'root'
})
export class InventarioService {
  private urlbase = 'http://localhost:3000/api/admin/inventario';
  private urlbasetienda = 'http://localhost:3000/api/admin/tienda';
  private urlbasetipo = 'http://localhost:3000/api/admin/tipoproducto';
  constructor(private Http: HttpClient) { }

  Get(): Observable<Inventario[]> {
    return this.Http.get<Inventario[]>(this.urlbase);
  }

  Post(element): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }

  GetTienda(id: number): Observable<Tienda> {
    return this.Http.get<Tienda>(this.urlbasetienda + '/' + id);
  }
  GetTipo(id: number): Observable<Tipo> {
    return this.Http.get<Tipo>(this.urlbasetipo + '/' + id);
  }

}
