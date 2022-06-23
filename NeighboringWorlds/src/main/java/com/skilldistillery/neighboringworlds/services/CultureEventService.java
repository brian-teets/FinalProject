package com.skilldistillery.neighboringworlds.services;

import java.util.List;

import com.skilldistillery.neighboringworlds.entities.CultureEvent;

public interface CultureEventService {
	
	List <CultureEvent> index();
	CultureEvent show(int cid);
	CultureEvent create(CultureEvent cEvt);
	CultureEvent modify(CultureEvent cEvt, int cid, String username);
	Boolean delete(int cid, String username);

}
