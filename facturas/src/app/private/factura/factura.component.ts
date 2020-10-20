import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { Component, OnInit } from '@angular/core';
import { Cliente } from 'src/app/models/cliente/cliente';
import { Factura } from './../../models/factura/factura';
import { FacturaService } from './../../service/factura/factura.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-factura',
  templateUrl: './factura.component.html',
  styleUrls: ['./factura.component.css']
})
export class FacturaComponent implements OnInit {

  dataSource: Factura[];
  displayedColumns = ['id_factura', 'empleado', 'cliente', 'nit', 'direccion', 'total', 'estado', 'detalle', 'eliminar'];
  Forms: FormGroup;
  clienteValor: Cliente;
  estado = 0;
  eliminar = false;
  mensaje = 'CREAR';
  cancelar = false;
  mensajeEliminar;
  id = 0;
  meessage;

  constructor(private service: FacturaService, private fb: FormBuilder, private routes:Router) { }

  ngOnInit(): void {
    this.Forms = this.fb.group({
      id_factura: null,
      nit: [null, Validators.required],
      estado: null
    });
    this.Get();
  }
  Get(): void {
    this.dataSource = undefined;
    this.service.Get(localStorage.getItem('_tienda')).subscribe(
      (res) => {
        this.dataSource = res;
      }
    );
  }
  onSubmit(): void {
    if (this.OnValidarCliente()) {
      this.meessage = 'CARGANDO...';
      if (this.estado === 0) {
        this.service.Post({
          uuid: localStorage.getItem('_uuid'),
          id_cliente: this.clienteValor.id_persona,
          nit: this.clienteValor.nit,
          direccion: this.clienteValor.direccion
        }).subscribe(
          (res) => {
            this.clienteValor = undefined;
            this.meessage = res;
            this.Get();
            this.OnCancelar();
          }
        );
      }
    } else if (this.estado === 2) {
      this.service.Delete(this.id).subscribe(
        (res) => {
          this.meessage = res;
          this.Get();
          this.OnCancelar();
        }
      );
    } else {
      this.meessage = 'Verifique si el cliente existe';
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
    this.id = element.id_factura;
    this.mensaje = 'ELIMINAR';
    this.estado = 2;
    this.cancelar = true;
    this.eliminar = true;
    this.mensajeEliminar = `Deseas anular En verdad la factura con el ID: ${element.id_factura}`;
  }
  OnBuscarCliente(): void {
    this.service.GetCliente(this.Forms.value.nit).subscribe(
      (res) => {
        this.clienteValor = res;
      }
    );
  }
  OnValidarCliente(): boolean {
    if (typeof this.clienteValor !== 'undefined') {
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
  OnDetalle(element): void {
    if (element.estado === 'CREADA') {
      this.service.ChangeStatus(element.id_factura, 'PROCESO').subscribe(
        (res) => {
          if (res === 'UPDATED STATUS SUCCESFULY') {
            localStorage.getItem('factura');
            localStorage.getItem('cliente');
            localStorage.setItem('factura', JSON.stringify(element));
            localStorage.setItem('cliente', JSON.stringify(this.clienteValor));
            this.routes.navigate(['detalle']);
          }
        }
      );
    } else {
      localStorage.getItem('factura');
      localStorage.getItem('cliente');
      localStorage.setItem('factura', JSON.stringify(element));
      localStorage.setItem('cliente', JSON.stringify(this.clienteValor));
      this.routes.navigate(['detalle']);
    }
  }
}

