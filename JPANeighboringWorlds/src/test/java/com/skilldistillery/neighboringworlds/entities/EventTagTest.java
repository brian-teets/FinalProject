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
import org.junit.jupiter.api.Test;

class EventTagTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private EventTag eventTag;
	
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
		eventTag = em.find(EventTag.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		eventTag = null;
	}

	@Test
	void test_eventTag_entity_mapping() {
		assertNotNull(eventTag);
		assertEquals(1, eventTag.getId());
		assertEquals("culture", eventTag.getKeyword());
	}

}
