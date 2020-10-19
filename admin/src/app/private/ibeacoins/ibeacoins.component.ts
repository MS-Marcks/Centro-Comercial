import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { Ibeacoins } from 'src/app/models/ibeacoins/ibeacoins';
import { IbeacoinsService } from './../../service/ibeacoins/ibeacoins.service';


@Component({
  selector: 'app-ibeacoins',
  templateUrl: './ibeacoins.component.html',
  styleUrls: ['./ibeacoins.component.css']
})
export class IbeacoinsComponent implements OnInit {

  dataSource: Ibeacoins[];
  displayedColumns = ['identifier', 'uuid', 'major', 'minor', 'editar', 'eliminar'];
  Forms: FormGroup;

  estado = 0;
  eliminar = false;
  mensaje = 'CREAR';
  cancelar = false;
  mensajeEliminar;
  id = '';
  meessage;

  constructor(private service: IbeacoinsService, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.Forms = this.fb.group({
      identifier: [null, Validators.required],
      uuid: [null, Validators.required],
      major: [null, Validators.required],
      minor: [null, Validators.required]
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
    this.id = element.identifier;
    this.mensaje = 'ELIMINAR';
    this.estado = 2;
    this.cancelar = true;
    this.eliminar = true;
    this.mensajeEliminar = `Deseas Eliminar En verdad el Ibeacoins: ${element.uuid} Con ID ${element.identifier}`;
  }
  OnCargar(): boolean {
    if (typeof this.dataSource === 'undefined') {
      return false;
    } else {
      return true;
    }
  }
}
