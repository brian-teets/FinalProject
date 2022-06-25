package com.skilldistillery.neighboringworlds.services;

import java.util.List;

import com.skilldistillery.neighboringworlds.entities.Review;
import com.skilldistillery.neighboringworlds.entities.ReviewId;

public interface ReviewService {

	List<Review> index();
//	Review show(int cid, int aid); // culture id and attendee id
	Review create(Review rev);
	Review delete(int rid);
	
}
