import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Compra } from 'src/app/models/compra/compra';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CompraService {
  private urlbase = 'http://localhost:3000/api/admin/compras';
  constructor(private Http: HttpClient) { }

  Get(): Observable<Compra[]> {
    return this.Http.get<Compra[]>(this.urlbase);
  }
  Post(element): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }

}

