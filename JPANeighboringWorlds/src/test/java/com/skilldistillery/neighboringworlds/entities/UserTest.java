package com.skilldistillery.neighboringworlds.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class UserTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

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
			user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	@DisplayName("Basic mapping")
	void t1() {
		assertNotNull(user);
		assertEquals("cverderame", user.getUsername());
		assertEquals("Charli", user.getfName());
		assertEquals("Verderame", user.getlName());
		assertEquals("charli@neighboringworlds.com", user.getEmail()); 
		assertEquals("000-000-0000", user.getPhone()); 
		
	}
	
//	@Test
//	@DisplayName("User - ..... mapping")
//	void t2() {
//		assertNotNull(user);
//		assertEquals("Go round Mum's", user.getTodos().get(0).getTask());
//		assertTrue(user.getTodos().size() > 0);
//	}

}
