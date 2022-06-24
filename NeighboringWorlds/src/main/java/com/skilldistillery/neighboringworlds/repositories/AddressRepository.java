package com.skilldistillery.neighboringworlds.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.neighboringworlds.entities.Address;

public interface AddressRepository extends JpaRepository<Address, Integer> {

	
	
}
