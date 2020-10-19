import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { Compra } from 'src/app/models/compra/compra';
import { Inventario } from 'src/app/models/inventario/inventario';
import { CompraService } from './../../service/compra/compra.service';
import { Proveedor } from 'src/app/models/proveedor/proveedor';

@Component({
  selector: 'app-compra',
  templateUrl: './compra.component.html',
  styleUrls: ['./compra.component.css']
})
export class CompraComponent implements OnInit {

  dataSource: Compra[];
  displayedColumns = ['id_compra', 'proveedor', 'articulo', 'cantidad', 'precio', 'total'];
  Forms: FormGroup;
  articulovalores: Inventario;
  proveedorvalores: Proveedor;
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
    if (this.Forms.value.id_proveedor !== null && this.Forms.value.id_articulo !== null && this.Forms.value.cantidad !== null && this.Forms.value.precio !== null) {
      if (typeof this.articulovalores !== 'undefined' &&  typeof this.proveedorvalores !== 'undefined' ) {
        this.meessage = 'CARGANDO...';

        if (this.estado === 0) {
          this.service.Post(this.Forms.value).subscribe(
            (res) => {
              this.articulovalores = undefined;
              this.proveedorvalores = undefined;
              this.meessage = res;
              this.Get();
              this.OnCancelar();
            }
          );
        }
      }else {
        this.meessage = 'Verificar si el Articulo y el Proveedor existen!';
      }
    }else {
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
  OnBuscarArticulo(): void {
    this.service.GetArticulo(this.Forms.value.id_articulo).subscribe(
      (res) => {
        this.articulovalores = res;
      //  console.log(res);
      }
    );
  }
  OnValidarArticulo(): boolean {
    if (typeof this.articulovalores !== 'undefined') {
      return true;
    } else {
      return false;
    }
  }
  OnBuscarProveedor(): void {
    // console.log(this.Forms.value.id_articulo);
    this.service.GetProveedor(this.Forms.value.id_proveedor).subscribe(
      (res) => {
        this.proveedorvalores = res;
      }
    );
  }
  OnValidarProveedor(): boolean {
    if (typeof this.proveedorvalores !== 'undefined') {
      return true;
    } else {
      return false;
    }
  }
}
