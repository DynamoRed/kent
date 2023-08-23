import { TestBed } from '@angular/core/testing';

import { AedService } from './aed.service';

describe('AedService', () => {
  let service: AedService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(AedService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
