import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NavComponent } from './public/nav/nav.component';
import { LayoutModule } from '@angular/cdk/layout';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatButtonModule } from '@angular/material/button';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatIconModule } from '@angular/material/icon';
import { MatListModule } from '@angular/material/list';
import { TipoComponent } from './private/tipo/tipo.component';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatRadioModule } from '@angular/material/radio';
import { MatCardModule } from '@angular/material/card';
import { ReactiveFormsModule } from '@angular/forms';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatSortModule } from '@angular/material/sort';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { HttpClientModule } from '@angular/common/http';
import { TiendaComponent } from './private/tienda/tienda.component';
import { ProveedorComponent } from './private/proveedor/proveedor.component';
import { RolComponent } from './private/rol/rol.component';
import { IbeacoinsComponent } from './private/ibeacoins/ibeacoins.component';
import { DisplayComponent } from './private/display/display.component';
import { PersonaComponent } from './private/persona/persona.component';
import { ClienteComponent } from './private/cliente/cliente.component';
import { UsuarioComponent } from './private/usuario/usuario.component';
@NgModule({
  declarations: [
    AppComponent,
    NavComponent,
    TipoComponent,
    TiendaComponent,
    ProveedorComponent,
    RolComponent,
    IbeacoinsComponent,
    DisplayComponent,
    PersonaComponent,
    ClienteComponent,
    UsuarioComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    LayoutModule,
    MatToolbarModule,
    MatButtonModule,
    MatSidenavModule,
    MatIconModule,
    MatListModule,
    MatInputModule,
    MatSelectModule,
    MatRadioModule,
    MatCardModule,
    ReactiveFormsModule,
    MatTableModule,
    MatPaginatorModule,
    MatSortModule,
    MatProgressSpinnerModule,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
