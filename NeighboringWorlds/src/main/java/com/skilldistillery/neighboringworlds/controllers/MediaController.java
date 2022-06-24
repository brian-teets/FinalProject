package com.skilldistillery.neighboringworlds.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.neighboringworlds.entities.Media;
import com.skilldistillery.neighboringworlds.services.MediaService;

@RestController
@CrossOrigin({ "*", "http://localhost" })
@RequestMapping("api")
public class MediaController {

	@Autowired
	private MediaService medServ;
	
	
	@GetMapping("media/all")
	public List<Media> index(Principal principal){
		
		return medServ.index(principal.getName());
	}
	
}
