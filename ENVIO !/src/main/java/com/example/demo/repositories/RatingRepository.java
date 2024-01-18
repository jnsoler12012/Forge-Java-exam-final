package com.example.demo.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.models.Program;
import com.example.demo.models.Rating;

@Repository
public interface RatingRepository extends CrudRepository<Rating, Long>{
    List<Rating> findAll();
    Rating findByProgram(Program program);
}
