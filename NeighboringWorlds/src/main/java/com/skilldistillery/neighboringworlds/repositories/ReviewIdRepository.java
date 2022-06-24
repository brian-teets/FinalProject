package com.skilldistillery.neighboringworlds.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.neighboringworlds.entities.ReviewId;

public interface ReviewIdRepository extends JpaRepository<ReviewId, Integer>{
	
	ReviewId findByUserId(int uid);
	ReviewId findByEventId(int cid);
	ReviewId findByEventIdAndUserId(int cid, int aid); 

}
