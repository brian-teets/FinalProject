package com.skilldistillery.neighboringworlds.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.neighboringworlds.entities.Review;
import com.skilldistillery.neighboringworlds.entities.ReviewId;
import com.skilldistillery.neighboringworlds.repositories.ReviewIdRepository;
import com.skilldistillery.neighboringworlds.repositories.ReviewRepository;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private ReviewRepository reviewRepo;
	@Autowired
	private ReviewIdRepository reviewIdRepo;
	

	@Override
	public List<Review> index() {
		return reviewRepo.findAll();
	}

	// Need to sort this out
	// Currently getting error "The given domain class does not
	// contain an id attribute"
	@Override
	public Review show(int cid, int aid) {
		ReviewId thisRid = reviewIdRepo.findByEventIdAndUserId(cid, aid);
		Review review = null;
		if(thisRid != null) {
			Optional<Review> rev = reviewRepo.findById(thisRid);
			if(rev != null) {
				review = rev.get(); 
			}
		}
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
