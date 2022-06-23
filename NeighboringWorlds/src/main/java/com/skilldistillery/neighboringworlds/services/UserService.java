package com.skilldistillery.neighboringworlds.services;

import java.util.Optional;

import com.skilldistillery.neighboringworlds.entities.User;

public interface UserService {
	
User getUserById(int userId);

User createUser(User newUser);
User updateUser(String username, User upUser);
}
