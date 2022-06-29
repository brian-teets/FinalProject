package com.skilldistillery.neighboringworlds.services;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.neighboringworlds.entities.CultureEvent;
import com.skilldistillery.neighboringworlds.entities.User;
import com.skilldistillery.neighboringworlds.repositories.AddressRepository;
import com.skilldistillery.neighboringworlds.repositories.CultureEventRepository;
import com.skilldistillery.neighboringworlds.repositories.UserRepository;

@Service
public class CultureEventServiceImpl implements CultureEventService {

	@Autowired
	private CultureEventRepository cultureEvtRepo;

	@Autowired
	private AddressRepository ar;
	
	@Autowired
	private UserRepository userRepo;

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
	public List<User> showAttendees(int cid){
		List<User> attendees;
		CultureEvent evt = null;
		Optional<CultureEvent> oEvt = cultureEvtRepo.findById(cid);
		if (oEvt != null) {
			evt = oEvt.get();
		}
		attendees = evt.getAttendees();
		
		
		return attendees;
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
	public void attend(Integer cid, String username) {
		User attendee = userRepo.findByUsername(username);
		cultureEvtRepo.createAttendee(cid, attendee.getId());
		
		List<CultureEvent> userEvents = attendee.getEvents();
		
		Optional<CultureEvent> oEvt = cultureEvtRepo.findById(cid);
		
		CultureEvent evt = oEvt.get();
		
		if (evt != null && attendee != null) {
			List<User> attendees = evt.getAttendees();
			if (!attendees.contains(attendee)) {
				evt.getAttendees().add(attendee);
			}
			if (!userEvents.contains(evt)) {
				attendee.getEvents().add(evt);
			}
			userRepo.save(attendee);
			cultureEvtRepo.save(evt);
		}
		
		
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

	@Override
	public List<CultureEvent> findByDescriptionContaining(String keyword) {
		return cultureEvtRepo.findByDescriptionContaining(keyword);
	}
	
	@Override
	public List<CultureEvent> findByTitleContaining(String pattern){
		return cultureEvtRepo.findByTitleContaining(pattern);
	}
	

}
