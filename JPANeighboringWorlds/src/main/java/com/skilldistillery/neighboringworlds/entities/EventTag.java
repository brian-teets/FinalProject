package com.skilldistillery.neighboringworlds.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Table(name="event_tag")
@Entity
public class EventTag {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String keyword;
	
	@JsonIgnore
	@ManyToMany(mappedBy = "tags")
	private List<CultureEvent> events;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	

	public List<CultureEvent> getEvents() {
		return events;
	}

	public void setEvents(List<CultureEvent> events) {
		this.events = events;
	}


	@Override
	public String toString() {
		return "EventTag [id=" + id + ", keyword=" + keyword + ", events=" + events + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		EventTag other = (EventTag) obj;
		return id == other.id;
	}
	
	
	
	
}
