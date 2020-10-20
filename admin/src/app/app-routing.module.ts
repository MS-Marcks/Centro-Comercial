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
import { HorarioComponent } from './private/horario/horario.component';
import { InventarioComponent } from './private/inventario/inventario.component';
import { DescripcionComponent } from './private/descripcion/descripcion.component';
import { CompraComponent } from './private/compra/compra.component';
import { AsignacionComponent } from './private/asignacion/asignacion.component';
import { LoginComponent } from './public/login/login.component';
import { AuthGuard } from './auth.guard';

const routes: Routes = [
  { path: '', component: LoginComponent },
  { path: 'login', component: LoginComponent },
  { path: 'tipoproducto', component: TipoComponent, canActivate: [AuthGuard] },
  { path: 'tienda', component: TiendaComponent, canActivate: [AuthGuard] },
  { path: 'proveedor', component: ProveedorComponent, canActivate: [AuthGuard] },
  { path: 'rol', component: RolComponent, canActivate: [AuthGuard] },
  { path: 'ibeacoins', component: IbeacoinsComponent, canActivate: [AuthGuard] },
  { path: 'display', component: DisplayComponent, canActivate: [AuthGuard] },
  { path: 'persona', component: PersonaComponent, canActivate: [AuthGuard] },
  { path: 'cliente', component: ClienteComponent, canActivate: [AuthGuard] },
  { path: 'usuario', component: UsuarioComponent, canActivate: [AuthGuard] },
  { path: 'horario', component: HorarioComponent, canActivate: [AuthGuard] },
  { path: 'inventario', component: InventarioComponent, canActivate: [AuthGuard] },
  { path: 'descripcion', component: DescripcionComponent, canActivate: [AuthGuard] },
  { path: 'compra', component: CompraComponent, canActivate: [AuthGuard] },
  { path: 'asignacion', component: AsignacionComponent, canActivate: [AuthGuard] }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
