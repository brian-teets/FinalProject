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

class CultureEventTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private CultureEvent e;

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
		e = em.find(CultureEvent.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		e = null;
	}

	@Test
	@DisplayName("Basic mapping")
	void t1() {
		assertNotNull(e);
		assertEquals("Come bake my grandma's famous cake recipe!", e.getTitle());
		assertEquals(2022, e.getEventDate().getYear());
		assertEquals(6, e.getEventDate().getMonthValue());
		assertEquals(10, e.getCapacity());
		assertTrue(e.getActive());
	}

	@Test
	@DisplayName("CultureEvent - User mapping")
	void t2() {
		assertNotNull(e);
		assertTrue(e.getAttendees().size() > 0);
		assertEquals("charli@neighboringworlds.com", e.getAttendees().get(0).getEmail());
	}
}
