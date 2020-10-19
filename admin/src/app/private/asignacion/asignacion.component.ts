import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { Asignacion } from 'src/app/models/asignacion/asignacion';
import { Tienda } from 'src/app/models/tienda/tienda';
import { AsignacionService } from './../../service/asignacion/asignacion.service';
import { Usuario } from 'src/app/models/usuario/usuario';

@Component({
  selector: 'app-asignacion',
  templateUrl: './asignacion.component.html',
  styleUrls: ['./asignacion.component.css']
})
export class AsignacionComponent implements OnInit {

  dataSource: Asignacion[];
  displayedColumns = ['id_tienda', 'tienda', 'uuid', 'usuario', 'eliminar'];
  Forms: FormGroup;
  tiendavalores: Tienda;
  uservalores: Usuario;
  estado = 0;
  eliminar = false;
  mensaje = 'CREAR';
  cancelar = false;
  mensajeEliminar;
  id_tienda = 0;
  uuid = '';
  meessage;

  constructor(private service: AsignacionService, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.Forms = this.fb.group({
      id_tienda: [null, Validators.required],
      uuid: [null, Validators.required]
    });
    this.Get();
  }
  Get(): void {
    this.dataSource = undefined;
    this.service.Get().subscribe(
      (res) => {
        this.dataSource = res;
      }
    );
  }
  onSubmit(): void {
    if (this.Forms.value.id_tienda !== null && this.Forms.value.uuid !== null) {
      if (typeof this.tiendavalores !== 'undefined' && typeof this.uservalores !== 'undefined') {
        this.meessage = 'CARGANDO...';

        if (this.estado === 0) {
          this.service.Post(this.Forms.value).subscribe(
            (res) => {
              this.tiendavalores = undefined;
              this.uservalores = undefined;
              this.meessage = res;
              this.Get();
              this.OnCancelar();
            }
          );
        }

      } else {
        this.meessage = 'Verificar si la tienda y el usuario existen!';
      }
    } else {
      this.meessage = 'Debe de ingresar todos los valores';
    }

    if (this.estado === 2) {
      this.service.Delete(this.id_tienda, this.uuid).subscribe(
        (res) => {
          this.meessage = res;
          this.Get();
          this.OnCancelar();
        }
      );
    }
  }
  Onobtener(element): void {
    this.Forms.setValue(element);
    this.mensaje = 'EDITAR';
    this.estado = 1;
    this.cancelar = true;
    this.eliminar = false;
  }
  OnCancelar(): void {
    this.Forms.reset();
    this.mensaje = 'CREAR';
    this.estado = 0;
    this.cancelar = false;
    this.eliminar = false;
  }
  OnEliminar(element): void {
    this.id_tienda = element.id_tienda;
    this.uuid = element.uuid;
    this.mensaje = 'ELIMINAR';
    this.estado = 2;
    this.cancelar = true;
    this.eliminar = true;
    this.mensajeEliminar = `Deseas Eliminar En verdad La Asignacion del usuario: ${element.usuario} Con ID ${element.uuid}`;
  }
  OnCargar(): boolean {
    if (typeof this.dataSource === 'undefined') {
      return false;
    } else {
      return true;
    }
  }
  OnBuscarTienda(): void {

    this.service.GetTienda(this.Forms.value.id_tienda).subscribe(
      (res) => {
        this.tiendavalores = res;
      }
    );
  }

  OnValidarTienda(): boolean {
    //console.log(this.tiendavalores);
    if (typeof this.tiendavalores !== 'undefined') {
      return true;
    } else {
      return false;
    }
  }
  OnBuscarUuid(): void {

    this.service.GetUuid(this.Forms.value.uuid).subscribe(
      (res) => {
        this.uservalores = res;
      }
    );
  }

  OnValidarUuid(): boolean {
    if (typeof this.uservalores !== 'undefined') {
      return true;
    } else {
      return false;
    }
  }

}
