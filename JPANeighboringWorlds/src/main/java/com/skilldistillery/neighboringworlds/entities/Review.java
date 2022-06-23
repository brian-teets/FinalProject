package com.skilldistillery.neighboringworlds.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class Review {

	//reviewID
	@EmbeddedId
	private ReviewId Id;
	
	private int rating;
	
	@Column(name="review_content")
	private String reviewContent;
	
	@Column(name="review_date")
	@CreationTimestamp
	private LocalDateTime reviewDate;
	
	@ManyToOne
	@JoinColumn(name="attendee_user_id")
	@MapsId(value="userId")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="attendee_an_event_id")
	@MapsId(value="eventId")
	private CultureEvent cultureEvent;
	
	
	
			
	public ReviewId getId() {
		return Id;
	}

	public void setId(ReviewId id) {
		Id = id;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public LocalDateTime getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(LocalDateTime reviewDate) {
		this.reviewDate = reviewDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public CultureEvent getCultureEvent() {
		return cultureEvent;
	}

	public void setCultureEvent(CultureEvent cultureEvent) {
		this.cultureEvent = cultureEvent;
	}

	@Override
	public String toString() {
		return "Review [Id=" + Id + ", rating=" + rating + ", reviewContent=" + reviewContent + ", reviewDate="
				+ reviewDate + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(Id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Review other = (Review) obj;
		return Objects.equals(Id, other.Id);
	}

	


	
	
	
	
}
