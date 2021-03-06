package com.skilldistillery.neighboringworlds.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.neighboringworlds.entities.Media;
import com.skilldistillery.neighboringworlds.entities.UserComment;
import com.skilldistillery.neighboringworlds.repositories.MediaRepository;
import com.skilldistillery.neighboringworlds.repositories.UserCommentRepository;

@Service
public class UserCommentServiceImpl implements UserCommentService {

	@Autowired
	private UserCommentRepository userCmtRepo;
	
	@Autowired
	private MediaRepository mediaRepo;

	@Override
	public List<UserComment> index(String username) {
		return userCmtRepo.findAllByUser_Username(username);
	}

	@Override
	public UserComment show(int ucid) {
		UserComment comment = userCmtRepo.findById(ucid);
		if (comment != null) {
			return comment;
		}
		return null;
	} 

	@Override
	public UserComment create(String username, UserComment uCmt) {
		// Do we want to set any defaults or just handle on front end form?
		System.out.println(uCmt);
		return userCmtRepo.saveAndFlush(uCmt);
	}

	@Override
	public UserComment modify(UserComment uCmt, int ucid, String username) {
		UserComment existing = userCmtRepo.findByIdAndUser_Username(ucid, username);
		if (uCmt.getTitle() != null) {
			existing.setTitle(uCmt.getTitle());
		}
		if (uCmt.getContent() != null) {
			existing.setTitle(uCmt.getTitle());
		}
		return existing;
	}

	@Override
	public Boolean delete(int ucid, String username) {
		UserComment evtToDelete = userCmtRepo.findByIdAndUser_Username(ucid, username);
		if (evtToDelete != null) {
			userCmtRepo.deleteById(ucid);
		}
		return !userCmtRepo.existsById(ucid);
	}
	
	@Override
	public Boolean adminDelete(int ucid) {
		UserComment cmtToDelete = userCmtRepo.findById(ucid);
		System.out.println(cmtToDelete == null);
		for (Media media : cmtToDelete.getMedia()) {
			mediaRepo.delete(media);
		}
		for (UserComment reply : cmtToDelete.getReplies()) {
			userCmtRepo.delete(reply);
		}
		if (cmtToDelete != null) {
			userCmtRepo.deleteById(ucid);
		}
		return !userCmtRepo.existsById(ucid);
	}

	@Override
	public List<UserComment> indexEventComments(int cid) {
	return userCmtRepo.findAllByCultureEvent_Id(cid);
	}

}
