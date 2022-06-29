package com.skilldistillery.neighboringworlds.repositories;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.neighboringworlds.entities.CultureEvent;

public interface CultureEventRepository extends JpaRepository<CultureEvent, Integer> {
	
	CultureEvent findByIdAndHost_Username(Integer cid, String username);
	
	CultureEvent queryById(Integer cid);
	
	@Transactional
	@Modifying
	@Query(value="INSERT INTO attendee (an_event_id, user_id) VALUES(:cid, :uid)", nativeQuery=true)
	void createAttendee(@Param("cid") Integer cid, @Param("uid") Integer uid);
	
	@Query(value = "SELECT * FROM an_event WHERE an_event.description LIKE '%:keyword%'", nativeQuery = true)
	List<CultureEvent> findByDescription(@Param("keyword") String keyword);
	
	List<CultureEvent> findByDescriptionContaining(String pattern);
	List<CultureEvent> findByTitleContaining(String pattern);

}
