import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AedListComponent } from './aed-list.component';

describe('AedListComponent', () => {
  let component: AedListComponent;
  let fixture: ComponentFixture<AedListComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [AedListComponent]
    });
    fixture = TestBed.createComponent(AedListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
