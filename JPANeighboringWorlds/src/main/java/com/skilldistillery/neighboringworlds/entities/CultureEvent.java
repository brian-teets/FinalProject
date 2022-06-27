package com.skilldistillery.neighboringworlds.entities;

import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "an_event")
public class CultureEvent {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@OneToOne
	@JoinColumn(name = "address_id")
	private Address address;

	@ManyToOne
	@JoinColumn(name = "host_id")
	private User host;

	// CultureEvent - User Join Table mapping
	@JsonIgnore
	@ManyToMany
	@JoinTable(name = "attendee", joinColumns = @JoinColumn(name = "an_event_id"), inverseJoinColumns = @JoinColumn(name = "user_id"))
	private List<User> attendees;

	@JsonIgnore
	@ManyToMany
	@JoinTable(name = "event_tag_has_an_event", joinColumns = @JoinColumn(name = "an_event_id"), inverseJoinColumns = @JoinColumn(name = "event_tag_id"))
	private List<EventTag> tags;

	@JsonIgnore
	@OneToMany(mappedBy = "cultureEvent")
	private List<Review> reviews;

	@Column(name = "event_date")
	private LocalDate eventDate;

	private String title;
	private int capacity;
	private String purpose;
	private String description;

	@Column(name = "start_time")
	private LocalTime startTime;

	@Column(name = "end_time")
	private LocalTime endTime;

	@Column(name = "cover_img_url")
	private String coverImgUrl;

	private Boolean active;

	@Column(name = "created_date")
	@CreationTimestamp
	private LocalDate createdDate;

	@Column(name = "last_updated")
	@UpdateTimestamp
	private LocalDateTime lastUpdated;

	public CultureEvent() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public User getHost() {
		return host;
	}

	public void setHost(User host) {
		this.host = host;
	}

	public List<User> getAttendees() {
		return attendees;
	}

	public void setAttendees(List<User> attendees) {
		this.attendees = attendees;
	}

	public LocalDate getEventDate() {
		return eventDate;
	}

	public void setEventDate(LocalDate eventDate) {
		this.eventDate = eventDate;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public LocalTime getStartTime() {
		return startTime;
	}

	public void setStartTime(LocalTime startTime) {
		this.startTime = startTime;
	}

	public LocalTime getEndTime() {
		return endTime;
	}

	public void setEndTime(LocalTime endTime) {
		this.endTime = endTime;
	}

	public String getCoverImgUrl() {
		return coverImgUrl;
	}

	public void setCoverImgUrl(String coverImgUrl) {
		this.coverImgUrl = coverImgUrl;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public LocalDate getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDate createdDate) {
		this.createdDate = createdDate;
	}

	public LocalDateTime getLastUpdated() {
		return lastUpdated;
	}

	public void setLastUpdated(LocalDateTime lastUpdated) {
		this.lastUpdated = lastUpdated;
	}

	public List<EventTag> getTags() {
		return tags;
	}

	public void setTags(List<EventTag> tags) {
		this.tags = tags;
	}

	public void addTag(EventTag tag) {
		if (!this.tags.contains(tag)) {
			System.out.println("TAG ALREADY EXISTS IN LIST");
		} else {
			this.tags.add(tag);
		}
	}

	public List<Review> getReviews() {
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
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
		CultureEvent other = (CultureEvent) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "CultureEvent [id=" + id + ", address=" + address + ", host=" + host + ", eventDate=" + eventDate
				+ ", title=" + title + ", capacity=" + capacity + ", purpose=" + purpose + ", description="
				+ description + ", startTime=" + startTime + ", endTime=" + endTime + ", coverImgUrl=" + coverImgUrl
				+ ", active=" + active + ", createdDate=" + createdDate + ", lastUpdated=" + lastUpdated + "]";
	}

}
