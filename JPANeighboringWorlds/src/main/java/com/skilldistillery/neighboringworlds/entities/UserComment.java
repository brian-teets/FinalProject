package com.skilldistillery.neighboringworlds.entities;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

@Table(name="user_comment")
@Entity
public class UserComment {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String title;
	
	private String content;
	
	@Column(name="comment_date")
	@CreationTimestamp
	private LocalDateTime commentDate;
	
	//TODO fk user_id
	//TODO fk an_event_id
	
	@Column(name="in_reply_to_id")
	private Integer inReplyToId;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public LocalDateTime getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(LocalDateTime commentDate) {
		this.commentDate = commentDate;
	}

	public int getInReplyToId() {
		return inReplyToId;
	}

	public void setInReplyToId(int inReplyToId) {
		this.inReplyToId = inReplyToId;
	}

	@Override
	public String toString() {
		return "UserComment [id=" + id + ", title=" + title + ", content=" + content + ", commentDate=" + commentDate
				+ ", inReplyToId=" + inReplyToId + "]";
	}
	
	

}
