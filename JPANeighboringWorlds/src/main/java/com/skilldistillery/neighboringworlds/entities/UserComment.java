package com.skilldistillery.neighboringworlds.entities;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Table(name = "user_comment")
@Entity
public class UserComment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String title;

	private String content;

	@Column(name = "comment_date")
	@CreationTimestamp
	private LocalDateTime commentDate;

	// TODO fk user_id
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;
	// TODO fk an_event_id
	@ManyToOne
	@JoinColumn(name = "an_event_id")
	private CultureEvent cultureEvent;

	@JsonIgnore
	@OneToMany(mappedBy = "inReplyTo")
	private List<UserComment> replies;

	@ManyToOne
	@JoinColumn(name = "in_reply_to_id")
	private UserComment inReplyTo;

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

	public List<UserComment> getReplies() {
		return replies;
	}

	public void setReplies(List<UserComment> replies) {
		this.replies = replies;
	}

	public UserComment getInReplyTo() {
		return inReplyTo;
	}

	public void setInReplyTo(UserComment inReplyTo) {
		this.inReplyTo = inReplyTo;
	}

	@Override
	public String toString() {
		return "UserComment [id=" + id + ", title=" + title + ", content=" + content + ", commentDate=" + commentDate
				+ ", user=" + user + ", cultureEvent=" + cultureEvent + ", inReplyTo=" + inReplyTo + "]";
	}

}
