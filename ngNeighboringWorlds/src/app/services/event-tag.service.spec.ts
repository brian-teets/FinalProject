import { TestBed } from '@angular/core/testing';

import { EventTagService } from './event-tag.service';

describe('EventTagService', () => {
  let service: EventTagService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(EventTagService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
