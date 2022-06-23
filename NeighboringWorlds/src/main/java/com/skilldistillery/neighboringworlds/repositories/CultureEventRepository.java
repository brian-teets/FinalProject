package com.skilldistillery.neighboringworlds.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.neighboringworlds.entities.CultureEvent;

public interface CultureEventRepository extends JpaRepository<CultureEvent, Integer> {
	
	CultureEvent findByIdAndHost_Username(Integer cid, String username);

}
