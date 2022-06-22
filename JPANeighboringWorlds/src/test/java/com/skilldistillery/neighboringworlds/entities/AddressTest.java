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

class AddressTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Address a;

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
		a = em.find(Address.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		a = null;
	}

	@Test
	@DisplayName("Basic mapping")
	void t1() {
		assertNotNull(a);
		assertEquals("1111 Osage Street", a.getAddress1()); 
		assertEquals("", a.getAddress2()); 
		assertEquals("Denver", a.getCity()); 
		assertEquals("CO", a.getState()); 
		assertEquals("80204", a.getZipCode()); 
	}

//	@Test
//	@DisplayName("Address - ..... mapping")
//	void t2() {
//		assertNotNull(user);
//		assertEquals("Go round Mum's", user.getTodos().get(0).getTask());
//		assertTrue(user.getTodos().size() > 0);
//	}

}
