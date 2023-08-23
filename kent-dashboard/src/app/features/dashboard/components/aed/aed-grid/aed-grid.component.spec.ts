import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AedGridComponent } from './aed-grid.component';

describe('AedGridComponent', () => {
  let component: AedGridComponent;
  let fixture: ComponentFixture<AedGridComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [AedGridComponent]
    });
    fixture = TestBed.createComponent(AedGridComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
