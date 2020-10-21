import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Tipo } from '../../models/tipo/tipo';

@Injectable({
  providedIn: 'root'
})
export class TipoService {
  private urlbase = 'http://apicomercial.pvivirtual.com/api/admin/tipoproducto';
  constructor(private Http: HttpClient) { }

  Get(): Observable<Tipo[]> {
    return this.Http.get<Tipo[]>(this.urlbase);
  }
  Post(element: Tipo): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }
  Update(element: Tipo): Observable<any> {
    return this.Http.put<any>(this.urlbase, element);
  }
  Delete(id: number): Observable<any> {
    return this.Http.delete<any>(this.urlbase + `/${id}`);
  }
}
