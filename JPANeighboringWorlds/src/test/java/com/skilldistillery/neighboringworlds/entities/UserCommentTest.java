package com.skilldistillery.neighboringworlds.entities;

import static org.junit.jupiter.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class UserCommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private UserComment uC;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPANeighboringWorlds");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		uC = em.find(UserComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		uC = null;
	}

	@Test
	void test_userComment_entity_mapping() {
		assertNotNull(uC);
		assertEquals(1, uC.getId());
		assertEquals("Great event!", uC.getTitle());
	}
	
	@Test
	void test_userComment_MTO_to_User_mapping() {
		assertNotNull(uC);
		assertNotNull(uC.getUser());
		assertEquals(1, uC.getUser().getId());
	}
	
	@Test
	void test_userComment_MTO_to_CultureEvent() {
		assertNotNull(uC);
		assertNotNull(uC.getCultureEvent());
		assertEquals(1, uC.getCultureEvent().getId());
	}
	
	@Test
	void test_userComment_MTO_replyTo() {
		assertNotNull(uC);
		assertNotNull(uC.getReplies());
		assertTrue(uC.getReplies().size() > 0);
		assertEquals(2, uC.getReplies().get(0).getId());
		assertEquals(1, uC.getReplies().get(0).getInReplyTo().getId());
	}

}
