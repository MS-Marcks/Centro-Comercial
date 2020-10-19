import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { Compra } from 'src/app/models/compra/compra';
import { CompraService } from './../../service/compra/compra.service';

@Component({
  selector: 'app-compra',
  templateUrl: './compra.component.html',
  styleUrls: ['./compra.component.css']
})
export class CompraComponent implements OnInit {

  dataSource: Compra[];
  displayedColumns = ['id_compra', 'proveedor', 'articulo', 'cantidad', 'precio', 'total'];
  Forms: FormGroup;

  estado = 0;
  eliminar = false;
  mensaje = 'CREAR';
  cancelar = false;
  mensajeEliminar;
  id = 0;
  meessage;

  constructor(private service: CompraService, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.Forms = this.fb.group({
      id_proveedor: [null, Validators.required],
      id_articulo: [null, Validators.required],
      cantidad: [null, Validators.required],
      precio: [null, Validators.required]
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
}
