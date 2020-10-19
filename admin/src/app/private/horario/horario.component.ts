import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Usuario } from 'src/app/models/usuario/usuario';
import { Horario } from './../../models/horario/horario';
import { HorarioService } from './../../service/horario/horario.service';

@Component({
  selector: 'app-horario',
  templateUrl: './horario.component.html',
  styleUrls: ['./horario.component.css']
})
export class HorarioComponent implements OnInit {


  dataSource: Horario[];
  displayedColumns = ['id_horario', 'uuid', 'hora_entrada', 'hora_salida', 'usuario', 'editar', 'eliminar'];
  Forms: FormGroup;
  uservalores: Usuario;
  estado = 0;
  eliminar = false;
  mensaje = 'CREAR';
  cancelar = false;
  mensajeEliminar;
  id = 0;
  meessage;

  constructor(private service: HorarioService, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.Forms = this.fb.group({
      id_horario: null,
      uuid: [null, Validators.required],
      hora_entrada: [null, Validators.required],
      hora_salida: [null, Validators.required],
      usuario: null
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
    if ( this.Forms.value.uuid !== null && this.Forms.value.hora_entrada !== null && this.Forms.value.hora_salida !== null) {
      if (typeof this.uservalores !== 'undefined') {
        this.meessage = 'CARGANDO...';

        if (this.estado === 0) {
          this.service.Post(this.Forms.value).subscribe(
            (res) => {
              this.uservalores = undefined;
              this.meessage = res;
              this.Get();
              this.OnCancelar();
            }
          );
        } else if (this.estado === 1) {
          console.log(this.Forms.value);
          this.service.Update(this.Forms.value).subscribe(
            (res) => {
              this.uservalores = undefined;
              this.meessage = res;
              this.Get();
              this.OnCancelar();
            }
          );
        }
      } else {
        this.meessage = 'Verificar si el usuario existe!';
      }
    }else {
      this.meessage = 'Debe de ingresar todos los valores';
    }


    if (this.estado === 2) {
      this.service.Delete(this.id).subscribe(
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
    this.id = element.id_horario;
    this.mensaje = 'ELIMINAR';
    this.estado = 2;
    this.cancelar = true;
    this.eliminar = true;
    this.mensajeEliminar = `Deseas Eliminar En verdad el Horario del Usuario: ${element.uuid} Con ID ${element.id_horario}`;
  }
  OnCargar(): boolean {
    if (typeof this.dataSource === 'undefined') {
      return false;
    } else {
      return true;
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
