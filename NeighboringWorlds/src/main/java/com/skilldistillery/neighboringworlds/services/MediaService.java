package com.skilldistillery.neighboringworlds.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.skilldistillery.neighboringworlds.entities.Media;

@Service
public interface MediaService {
	
	List <Media> index(String username);
	List <Media> indexEventMedia(int cid);
	Media show(int ucid);
	Media create(Media med);
	Media modify(Media med, int mid, String username);
	Boolean delete(int mid, String username);

}
