package com.skilldistillery.neighboringworlds.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.neighboringworlds.entities.CultureEvent;
import com.skilldistillery.neighboringworlds.entities.EventTag;
import com.skilldistillery.neighboringworlds.repositories.CultureEventRepository;
import com.skilldistillery.neighboringworlds.repositories.EventTagRepository;
import com.skilldistillery.neighboringworlds.services.EventTagService;

@RestController
@CrossOrigin({ "*", "http://localhost" })
@RequestMapping("api")
public class EventTagController {

	@Autowired
	private EventTagService evtTagServ;
	
	@Autowired
	private EventTagRepository evtTagRepo;

	@Autowired
	private CultureEventRepository cEvtRepo;

	@GetMapping("tags/{keyword}")
	public List<EventTag> showTagsByKeyword(@PathVariable String keyword, HttpServletResponse res,
			HttpServletRequest req) {
		return evtTagServ.show(keyword);
	}

	@GetMapping("tags")
	public List<EventTag> showAllTags() {
		return evtTagServ.showAll();
	}
	
	@GetMapping("culture-events/{cid}/tags")
	public List<EventTag> showEventTags(@PathVariable int cid) {
		return cEvtRepo.findById(cid).get().getTags();
	}
	
	@DeleteMapping("culture-events/{cid}/tags/{keyword}")
	public void removeTag(@PathVariable int cid, @PathVariable String keyword, Principal principal, HttpServletResponse res) {
		CultureEvent evt = cEvtRepo.findByIdAndHost_Username(cid, principal.getName());
		boolean removed = false;
		System.out.println("evt is null?: " + (evt == null));
		if (evt != null) {
			for (EventTag tag : evt.getTags()) {
				System.out.println(tag.getKeyword());
				System.out.println(keyword);
				if (tag.getKeyword().toLowerCase().equals(keyword.toLowerCase())) {
					System.out.println("Inside if, keyword is: " + tag.getKeyword());
					evt.getTags().remove(tag);
					cEvtRepo.save(evt);
					removed = true;
					break;
				}
			}
		}
		if (removed) {
			res.setStatus(201);
		} else {
			res.setStatus(400);
		}
	}
	
	

	@PostMapping("tags")
	public EventTag create(@RequestBody EventTag newEvtTag, HttpServletResponse res, HttpServletRequest req) {
		try {

			newEvtTag = evtTagServ.create(newEvtTag);
			if (newEvtTag != null) {
				res.setStatus(201);
			}

		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
			newEvtTag = null;
		}

		return newEvtTag;
	}

//	@PostMapping("culture-events/{cid}/tags")
//	public EventTag createTagWithEvent(@RequestBody EventTag newEvtTag, @PathVariable int cid, HttpServletResponse res, HttpServletRequest req) {
//		try {
//			
//			newEvtTag = evtTagServ.create(newEvtTag);
//			if (newEvtTag != null) {
//				Optional<CultureEvent> evt = cEvtRepo.findById(cid);
//				if (evt != null) {
//					CultureEvent rEvt = evt.get();
//				}
//				res.setStatus(201);
//			}
//			
//			
//		} catch (Exception e) {
//			res.setStatus(400);
//			e.printStackTrace();
//			newEvtTag = null;
//		}
//		
//		
//		
//		return newEvtTag;
//	}

	@PostMapping("culture-events/{cid}/tags")
	public void addTag(@PathVariable int cid, @RequestBody EventTag tag, Principal principal, HttpServletResponse res) {
		CultureEvent evt = null;
		// Check if tag already exists
		boolean exists = false;
		List<EventTag> allTags = this.showAllTags();
		for (EventTag eventTag : allTags) {
			if (tag.getKeyword().toLowerCase().equals(eventTag.getKeyword().toLowerCase())) {
				exists = true;
				tag = evtTagServ.findByKeyword(tag.getKeyword());
				break;
			}
		}

		if (!exists) {
			tag = this.create(tag, null, null);
		}
		try {
			evt = cEvtRepo.findByIdAndHost_Username(cid, principal.getName());
			if (evt != null) {
				if (!evt.getTags().contains(tag)) {
					evt.getTags().add(tag);
					cEvtRepo.save(evt);
				}
				if (!tag.getEvents().contains(evt)) {
					tag.getEvents().add(evt);
					evtTagRepo.save(tag);
				}
			}

			res.setStatus(201);
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}
	}

}
