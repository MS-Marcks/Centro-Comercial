import { ComponentFixture, TestBed } from '@angular/core/testing';

import { IbeacoinsComponent } from './ibeacoins.component';

describe('IbeacoinsComponent', () => {
  let component: IbeacoinsComponent;
  let fixture: ComponentFixture<IbeacoinsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ IbeacoinsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(IbeacoinsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
