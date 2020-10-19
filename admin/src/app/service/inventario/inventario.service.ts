import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Inventario } from 'src/app/models/inventario/inventario';

@Injectable({
  providedIn: 'root'
})
export class InventarioService {
  private urlbase = 'http://localhost:3000/api/admin/inventario';
  constructor(private Http: HttpClient) { }

  Get(): Observable<Inventario[]> {
    return this.Http.get<Inventario[]>(this.urlbase);
  }

  Post(element): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }

}
