import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { Inventario } from 'src/app/models/inventario/inventario';
import { InventarioService } from './../../service/inventario/inventario.service';

@Component({
  selector: 'app-inventario',
  templateUrl: './inventario.component.html',
  styleUrls: ['./inventario.component.css']
})
export class InventarioComponent implements OnInit {

  dataSource: Inventario[];
  displayedColumns = ['id_articulo', 'tienda', 'tipo', 'articulo', 'descripcion', 'precio', 'stock', 'imagen'];
  Forms: FormGroup;

  estado = 0;
  eliminar = false;
  mensaje = 'CREAR';
  cancelar = false;
  mensajeEliminar;
  id = 0;
  meessage;
  formData: FormData = new FormData();
  imagen = '';
  data = {
    id_tienda: null,
    id_tipo: null,
    articulo: null,
    descripcion: null,
    precio: null,
    imagen: null
  };

  constructor(private service: InventarioService, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.Forms = this.fb.group({
      id_tienda: [null, Validators.required],
      id_tipo: [null, Validators.required],
      articulo: [null, Validators.required],
      descripcion: [null, Validators.required],
      precio: [null, Validators.required],
      imagen: null
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
      this.data = this.Forms.value;
      this.data.imagen = this.imagen;
      this.formData.append('data', JSON.stringify(this.data));
      this.service.Post(this.formData).subscribe(
        (res) => {
          this.formData = new FormData();
          this.data = {
            id_tienda: null,
            id_tipo: null,
            articulo: null,
            descripcion: null,
            precio: null,
            imagen: null
          };
          this.meessage = res;
          this.Get();
          this.OnCancelar();
        }
      );
    }
  }
  uploadFile(e: File): void {
    this.formData.delete('articulo');
    this.formData.append('articulo', e[0], e[0].name);
    this.imagen = e[0].name;
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
