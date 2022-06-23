package com.skilldistillery.neighboringworlds.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.neighboringworlds.entities.CultureEvent;
import com.skilldistillery.neighboringworlds.services.CultureEventService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class CultureEventController {
	
	@Autowired
	private CultureEventService cEvtServ;
	
	
	@GetMapping("culture-events")
	public List<CultureEvent> index(){
		return cEvtServ.index();
	}
	
	@GetMapping("culture-events/{cid}")
	public CultureEvent show(@PathVariable int cid) {
		return cEvtServ.show(cid);
	}

}
