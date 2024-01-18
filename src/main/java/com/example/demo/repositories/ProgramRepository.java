package com.example.demo.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.models.Program;
@Repository
public interface ProgramRepository extends CrudRepository<Program, Long> {
    List<Program> findAll();
    Optional<Program> findByName(String name);
}
