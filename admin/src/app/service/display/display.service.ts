import { Injectable } from '@angular/core';
import { Display } from './../../models/display/display';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { Ibeacoins } from 'src/app/models/ibeacoins/ibeacoins';
import { Tipo } from 'src/app/models/tipo/tipo';

@Injectable({
  providedIn: 'root'
})
export class DisplayService {

  private urlbase = 'http://localhost:3000/api/admin/display';
  private urlbaseIbeacoins = 'http://localhost:3000/api/admin/ibeacoins';
  private urlbaseTipo = 'http://localhost:3000/api/admin/tipoproducto';

  constructor(private Http: HttpClient) { }

  GetIbeacoins(identifier: string): Observable<Ibeacoins> {
    return this.Http.get<Ibeacoins>(this.urlbaseIbeacoins + `/${identifier}`);
  }
  GetTipo(id_tipo: number): Observable<Tipo> {
    return this.Http.get<Tipo>(this.urlbaseTipo + `/${id_tipo}`);
  }
  Get(): Observable<Display[]> {
    return this.Http.get<Display[]>(this.urlbase);
  }
  Post(element: Display): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }
  Delete(identifier: string, id_tipo: number): Observable<any> {
    return this.Http.delete<any>(this.urlbase + `/${identifier}/${id_tipo}`);
  }

}


