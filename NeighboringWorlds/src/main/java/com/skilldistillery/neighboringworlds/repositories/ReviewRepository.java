package com.skilldistillery.neighboringworlds.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.neighboringworlds.entities.Review;
import com.skilldistillery.neighboringworlds.entities.ReviewId;

public interface ReviewRepository extends JpaRepository<Review, ReviewId> {
	
	Review findByCultureEvent_IdAndUser_Id(int cid, int uid);
	
}
