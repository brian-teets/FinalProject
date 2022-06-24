package com.skilldistillery.neighboringworlds.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.neighboringworlds.entities.Media;
import com.skilldistillery.neighboringworlds.repositories.MediaRepository;

@Service
public class MediaServiceImpl implements MediaService {

	@Autowired
	private MediaRepository medRepo;

	@Override
	public List<Media> index(String username) {
		return medRepo.findAllByUserComment_User_Username(username);
	}

	@Override
	public List<Media> indexEventMedia(int cid) {
		return medRepo.findAllByUserComment_CultureEvent_Id(cid);
	}

	@Override
	public Media show(int ucid) {
		// TODO Auto-generated method stub
		return null;
	}

	/*
	 * NOTE: user_comment is child object so it must be persisted first, then return
	 * new persisted Id to media create for persist This will likely be handled on
	 * Angular side, one call to UC service followed by one call to Media service
	 */
	@Override
	public Media create(Media med) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Media modify(Media med, int mid, String username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Boolean delete(int mid, String username) {
		// TODO Auto-generated method stub
		return null;
	}

}
