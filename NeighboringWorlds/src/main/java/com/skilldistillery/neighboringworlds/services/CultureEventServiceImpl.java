package com.skilldistillery.neighboringworlds.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.neighboringworlds.entities.CultureEvent;
import com.skilldistillery.neighboringworlds.repositories.CultureEventRepository;

@Service
public class CultureEventServiceImpl implements CultureEventService {
	
	@Autowired
	private CultureEventRepository cultureEvtRepo;

	@Override
	public List<CultureEvent> index() {
		return cultureEvtRepo.findAll();
	}

	@Override
	public CultureEvent show(int cid) {
		Optional <CultureEvent> eventOpt = cultureEvtRepo.findById(cid);
		CultureEvent event = null;
		if(eventOpt.isPresent()) {
			event = eventOpt.get();
		}
		return event;
	}

	@Override
	public CultureEvent create(CultureEvent cEvt) {
		// Do we want to set any defaults or just handle on front end form? 
		
		return cultureEvtRepo.saveAndFlush(cEvt);
	}

	@Override
	public CultureEvent modify(CultureEvent cEvt, int cid, String username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Boolean delete(int cid, String username) {
		// TODO Auto-generated method stub
		return null;
	}

}
