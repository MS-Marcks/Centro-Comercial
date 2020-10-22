import { Injectable } from '@angular/core';
import { Tienda } from 'src/app/models/tienda/tienda';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class TiendaService {
  private urlbase = 'https://www.apicomercial.pvivirtual.com/api/admin/tienda';
  constructor(private Http: HttpClient) { }

  Get(): Observable<Tienda[]> {
    return this.Http.get<Tienda[]>(this.urlbase);
  }
  Post(element: Tienda): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }
  Update(element: Tienda): Observable<any> {
    return this.Http.put<any>(this.urlbase, element);
  }
  Delete(id: number): Observable<any> {
    return this.Http.delete<any>(this.urlbase + `/${id}`);
  }
}
