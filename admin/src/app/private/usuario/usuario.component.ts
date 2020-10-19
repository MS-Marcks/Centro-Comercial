import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { Usuario } from 'src/app/models/usuario/usuario';
import { UsuarioService } from './../../service/usuario/usuario.service';
import { Persona } from 'src/app/models/persona/persona';
import { Rol } from 'src/app/models/rol/rol';

@Component({
  selector: 'app-usuario',
  templateUrl: './usuario.component.html',
  styleUrls: ['./usuario.component.css']
})
export class UsuarioComponent implements OnInit {

  dataSource: Usuario[];
  displayedColumns = ['uuid', 'id_persona', 'primernombre', 'segundonombre', 'primerapellido', 'segundoapellido', 'usuario', 'rol', 'direccion', 'nit', 'telefono'];
  Forms: FormGroup;
  personavalores: Persona;
  rolvalores: Rol;
  estado = 0;
  eliminar = false;
  mensaje = 'CREAR';
  cancelar = false;
  mensajeEliminar;
  id = 0;
  meessage;

  constructor(private service: UsuarioService, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.Forms = this.fb.group({
      uuid: [null, Validators.required],
      id_persona: [null, Validators.required],
      usuario: [null, Validators.required],
      pass: [null, Validators.required],
      id_rol: [null, Validators.required]
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
    if (this.Forms.value.uuid !== null && this.Forms.value.id_persona !== null && this.Forms.value.usuario !== null && this.Forms.value.pass !== null && this.Forms.value.id_rol !== null) {
      if (typeof this.personavalores !== 'undefined' && typeof this.rolvalores !== 'undefined') {
        this.meessage = 'CARGANDO...';

        if (this.estado === 0) {
          this.service.Post(this.Forms.value).subscribe(
            (res) => {
              this.personavalores = undefined;
              this.rolvalores = undefined;
              this.meessage = res;
              this.Get();
              this.OnCancelar();
            }
          );
        }
      } else {
        this.meessage = 'Verificar si la Persona y Rol existen!';
      }
    } else {
      this.meessage = 'Debe de ingresar todos los valores';
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
    this.id = element.id_proveedor;
    this.mensaje = 'ELIMINAR';
    this.estado = 2;
    this.cancelar = true;
    this.eliminar = true;
    this.mensajeEliminar = `Deseas Eliminar En verdad el proveedor: ${element.proveedor} Con ID ${element.id_proveedor}`;
  }

  OnCargar(): boolean {
    if (typeof this.dataSource === 'undefined') {
      return false;
    } else {
      return true;
    }
  }

  OnBuscarPersona(): void {

    this.service.GetPersona(this.Forms.value.id_persona).subscribe(
      (res) => {
        this.personavalores = res;
      }
    );
  }
  OnValidarPersona(): boolean {
    if (typeof this.personavalores !== 'undefined') {
      return true;
    } else {
      return false;
    }
  }
  OnBuscarRol(): void {

    this.service.GetRol(this.Forms.value.id_rol).subscribe(
      (res) => {
        this.rolvalores = res;
      }
    );
  }
  OnValidarRol(): boolean {
    if (typeof this.rolvalores !== 'undefined') {
      return true;
    } else {
      return false;
    }
  }
}
