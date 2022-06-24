package com.skilldistillery.neighboringworlds.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.neighboringworlds.entities.CultureEvent;
import com.skilldistillery.neighboringworlds.repositories.AddressRepository;
import com.skilldistillery.neighboringworlds.repositories.CultureEventRepository;

@Service
public class CultureEventServiceImpl implements CultureEventService {

	@Autowired
	private CultureEventRepository cultureEvtRepo;

	@Autowired
	private AddressRepository ar;

	@Override
	public List<CultureEvent> index() {
		return cultureEvtRepo.findAll();
	}

	@Override
	public CultureEvent show(int cid) {
		Optional<CultureEvent> eventOpt = cultureEvtRepo.findById(cid);
		CultureEvent event = null;
		if (eventOpt.isPresent()) {
			event = eventOpt.get();
		}
		return event;
	}

	@Override
	public CultureEvent create(CultureEvent cEvt) {
		// Do we want to set any defaults or just handle on front end form?
		if (cEvt.getAddress() != null) {
			cEvt.setActive(true);
			ar.saveAndFlush(cEvt.getAddress());

			return cultureEvtRepo.saveAndFlush(cEvt);
		}
		return null;

	}

	@Override
	public CultureEvent modify(CultureEvent cEvt, int cid, String username) {
		CultureEvent existing = cultureEvtRepo.findByIdAndHost_Username(cid, username);
		if (cEvt.getAddress() != null) {
			existing.setAddress(cEvt.getAddress());
		}
		if (cEvt.getTags() != null) {
			existing.setTags(cEvt.getTags());
		}
		if (cEvt.getEventDate() != null) {
			existing.setEventDate(cEvt.getEventDate());
		}
		if (cEvt.getTitle() != null) {
			existing.setTitle(cEvt.getTitle());
		}
		if (cEvt.getCapacity() != 0) {
			existing.setCapacity(cEvt.getCapacity());
		}
		if (cEvt.getPurpose() != null) {
			existing.setPurpose(cEvt.getPurpose());
		}
		if (cEvt.getDescription() != null) {
			existing.setDescription(cEvt.getDescription());
		}
		if (cEvt.getStartTime() != null) {
			existing.setStartTime(cEvt.getStartTime());
		}
		if (cEvt.getEndTime() != null) {
			existing.setEndTime(cEvt.getEndTime());
		}
		if (cEvt.getCoverImgUrl() != null) {
			existing.setCoverImgUrl(cEvt.getCoverImgUrl());
		}
		if (cEvt.getActive() != null) {
			existing.setActive(cEvt.getActive());
		}
		return existing;
	}

	@Override
	public Boolean delete(int cid, String username) {
		CultureEvent evtToDelete = cultureEvtRepo.findByIdAndHost_Username(cid, username);
		if (evtToDelete != null) {
			cultureEvtRepo.deleteById(cid);
		}
		return !cultureEvtRepo.existsById(cid);
	}

}
