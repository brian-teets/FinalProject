package com.skilldistillery.neighboringworlds.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.skilldistillery.neighboringworlds.entities.Media;

@Service
public interface MediaService {
	
	List <Media> index(String username);
	List <Media> indexEventMedia(int cid);
	List <Media> show(int ucid);
	Media modify(Media med, int mid, String username);
	Boolean delete(int mid, String username);
	Media create(Media med, int ucid, String username);

}
