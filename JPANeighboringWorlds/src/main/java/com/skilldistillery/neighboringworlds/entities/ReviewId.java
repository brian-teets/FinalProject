package com.skilldistillery.neighboringworlds.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class ReviewId implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Column(name="attendee_an_event_id")
	private int eventId;
	
	@Column(name="attendee_user_id")
	private int userId;
	
	public ReviewId() {
		super();
	}
	
	
	public ReviewId(int eventId, int userId) {
		super();
		this.eventId = eventId;
		this.userId = userId;
	}


	public int getEventId() {
		return eventId;
	}

	public void setEventId(int eventId) {
		this.eventId = eventId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	@Override
	public int hashCode() {
		return Objects.hash(eventId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ReviewId other = (ReviewId) obj;
		return eventId == other.eventId && userId == other.userId;
	}

	@Override
	public String toString() {
		return "ReviewId [eventId=" + eventId + ", userId=" + userId + "]";
	}

	
}
