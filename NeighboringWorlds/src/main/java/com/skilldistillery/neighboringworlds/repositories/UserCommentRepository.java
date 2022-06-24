package com.skilldistillery.neighboringworlds.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.neighboringworlds.entities.UserComment;

public interface UserCommentRepository extends JpaRepository<UserComment, Integer> {

	UserComment findById(int ucid);
	UserComment findByIdAndUser_Username(int ucid, String username);
	List<UserComment> findAllByUser_Username(String username);
	List<UserComment> findAllByCultureEvent_Id(int cid);
	
}
