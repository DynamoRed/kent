import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AedMapComponent } from './aed-map.component';

describe('AedMapComponent', () => {
  let component: AedMapComponent;
  let fixture: ComponentFixture<AedMapComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [AedMapComponent]
    });
    fixture = TestBed.createComponent(AedMapComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
