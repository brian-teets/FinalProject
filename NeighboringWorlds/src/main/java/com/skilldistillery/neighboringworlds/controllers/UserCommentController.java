package com.skilldistillery.neighboringworlds.controllers;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

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
import com.skilldistillery.neighboringworlds.entities.User;
import com.skilldistillery.neighboringworlds.entities.UserComment;
import com.skilldistillery.neighboringworlds.repositories.CultureEventRepository;
import com.skilldistillery.neighboringworlds.repositories.UserCommentRepository;
import com.skilldistillery.neighboringworlds.repositories.UserRepository;
import com.skilldistillery.neighboringworlds.services.UserCommentService;

@RestController
@CrossOrigin({ "*", "http://localhost" })
@RequestMapping("api")
public class UserCommentController {

	@Autowired
	private UserCommentService uCmtServ;

	@Autowired
	private CultureEventRepository cEvtRepo;

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private UserCommentRepository uCmtRepo;

	@GetMapping("comments/all")
	public List<UserComment> index(Principal principal) {
		return uCmtServ.index(principal.getName());
	}

	@GetMapping("comments/{ucid}")
	public UserComment show(@PathVariable int ucid) {
		return uCmtServ.show(ucid);
	}

	@GetMapping("culture-events/{cid}/comments")
	public List<UserComment> indexEventComments(@PathVariable Integer cid, HttpServletResponse res,
			HttpServletRequest req) {
		return uCmtServ.indexEventComments(cid);
	}

	@PostMapping("culture-events/{cid}/comments")
	public UserComment create(@RequestBody UserComment uCmt, @PathVariable Integer cid, HttpServletResponse res,
			HttpServletRequest req, Principal principal) {
		System.out.println(uCmt);

		try {
			Optional<CultureEvent> evtOpt = cEvtRepo.findById(cid);
			if (evtOpt != null) {
				CultureEvent evtEvt = evtOpt.get();
				uCmt.setCultureEvent(evtEvt);
				uCmt.setUser(userRepo.findByUsername(principal.getName()));
			}
			uCmt = uCmtServ.create(principal.getName(), uCmt);
			res.setStatus(201);

//	TODO		Modify to redirect to user's new comment on event page?
//			StringBuffer url = req.getRequestURL();
//			url.append("/").append(cEvt.getId());
//			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
			uCmt = null;
		}

		return uCmt;
	}

	@PostMapping("comments/{ucid}/reply")
	public UserComment createReply(@RequestBody UserComment reply, @PathVariable Integer ucid, HttpServletResponse res,
			HttpServletRequest req, Principal principal) {

		try {
			Optional<UserComment> parentCmt = uCmtRepo.findById(ucid);
			if (parentCmt != null) {
				reply.setInReplyTo(parentCmt.get());
				reply.setCultureEvent(parentCmt.get().getCultureEvent());
				reply.setUser(userRepo.findByUsername(principal.getName()));
			}
			reply = uCmtServ.create(principal.getName(), reply);
			res.setStatus(201);

		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
			reply = null;
		}
		return reply;
	}

	@PutMapping("comments/{ucid}")
	public UserComment modify(@RequestBody UserComment uCmt, @PathVariable int ucid, HttpServletResponse res,
			HttpServletRequest req, Principal principal) {
		UserComment modCmt;
		try {
			modCmt = uCmtServ.modify(uCmt, ucid, principal.getName());
			if (modCmt != null) {
				res.setStatus(200);
			}
		} catch (Exception e) {
			res.setStatus(404);
			e.printStackTrace();
			modCmt = null;
		}

		return modCmt;
	}

	@DeleteMapping("comments/{ucid}")
	public Boolean delete(@PathVariable int ucid, HttpServletResponse res, Principal principal) {
		Boolean deleted = false;
		User user = userRepo.findByUsername(principal.getName());
		System.out.println(user.getRole());
		if (user.getRole().equals("ROLE_ADMIN")) {
			try {
				deleted = uCmtServ.adminDelete(ucid);
				if (deleted) {
					res.setStatus(204);
				} else {
					res.setStatus(403); // status for forbidden access
				}
			} catch (Exception e) {
				res.setStatus(500);
				e.printStackTrace();
			}
		} else {
			try {
				deleted = uCmtServ.delete(ucid, principal.getName());
				if (deleted) {
					res.setStatus(204);
				} else {
					res.setStatus(403); // status for forbidden access
				}
			} catch (Exception e) {
				res.setStatus(500);
				e.printStackTrace();
			}
		}
		return deleted;
	}

}
