package com.skilldistillery.neighboringworlds.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.neighboringworlds.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	User findByUsername(String username);

}
