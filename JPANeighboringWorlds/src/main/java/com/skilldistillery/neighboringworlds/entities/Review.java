package com.skilldistillery.neighboringworlds.entities;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class Review {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private int rating;
	
	@Column(name="review_content")
	private String reviewContent;
	
	@Column(name="review_date")
	@CreationTimestamp
	private LocalDateTime reviewDate;
	
	//FK
	
	private int attendeeAnEventId;
	
	//FK
	@OneToMany
	@JoinColumn
	private int attendeeUserId;

	
	
	
	
}
