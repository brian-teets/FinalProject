package com.skilldistillery.neighboringworlds.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.neighboringworlds.entities.Review;
import com.skilldistillery.neighboringworlds.services.ReviewService;

@RestController
@CrossOrigin({ "*", "http://localhost" })
@RequestMapping("api")
public class ReviewController {
	
	@Autowired
	private ReviewService revServ;
	
	// currently viewable by all - later could lockdown to only admin
	
	@GetMapping("reviews-all")
	public List<Review> index(){
		return revServ.index();
	}
	
	@GetMapping("culture-events/{cid}/reviews/{uid}")
	public Review getReview(@PathVariable int cid, @PathVariable int uid, HttpServletRequest req, HttpServletResponse res){
		
		Review review = revServ.show(cid, uid);
		
		if (review == null) {
			res.setStatus(404);
		}
		return review;
	}
	

}
