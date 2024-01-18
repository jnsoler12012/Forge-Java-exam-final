package com.example.demo.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.models.Program;
import com.example.demo.models.Rating;
import com.example.demo.models.User;
import com.example.demo.repositories.ProgramRepository;
import com.example.demo.repositories.RatingRepository;

@Service
public class ProgramService {
  @Autowired
  private ProgramRepository programRepository;

  @Autowired
  private RatingRepository ratingRepository;

  public int createRating(Rating rating, Long id) {
    Optional<Program> program = programRepository.findById(id);

    if (program.isPresent()) {

      List<Rating> listRatings = program.get().getRatings();

      Rating rating2 = new Rating();
      rating2.setId(rating.getId() + 1);
      rating2.setName(rating.getName());
      rating2.setScore(rating.getScore());
      rating2.setCreatedAt(rating.getCreatedAt());
      rating2.setUpdatedAt(rating.getUpdatedAt());


    
      listRatings.add(rating2);


      program.get().setRatings(listRatings);

      rating2.setProgram(programRepository.save(program.get()));

      ratingRepository.save(rating2);


    }
    return 0;
  }

  public int deleteById(Long id, User user) {
    Optional<Program> program = programRepository.findById(id);

    if (program.isPresent()) {
      if (program.get().getUser().getId() == user.getId()) {
        programRepository.deleteById(id);
        return 0;
      } else {
        return 1;
      }
    } else {
      return 1;
    }

  }

  public List<Program> getAll() {
    return programRepository.findAll();
  }

  public Program registerProgram(Program program, User user) {
    List<Program> listPrograms = programRepository.findAll();

    for (int x = 0; x < listPrograms.size(); x++) {
      System.out.println(program.getName());
      System.out.println(listPrograms.get(x).getName());
      System.out.println(program.getName().equals(listPrograms.get(x).getName()));
      if (program.getName().equals(listPrograms.get(x).getName())) {
        return null;
      }
    }

    System.out.println(user.getEmail());
    System.out.println(user.getPrograms());
    program.setUser(user);
    user.getPrograms().add(program);

    return programRepository.save(program);

  }

  public Program findProgramById(Long id) {
    return programRepository.findById(id).orElse(null);
  }

}
