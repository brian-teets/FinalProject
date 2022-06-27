package com.skilldistillery.neighboringworlds.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.neighboringworlds.entities.CultureEvent;
import com.skilldistillery.neighboringworlds.entities.Review;
import com.skilldistillery.neighboringworlds.entities.ReviewId;
import com.skilldistillery.neighboringworlds.entities.User;
import com.skilldistillery.neighboringworlds.repositories.CultureEventRepository;
import com.skilldistillery.neighboringworlds.repositories.ReviewRepository;
import com.skilldistillery.neighboringworlds.repositories.UserRepository;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private ReviewRepository reviewRepo;
	
	@Autowired
	private UserRepository userRepo;

	@Autowired
	private CultureEventRepository cEvtRepo;
	

	
	@Override
	public List<Review> index() {
		return reviewRepo.findAll();
	}
	
	
	@Override
	public Review show(int cid, int aid) {
		Review review = null;
		review = reviewRepo.findByCultureEvent_IdAndUser_Id(cid, aid);
		return review;
	}
	

	
	@Override
	public Review create(Review rev, int cid, String username) {
		User attendee = userRepo.findByUsername(username);
		CultureEvent evt = cEvtRepo.queryById(cid);
		if (attendee != null && evt != null) {
			ReviewId id = new ReviewId(cid, attendee.getId());
			rev.setUser(attendee);
			rev.setCultureEvent(evt);
			rev.setId(id);
			Review review = reviewRepo.saveAndFlush(rev);
			return review;
		}
		return null;
	}
	

	
	@Override
	public Review delete(int rid) {
		// TODO Auto-generated method stub
		return null;
	}
	

	

	

	
	
}
