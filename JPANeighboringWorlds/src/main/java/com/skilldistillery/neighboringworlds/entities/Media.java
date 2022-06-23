package com.skilldistillery.neighboringworlds.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;

@Entity
public class Media {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String url;
	
	//TODO fk user_comment_id
	
	private String caption;
	
	// mapped relationships should be complete on this side
	@ManyToOne
	@JoinColumn(name="user_comment_id")
	private UserComment userComment;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getCaption() {
		return caption;
	}

	public void setCaption(String caption) {
		this.caption = caption;
	}
	
	

	public UserComment getUserComment() {
		return userComment;
	}

	public void setUserComment(UserComment userComment) {
		this.userComment = userComment;
	}

	@Override
	public String toString() {
		return "Media [id=" + id + ", url=" + url + ", caption=" + caption + "]";
	}
	
	
	

}
