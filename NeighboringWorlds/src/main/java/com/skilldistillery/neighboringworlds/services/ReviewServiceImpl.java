package com.skilldistillery.neighboringworlds.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.neighboringworlds.entities.Review;
import com.skilldistillery.neighboringworlds.repositories.ReviewRepository;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private ReviewRepository reviewRepo;
	

	
	@Override
	public List<Review> index() {
		return reviewRepo.findAll();
	}
	

	// Need to sort this out
	// Currently getting error "The given domain class does not
	// contain an id attribute"
	
	@Override
	public Review show(int cid, int aid) {
		Review review = null;
		review = reviewRepo.findByCultureEvent_IdAndUser_Id(cid, aid);
		return review;
	}
	

	
	@Override
	public Review create(Review rev) {
		// TODO Auto-generated method stub
		return null;
	}
	

	
	@Override
	public Review delete(int rid) {
		// TODO Auto-generated method stub
		return null;
	}
	

	

	

	
	
}
