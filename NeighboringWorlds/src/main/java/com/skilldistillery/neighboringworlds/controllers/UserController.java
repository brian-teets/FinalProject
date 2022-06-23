package com.skilldistillery.neighboringworlds.controllers;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	@PutMapping("profile")
	public User update(HttpServletRequest req, HttpServletResponse res, @RequestBody User user, Principal principal) {
		User upUser;
		System.out.println("requestbody user is not null: " + user != null);
		try {
			upUser = userService.updateUser(principal.getName(), user);
			if (upUser != null) {
				res.setStatus(201);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			upUser = null;
		}
		return upUser;
	}
}
