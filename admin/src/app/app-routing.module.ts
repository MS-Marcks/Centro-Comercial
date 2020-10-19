import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { TipoComponent } from './private/tipo/tipo.component';
import { TiendaComponent } from './private/tienda/tienda.component';
import { ProveedorComponent } from './private/proveedor/proveedor.component';
import { RolComponent } from './private/rol/rol.component';
import { IbeacoinsComponent } from './private/ibeacoins/ibeacoins.component';
import { DisplayComponent } from './private/display/display.component';
import { PersonaComponent } from './private/persona/persona.component';
import { ClienteComponent } from './private/cliente/cliente.component';
import { UsuarioComponent } from './private/usuario/usuario.component';

const routes: Routes = [
  { path: 'tipoproducto', component: TipoComponent },
  { path: 'tienda', component: TiendaComponent },
  { path: 'proveedor', component: ProveedorComponent },
  { path: 'rol', component: RolComponent },
  { path: 'ibeacoins', component: IbeacoinsComponent },
  { path: 'display', component: DisplayComponent },
  { path: 'persona', component: PersonaComponent },
  { path: 'cliente', component: ClienteComponent },
  { path: 'usuario', component: UsuarioComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
