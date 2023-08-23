import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AedDetailComponent } from './aed-detail.component';

describe('AedDetailComponent', () => {
  let component: AedDetailComponent;
  let fixture: ComponentFixture<AedDetailComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [AedDetailComponent]
    });
    fixture = TestBed.createComponent(AedDetailComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
