package com.skilldistillery.neighboringworlds.controllers;

import java.security.Principal;
import java.util.List;

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
	
	//TODO lockdown to owner?
	@GetMapping("culture-events/{cid}/media")
	public List<Media> indexEventMedia(@PathVariable Integer cid) {
		return medServ.indexEventMedia(cid);
	}
	
	@GetMapping("comments/{ucid}/media")
	public List<Media> show(@PathVariable Integer ucid) {
		return medServ.show(ucid);
	}
	
	@PostMapping("comments/{ucid}/media")
	public Media create(@RequestBody Media med, @PathVariable Integer ucid, HttpServletResponse res, HttpServletRequest req,
			Principal principal) {
		try {
			med = medServ.create(med, ucid, principal.getName());
			if(med == null) {
				res.setStatus(404);
			} else {
				res.setStatus(201);
				StringBuffer url = req.getRequestURL();
				url.append("/").append(med.getId());
				res.setHeader("Location", url.toString());
			}
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
			med = null;
		}
		
		return med;
	}
	
	
	
}
