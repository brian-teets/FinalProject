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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Media show(int ucid) {
		// TODO Auto-generated method stub
		return null;
	}

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
