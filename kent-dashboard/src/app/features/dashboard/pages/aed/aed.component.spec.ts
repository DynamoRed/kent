import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AedComponent } from './aed.component';

describe('AedComponent', () => {
  let component: AedComponent;
  let fixture: ComponentFixture<AedComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [AedComponent]
    });
    fixture = TestBed.createComponent(AedComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
