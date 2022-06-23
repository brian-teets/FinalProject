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

class MediaTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Media media;
	
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
		media = em.find(Media.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		media = null;
	}

	@Test
	void test_eventTag_entity_mapping() {
		assertNotNull(media);
		assertEquals(1, media.getId());
		assertEquals("https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimg1.cookinglight.timeinc.net%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F1542062283%2Fchocolate-and-cream-layer-cake-1812-cover.jpg%3Fitok%3DrEWL7AIN", media.getUrl());
	}
	@Test
	void test_comment_entity_mapping() {
		assertNotNull(media);
		assertNotNull(media.getUserComment());
		assertEquals("Great event!", media.getUserComment().getTitle());
	}

}
