import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { Component, OnInit } from '@angular/core';
import { Detalle } from 'src/app/models/detalle/detalle';
import { Cliente } from 'src/app/models/cliente/cliente';
import { DetalleService } from './../../service/detalle/detalle.service';
import { Router } from '@angular/router';
import { Inventario } from 'src/app/models/inventario/inventario';

@Component({
  selector: 'app-detalle',
  templateUrl: './detalle.component.html',
  styleUrls: ['./detalle.component.css']
})
export class DetalleComponent implements OnInit {

  dataSource: Detalle[];
  displayedColumns = ['arituclo', 'precio', 'cantidad', 'total', 'eliminar'];
  Forms: FormGroup;
  clienteValor: Cliente;
  productoValor: Inventario;
  estado = 0;
  eliminar = false;
  mensaje = 'CREAR';
  cancelar = false;
  mensajeEliminar;
  id_factura = 0;
  id_articulo = 0;
  meessage;

  constructor(private service: DetalleService, private fb: FormBuilder, private routes: Router) { }

  ngOnInit(): void {
    this.Forms = this.fb.group({
      id_producto: [null, Validators.required],
      cantidad: [null, Validators.required],
    });
    this.Get();
  }
  Get(): void {
    this.dataSource = undefined;
    this.service.Get(JSON.parse(localStorage.getItem('factura')).id_factura).subscribe(
      (res) => {
        this.dataSource = res;
      }
    );
  }
  onSubmit(): void {
    if (JSON.parse(localStorage.getItem('factura')).estado === 'CREADA' ||
      JSON.parse(localStorage.getItem('factura')).estado === 'PROCESO') {
      if (this.OnValidarProducto()) {
        this.meessage = 'CARGANDO...';
        if (this.estado === 0) {
          if ((this.productoValor.stock - parseInt(this.Forms.value.cantidad, 10)) >= 0) {
            this.service.Post({
              id_factura: JSON.parse(localStorage.getItem('factura')).id_factura,
              id_articulo: this.productoValor.id_articulo,
              precio: this.productoValor.precio,
              cantidad: this.Forms.value.cantidad
            }).subscribe(
              (res) => {
                this.productoValor = undefined;
                this.meessage = res;
                this.Get();
                this.OnCancelar();
              }
            );
          } else {
            this.meessage = 'no se puede realizar la compra por falta de stock';
          }
        }
      } else if (this.estado === 2) {
        this.service.Delete(this.id_factura, this.id_articulo).subscribe(
          (res) => {
            this.meessage = res;
            this.Get();
            this.OnCancelar();
          }
        );
      } else {
        this.meessage = 'Verifique si el Producto existe';
      }
    } else {
      this.meessage = 'Ya no puede realizar nigun cambio';
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
    this.id_factura = element.id_factura;
    this.id_articulo = element.id_articulo;
    this.mensaje = 'ELIMINAR';
    this.estado = 2;
    this.cancelar = true;
    this.eliminar = true;
    this.mensajeEliminar = `Deseas eliminar el detalle En verdad la factura con el ID: ${element.id_factura}`;
  }
  OnBuscarProducto(): void {
    this.service.GetProducto(this.Forms.value.id_producto, localStorage.getItem('_tienda')).subscribe(
      (res) => {
        this.productoValor = res;
      }
    );
  }
  OnValidarProducto(): boolean {
    if (typeof this.productoValor !== 'undefined') {
      return true;
    } else {
      return false;
    }
  }
  OnCargar(): boolean {
    if (typeof this.dataSource === 'undefined') {
      return false;
    } else {
      return true;
    }
  }
  OnTerminar(): void {
    if (JSON.parse(localStorage.getItem('factura')).estado === 'CREADA' ||
      JSON.parse(localStorage.getItem('factura')).estado === 'PROCESO') {
      this.service.ChangeStatus(JSON.parse(localStorage.getItem('factura')).id_factura, 'CANCELADA').subscribe(
        (res) => {
          if (res === 'UPDATED STATUS SUCCESFULY') {
            this.routes.navigate(['factura']);
          }
        }
      );
    } else {
      this.meessage = 'NO SE PUDE CAMBIAR EL ESTADO DE LA FACTURA';
    }
  }
}

