import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { Display } from 'src/app/models/display/display';
import { Tipo } from 'src/app/models/tipo/tipo';
import { DisplayService } from 'src/app/service/display/display.service';
import { Ibeacoins } from 'src/app/models/ibeacoins/ibeacoins';

@Component({
  selector: 'app-display',
  templateUrl: './display.component.html',
  styleUrls: ['./display.component.css']
})
export class DisplayComponent implements OnInit {

  dataSource: Display[];
  displayedColumns = ['identifier', 'id_tipo', 'tipo', 'eliminar'];
  Forms: FormGroup;
  tipovalores: Tipo;
  ibeavalores: Ibeacoins;
  estado = 0;
  eliminar = false;
  mensaje = 'CREAR';
  cancelar = false;
  mensajeEliminar;
  identifier = '';
  id_tipo = 0;
  meessage;

  constructor(private service: DisplayService, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.Forms = this.fb.group({
      identifier: [null, Validators.required],
      id_tipo: [null, Validators.required]
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

    if (this.Forms.value.identifier !== null && this.Forms.value.id_tipo !== null) {
      if (typeof this.tipovalores !== 'undefined' && typeof this.ibeavalores !== 'undefined') {
        this.meessage = 'CARGANDO...';

        if (this.estado === 0) {
          this.service.Post(this.Forms.value).subscribe(
            (res) => {
              this.tipovalores = undefined;
              this.ibeavalores = undefined;
              this.meessage = res;
              this.Get();
              this.OnCancelar();
            }
          );
        }

        if (this.estado === 2) {
          this.service.Delete(this.identifier, this.id_tipo).subscribe(
            (res) => {
              this.meessage = res;
              this.Get();
              this.OnCancelar();
            }
          );
        }
      } else {
        this.meessage = 'Verificar si el Ibeacoin y Tipo producto  existen!';
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
    this.identifier = element.identifier;
    this.id_tipo = element.id_tipo;
    this.mensaje = 'ELIMINAR';
    this.estado = 2;
    this.cancelar = true;
    this.eliminar = true;
    this.mensajeEliminar = `Deseas Eliminar En verdad la Asigacion del ibeacion: ${element.identifier} Con el Tipo de Producto ${element.id_tipo}`;
  }
  OnCargar(): boolean {
    if (typeof this.dataSource === 'undefined') {
      return false;
    } else {
      return true;
    }
  }
  OnBuscarTipo(): void {

    this.service.GetTipo(this.Forms.value.id_tipo).subscribe(
      (res) => {
        this.tipovalores = res;
      }
    );
  }
  OnValidarTipo(): boolean {
    if (typeof this.tipovalores !== 'undefined') {
      return true;
    } else {
      return false;
    }
  }
  OnBuscarIbeacoin(): void {

    this.service.GetIbeacoins(this.Forms.value.identifier).subscribe(
      (res) => {
        this.ibeavalores = res;
      }
    );
  }
  OnValidarIbeacoin(): boolean {
    if (typeof this.ibeavalores !== 'undefined') {
      return true;
    } else {
      return false;
    }
  }
}

