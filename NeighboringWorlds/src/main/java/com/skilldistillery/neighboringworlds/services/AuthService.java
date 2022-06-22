package com.skilldistillery.neighboringworlds.services;

import com.skilldistillery.neighboringworlds.entities.User;

public interface AuthService {

	public User register(User user);
	public User getUserByUsername(String username);
	
}
