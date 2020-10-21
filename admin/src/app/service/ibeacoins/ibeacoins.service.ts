import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Ibeacoins } from './../../models/ibeacoins/ibeacoins';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class IbeacoinsService {
  private urlbase = 'http://apicomercial.pvivirtual.com/api/admin/ibeacoins';
  constructor(private Http: HttpClient) { }

  Get(): Observable<Ibeacoins[]> {
    return this.Http.get<Ibeacoins[]>(this.urlbase);
  }
  Post(element: Ibeacoins): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }
  Update(element: Ibeacoins): Observable<any> {
    return this.Http.put<any>(this.urlbase, element);
  }
  Delete(id: string): Observable<any> {
    return this.Http.delete<any>(this.urlbase + `/${id}`);
  }
}
