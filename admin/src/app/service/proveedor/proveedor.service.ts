import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Proveedor } from 'src/app/models/proveedor/proveedor';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProveedorService {
  private urlbase = 'https://www.apicomercial.pvivirtual.com/api/admin/proveedor';
  constructor(private Http: HttpClient) { }

  Get(): Observable<Proveedor[]> {
    return this.Http.get<Proveedor[]>(this.urlbase);
  }
  Post(element: Proveedor): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }
  Update(element: Proveedor): Observable<any> {
    return this.Http.put<any>(this.urlbase, element);
  }
  Delete(id: number): Observable<any> {
    return this.Http.delete<any>(this.urlbase + `/${id}`);
  }
}
