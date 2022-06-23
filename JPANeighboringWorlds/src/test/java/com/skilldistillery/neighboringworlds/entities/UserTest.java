package com.skilldistillery.neighboringworlds.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

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

	@Test
	@DisplayName("User - CultureEvent mapping")
	void t2() {
		assertNotNull(user);
		assertTrue(user.getEvents().size() > 0);
		assertEquals(10, user.getEvents().get(0).getCapacity());
	}
	
	@Test
	@DisplayName("User to Review mapping")
	void t3() {
		assertNotNull(user);
		assertNotNull(user.getReviews());
		assertTrue(user.getReviews().size() > 0);
	}

}
