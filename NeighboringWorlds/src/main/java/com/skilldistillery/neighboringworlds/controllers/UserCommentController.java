package com.skilldistillery.neighboringworlds.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.neighboringworlds.entities.CultureEvent;
import com.skilldistillery.neighboringworlds.entities.UserComment;
import com.skilldistillery.neighboringworlds.services.UserCommentService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class UserCommentController {
	
	@Autowired
	private UserCommentService uCmtServ;
	
	
	
	@GetMapping("comments/all")
	public List<UserComment> index(Principal principal){
		return uCmtServ.index(principal.getName());
	}
	
	@GetMapping("comments/{ucid}")
	public UserComment show(@PathVariable int ucid) {
		return uCmtServ.show(ucid);
	}
	
//	@PostMapping("culture-events")
//	public CultureEvent create(@RequestBody CultureEvent cEvt, HttpServletResponse res, 
//			HttpServletRequest req, Principal principal) {
//		
//		try {
//			cEvt.setHost(  userService.findByUsername(principal.getName()) );
//			cEvt = cEvtServ.create(cEvt);
//			res.setStatus(201);
//			StringBuffer url = req.getRequestURL();
//			url.append("/").append(cEvt.getId());
//			res.setHeader("Location", url.toString()); 
//		} catch (Exception e) {
//			res.setStatus(400); 
//			e.printStackTrace();
//			cEvt = null;
//		}
//		
//		return cEvt;
//	}
//	
//	@PutMapping("culture-events/{cid}")
//	public CultureEvent modify(@RequestBody CultureEvent cEvt, @PathVariable int cid, HttpServletResponse res, 
//			HttpServletRequest req, Principal principal) {
//		CultureEvent modEvt;
//		try {
//			modEvt = cEvtServ.modify(cEvt, cid, principal.getName());
//			if(modEvt != null) {
//				res.setStatus(200);
//			}
//		} catch (Exception e) {
//			res.setStatus(404);
//			e.printStackTrace();
//			modEvt = null;
//		}
//		
//		
//		return modEvt; 
//	}
//	
//	@DeleteMapping("culture-events/{cid}")
//	public Boolean delete(@PathVariable int cid, HttpServletResponse res,
//			Principal principal) {
//		Boolean deleted = false;
//		try {
//			deleted = cEvtServ.delete(cid, principal.getName());
//			if(deleted) {
//				res.setStatus(204);
//			} else {
//				res.setStatus(403); // status for forbidden access
//			}
//		} catch (Exception e) {
//			res.setStatus(500);
//			e.printStackTrace();
//		}
//		return deleted; 
//	}

}
