package com.skilldistillery.neighboringworlds.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.neighboringworlds.entities.EventTag;

public interface EventTagRepository extends JpaRepository<EventTag, Integer>{
	
	List<EventTag> findAllByKeyword(String keyword);

}
