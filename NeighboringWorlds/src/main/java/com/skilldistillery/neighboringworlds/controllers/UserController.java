package com.skilldistillery.neighboringworlds.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.neighboringworlds.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost"})
public class UserController {
	
	@Autowired
	private UserService userSvc;

}
