package com.skilldistillery.neighboringworlds.services;

import java.util.List;

import com.skilldistillery.neighboringworlds.entities.CultureEvent;
import com.skilldistillery.neighboringworlds.entities.UserComment;

public interface UserCommentService {
	
	List <UserComment> index(String username);
	UserComment show(int ucid);
	UserComment create(UserComment uCmt);
	UserComment modify(UserComment uCmt, int ucid, String username);
	Boolean delete(int ucid, String username);

}
