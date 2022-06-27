package com.skilldistillery.neighboringworlds.controllers;

import java.security.Principal;
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
import com.skilldistillery.neighboringworlds.entities.Review;
import com.skilldistillery.neighboringworlds.entities.User;
import com.skilldistillery.neighboringworlds.repositories.CultureEventRepository;
import com.skilldistillery.neighboringworlds.repositories.UserRepository;
import com.skilldistillery.neighboringworlds.services.ReviewService;

@RestController
@CrossOrigin({ "*", "http://localhost" })
@RequestMapping("api")
public class ReviewController {

	@Autowired
	private ReviewService revServ;
	
	@Autowired 
	private CultureEventRepository cEvtRepo;
	
	@Autowired
	private UserRepository userRepo;

	// currently viewable by all - later could lockdown to only admin

	@GetMapping("reviews-all")
	public List<Review> index() {
		return revServ.index();
	}

	@GetMapping("culture-events/{cid}/reviews/{uid}")
	public Review getReview(@PathVariable int cid, @PathVariable int uid, HttpServletRequest req,
			HttpServletResponse res) {

		Review review = revServ.show(cid, uid);

		if (review == null) {
			res.setStatus(404);
		}
		return review;
	}


	@PostMapping("culture-events/{cid}/reviews")
	public Review postReview(@RequestBody Review rev, 
							@PathVariable Integer cid,
							HttpServletResponse res,
							HttpServletRequest req, 
							Principal principal) {
			try {
				rev = revServ.create(rev, cid, principal.getName());
				res.setStatus(201);
			} catch (Exception e) {
				res.setStatus(404);
				e.printStackTrace();
			}
		
		return rev;
	}
}
