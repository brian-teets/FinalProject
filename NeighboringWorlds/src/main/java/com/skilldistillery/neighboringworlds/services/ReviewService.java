package com.skilldistillery.neighboringworlds.services;

import java.util.List;

import com.skilldistillery.neighboringworlds.entities.Review;
import com.skilldistillery.neighboringworlds.entities.ReviewId;

public interface ReviewService {

	List<Review> index();
	Review show(int cid, int aid); 
	Review create(Review rev, int cid, String username);
	Review delete(int rid);
	
}
