import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AedDetailsComponent } from './aed-details.component';

describe('AedDetailsComponent', () => {
  let component: AedDetailsComponent;
  let fixture: ComponentFixture<AedDetailsComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [AedDetailsComponent]
    });
    fixture = TestBed.createComponent(AedDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
