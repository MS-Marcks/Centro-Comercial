import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoginComponent } from './public/login/login.component';
import { ClienteComponent } from './private/cliente/cliente.component';
import { FacturaComponent } from './private/factura/factura.component';
import { DetalleComponent } from './private/detalle/detalle.component';
import { AuthGuard } from './auth.guard';

const routes: Routes = [
  { path: '', component: LoginComponent },
  { path: 'login', component: LoginComponent },
  { path: 'cliente', component: ClienteComponent, canActivate: [AuthGuard] },
  { path: 'factura', component: FacturaComponent, canActivate: [AuthGuard] },
  { path: 'detalle', component: DetalleComponent, canActivate: [AuthGuard] }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
