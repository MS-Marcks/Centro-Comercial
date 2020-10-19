import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { Descripcion } from './../../models/descripcion/descripcion';
import { DescripcionService } from './../../service/descripcion/descripcion.service';

@Component({
  selector: 'app-descripcion',
  templateUrl: './descripcion.component.html',
  styleUrls: ['./descripcion.component.css']
})
export class DescripcionComponent implements OnInit {

  dataSource: Descripcion[];
  displayedColumns = ['id_descripcion', 'articulo', 'descripcion', 'editar', 'eliminar'];
  Forms: FormGroup;

  estado = 0;
  eliminar = false;
  mensaje = 'CREAR';
  cancelar = false;
  mensajeEliminar;
  id = 0;
  meessage;

  constructor(private service: DescripcionService, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.Forms = this.fb.group({
      id_descripcion: null,
      id_articulo: [null, Validators.required],
      descripcion: [null, Validators.required],
      articulo: null
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
    this.meessage = 'CARGANDO...';

    if (this.estado === 0) {
      this.service.Post(this.Forms.value).subscribe(
        (res) => {
          this.meessage = res;
          this.Get();
          this.OnCancelar();
        }
      );
    } else if (this.estado === 1) {
      this.service.Update(this.Forms.value).subscribe(
        (res) => {
          this.meessage = res;
          this.Get();
          this.OnCancelar();
        }
      );
    } else if (this.estado === 2) {
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
    this.id = element.id_descripcion;
    this.mensaje = 'ELIMINAR';
    this.estado = 2;
    this.cancelar = true;
    this.eliminar = true;
    this.mensajeEliminar = `Deseas Eliminar En verdad la descripcion del articulo: ${element.articulo} Con ID ${element.id_descripcion}`;
  }
  OnCargar(): boolean {
    if (typeof this.dataSource === 'undefined') {
      return false;
    } else {
      return true;
    }
  }
}
