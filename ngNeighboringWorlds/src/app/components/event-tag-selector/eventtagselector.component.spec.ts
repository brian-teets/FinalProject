import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EventtagselectorComponent } from './eventtagselector.component';

describe('EventtagselectorComponent', () => {
  let component: EventtagselectorComponent;
  let fixture: ComponentFixture<EventtagselectorComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ EventtagselectorComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EventtagselectorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
