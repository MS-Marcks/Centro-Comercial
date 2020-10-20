import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { SecurityService } from './../../service/security/security.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  LoginFrom: FormGroup;
  constructor(private fb: FormBuilder, private serviceSecurity: SecurityService, private routes: Router) { }
  ngOnInit(): void {
    this.LoginFrom = this.fb.group({
      usuario: [null, Validators.required],
      pass: [null, Validators.required]
    });
  }
  onSubmit(): void {
    this.serviceSecurity.login(this.LoginFrom.value).subscribe(
      (res) => {
        if (typeof res.token !== 'undefined') {
          localStorage.setItem('token', res.token);
          localStorage.setItem('_tienda', res.id_tienda);
          localStorage.setItem('_uuid', res.uuid);
          this.routes.navigate(['cliente']);
        }
      }
    );
  }
}
