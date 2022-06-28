import { TestBed } from '@angular/core/testing';

import { DiscussionBoardService } from './discussion-board.service';

describe('DiscussionBoardService', () => {
  let service: DiscussionBoardService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(DiscussionBoardService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
