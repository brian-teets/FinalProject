package com.skilldistillery.neighboringworlds.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	// User - CultureEvent Join Table mapping
	@JsonIgnore
	@ManyToMany(mappedBy = "attendees")
	private List<CultureEvent> events;

	@Column(name = "first_name")
	private String fName;

	@Column(name = "last_name")
	private String lName;

	private String email;
	private String phone;
	private String username;
	private String password;

	@Column(name = "date_created")
	@CreationTimestamp
	private LocalDateTime dateCreated;

	private Boolean enabled;
	private String role;

	@Column(name = "profile_img_url")
	private String profileImgUrl;

	@Column(name = "banner_img_url")
	private String bannerImgUrl;

	private String biography;

	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<Review> reviews;
	
	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<UserComment> comments;

	public User() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public List<CultureEvent> getEvents() {
		return events;
	}

	public void setEvents(List<CultureEvent> events) {
		this.events = events;
	}

	public String getfName() {
		return fName;
	}

	public void setfName(String fName) {
		this.fName = fName;
	}

	public String getlName() {
		return lName;
	}

	public void setlName(String lName) {
		this.lName = lName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public LocalDateTime getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(LocalDateTime dateCreated) {
		this.dateCreated = dateCreated;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getProfileImgUrl() {
		return profileImgUrl;
	}

	public void setProfileImgUrl(String profileImgUrl) {
		this.profileImgUrl = profileImgUrl;
	}

	public String getBannerImgUrl() {
		return bannerImgUrl;
	}

	public void setBannerImgUrl(String bannerImgUrl) {
		this.bannerImgUrl = bannerImgUrl;
	}

	public String getBiography() {
		return biography;
	}

	public void setBiography(String biography) {
		this.biography = biography;
	}

	public List<Review> getReviews() {
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}
	
	

	public List<UserComment> getComments() {
		return comments;
	}

	public void setComments(List<UserComment> comments) {
		this.comments = comments;
	}

	@Override
	public int hashCode() {
		return Objects.hash(events, id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		return Objects.equals(events, other.events) && id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", events=" + events + ", fName=" + fName + ", lName=" + lName + ", email=" + email
				+ ", phone=" + phone + ", username=" + username + ", password=" + password + ", dateCreated="
				+ dateCreated + ", enabled=" + enabled + ", role=" + role + ", profileImgUrl=" + profileImgUrl
				+ ", bannerImgUrl=" + bannerImgUrl + ", biography=" + biography + "]";
	}

}
