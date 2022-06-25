package com.skilldistillery.neighboringworlds.services;

import java.util.List;

import com.skilldistillery.neighboringworlds.entities.EventTag;

public interface EventTagService {
	
	EventTag create(EventTag evtTag);
	List<EventTag> show(String keyword);
	List<EventTag> showAll();

}
