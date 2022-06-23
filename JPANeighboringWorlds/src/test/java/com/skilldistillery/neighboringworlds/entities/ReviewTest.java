package com.skilldistillery.neighboringworlds.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ReviewTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Review review;
	
	
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
		ReviewId revId = new ReviewId(1, 1);
		review = em.find(Review.class, revId);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		review = null;
	}

	@Test
	void test_review_entity_mapping() {
		assertNotNull(review);
		assertEquals(5, review.getRating());
		assertEquals("Excellent event!", review.getReviewContent());
	}
	
	@Test
	void test_review_user_mapping() {
		assertNotNull(review);
		assertNotNull(review.getUser());
		assertEquals("cverderame", review.getUser().getUsername());
	}
	
	@Test
	void test_review_event_mapping() {
		assertNotNull(review);
		assertNotNull(review.getCultureEvent());
		assertEquals("Come bake my grandma's famous cake recipe!", review.getCultureEvent().getTitle());
	}


}
