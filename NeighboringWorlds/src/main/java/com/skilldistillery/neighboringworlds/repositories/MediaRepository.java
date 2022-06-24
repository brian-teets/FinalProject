package com.skilldistillery.neighboringworlds.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.neighboringworlds.entities.Media;

public interface MediaRepository extends JpaRepository<Media, Integer> {
	
	Media findById(int mid);
	List <Media> findAllByUserComment_Id(int ucid);
	List<Media> findAllByUserComment_User_Username(String username);
	List<Media> findAllByUserComment_CultureEvent_Id(int cid);

}
