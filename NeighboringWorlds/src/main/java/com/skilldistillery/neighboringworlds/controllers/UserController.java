package com.skilldistillery.neighboringworlds.controllers;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.neighboringworlds.entities.User;
import com.skilldistillery.neighboringworlds.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost"})
public class UserController {
	
	@Autowired
	private UserService userService;
	
	// SMOKE TEST ONLY, DELETE/COMMENT OUT LATER
	@GetMapping("test/users/{userId}")
	public User getUserForTest(
	  @PathVariable Integer userId,
	  HttpServletResponse res
	) {
	  User user = userService.getUserById(userId);
	  if (user == null) {
	    res.setStatus(404);
	  }
	  return user;
	}

}
