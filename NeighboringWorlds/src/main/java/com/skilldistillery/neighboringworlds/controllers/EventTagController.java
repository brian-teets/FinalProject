package com.skilldistillery.neighboringworlds.controllers;

import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.neighboringworlds.entities.CultureEvent;
import com.skilldistillery.neighboringworlds.entities.EventTag;
import com.skilldistillery.neighboringworlds.services.EventTagService;

@RestController
@CrossOrigin({ "*", "http://localhost" })
@RequestMapping("api")
public class EventTagController {
	
	@Autowired
	private EventTagService evtTagServ;
	
	@GetMapping("tags/{keyword}")
	public List<EventTag> showTagsByKeyword(@PathVariable String keyword, HttpServletResponse res, HttpServletRequest req){
		return evtTagServ.show(keyword);
	}
	
	@GetMapping("tags")
	public List<EventTag> showAllTags(){
		return evtTagServ.showAll();
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

}
