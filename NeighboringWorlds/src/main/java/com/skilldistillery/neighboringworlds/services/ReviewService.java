package com.skilldistillery.neighboringworlds.services;

import java.util.List;

import com.skilldistillery.neighboringworlds.entities.Review;

public interface ReviewService {

	List<Review> index(int cid);
	Review show(int rid);
	Review create(Review rev);
	Review delete(int rid);
	
}
