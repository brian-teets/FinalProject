package com.skilldistillery.neighboringworlds.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.neighboringworlds.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	User findByUsername(String username);
	
//	@Modifying
//	@Query(value="INSERT INTO attendee VALUES(:cid, :uid))", nativeQuery=true)
//	Integer insertAttendees(@Param("cid") int cid, @Param("uid") int uid);  
	
	

}
