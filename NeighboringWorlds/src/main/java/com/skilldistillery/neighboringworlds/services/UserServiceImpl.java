package com.skilldistillery.neighboringworlds.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.neighboringworlds.entities.User;
import com.skilldistillery.neighboringworlds.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;

	@Override
	public User getUserById(int userId) {
		Optional<User> userOpt = userRepo.findById(userId);
		User user = null;
		if (userOpt.isPresent()) {
			user = userOpt.get();
		}
		return user;
	}

	@Override
	public User createUser(User newUser) {
		return userRepo.save(newUser);
	}

	@Override
	public User updateUser(String username, User upUser) {
		User inDb = userRepo.findByUsername(username);

		System.out.println(inDb != null);
		if (inDb != null) {
			System.out.println("upUser in seviceimpl: " + upUser.toString());
			if (upUser.getfName() != null) {
				inDb.setfName(upUser.getfName());
			}
			if (upUser.getlName() != null) {
				inDb.setlName(upUser.getlName());
			}
			if (upUser.getEmail() != null) {
				inDb.setEmail(upUser.getEmail());
			}
			if (upUser.getPhone() != null) {
				inDb.setPhone(upUser.getPhone());
			}
			if (upUser.getProfileImgUrl() != null) {
				inDb.setProfileImgUrl(upUser.getProfileImgUrl());
			}
			if (upUser.getBannerImgUrl() != null) {
				inDb.setBannerImgUrl(upUser.getBannerImgUrl());
			}
			if (upUser.getBiography() != null) {
				inDb.setBiography(upUser.getBiography());
			}
			
		
			
//			inDb.setUsername(upUser.getUsername());
//tackle last			inDb.setPassword(upUser.getPassword());
			return userRepo.saveAndFlush(inDb);
		}
		return null;
	}

	@Override
	public User findByUsername(String username) {
		return userRepo.findByUsername(username);
	}

}
