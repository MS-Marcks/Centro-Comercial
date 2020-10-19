import { TestBed } from '@angular/core/testing';

import { IbeacoinsService } from './ibeacoins.service';

describe('IbeacoinsService', () => {
  let service: IbeacoinsService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(IbeacoinsService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
