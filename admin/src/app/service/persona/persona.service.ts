import { Injectable } from '@angular/core';
import { Persona } from './../../models/persona/persona';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class PersonaService {
  private urlbase = 'https://www.apicomercial.pvivirtual.com/api/admin/persona';
  constructor(private Http: HttpClient) { }

  Get(): Observable<Persona[]> {
    return this.Http.get<Persona[]>(this.urlbase);
  }
  Post(element: Persona): Observable<any> {
    return this.Http.post<any>(this.urlbase, element);
  }

}

