package com.skilldistillery.neighboringworlds.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.neighboringworlds.entities.EventTag;
import com.skilldistillery.neighboringworlds.repositories.EventTagRepository;

@Service
public class EventTagServiceImpl implements EventTagService {
	
	@Autowired
	EventTagRepository etRepo;

	@Override
	public EventTag create(EventTag evtTag) {
		return etRepo.saveAndFlush(evtTag);
	}

	@Override
	public List<EventTag> show(String keyword) {
		return etRepo.findAllByKeyword(keyword);
	}
	
	@Override
	public List<EventTag> showAll( ) {
		return etRepo.findAll();
	}
	
	

}
