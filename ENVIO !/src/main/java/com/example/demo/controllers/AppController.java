package com.example.demo.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.demo.models.LoginUser;
import com.example.demo.models.Program;
import com.example.demo.models.Rating;
import com.example.demo.models.User;
import com.example.demo.services.ProgramService;
import com.example.demo.services.UserService;
import com.example.demo.validators.UserValidator;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class AppController {
	@Autowired
	private UserService service;
	@Autowired
	private ProgramService programService;
	@Autowired
	private UserValidator validator;

	@RequestMapping("/register")
	public String registerForm(@ModelAttribute("user") User user, HttpSession session, Model model) {
		if (session.getAttribute("user") != null) {
			model.addAttribute("user", session.getAttribute("user"));

			return "dashboard";
		} else {
			return "register";
		}
	}

	@RequestMapping({ "/login", "/" })
	public String loginForm(@ModelAttribute("loginUser") LoginUser loginUser, HttpSession session, Model model) {
		if (session.getAttribute("user") != null) {
			model.addAttribute("user", session.getAttribute("user"));

			return "dashboard";
		} else {
			return "login";
		}
	}

	@RequestMapping("/home")
	public String dashboard(HttpSession session, Model model) {
		if (session.getAttribute("user") != null) {
			model.addAttribute("user", session.getAttribute("user"));

			model.addAttribute("programs", programService.getAll());
			return "dashboard";
		} else {
			return "redirect:/login";
		}

	}

	@RequestMapping(value = "/programs/{id}/delete")
	public String deleteById(@PathVariable("id") Long id, HttpSession session, Model model) {
		if (session.getAttribute("user") != null) {
			model.addAttribute("user", session.getAttribute("user"));

			if (programService.deleteById(id, (User) session.getAttribute("user")) == 0) {
				return "redirect:/home";
			} else {
				return "redirect:/home";
			}

		} else {
			return "redirect:/login";
		}
	}

	@RequestMapping(value = "/program/new")
	public String registerTabletGet(HttpSession session, Model model, Program program) {
		if (session.getAttribute("user") != null) {
			model.addAttribute("user", session.getAttribute("user"));
			return "newProgram";
		} else {
			return "redirect:/login";
		}

	}

	@RequestMapping(value = "/program/new", method = RequestMethod.POST)
	public String registerTablet(@Valid @ModelAttribute("program") Program program, BindingResult result,
			HttpSession session, Model model) {

		if (session.getAttribute("user") != null) {
			model.addAttribute("user", session.getAttribute("user"));

			if (result.hasErrors()) {
				return "newProgram";
			} else {
				Program programNew = programService.registerProgram(program, (User) session.getAttribute("user"));
				if (programNew == null) {
					model.addAttribute("errorName", "Name has been already taken, please use other");
					return "newProgram";
				} else {
					return "redirect:/home";
				}

			}
		} else {
			return "redirect:/login";
		}
	}

	@RequestMapping("/programs/{id}")
	public String showProduct(@PathVariable("id") Long id, HttpSession session, Model model, Rating rating) {
		if (session.getAttribute("user") != null) {
			model.addAttribute("user", session.getAttribute("user"));

			Program program = programService.findProgramById(id);
			model.addAttribute("program", program);

			return "showProgram";
		} else {
			return "redirect:/login";
		}
	}

	@RequestMapping(value = "/programs/{id}/newRating", method = RequestMethod.POST)
	public String newRatingProgram(@PathVariable("id") Long id, HttpSession session, Model model, @Valid @ModelAttribute("rating") Rating rating, Program program) {
		if (session.getAttribute("user") != null) {
			User user = (User) session.getAttribute("user");
			model.addAttribute("user", user);
			rating.setName(user.getFirstName());


			int result = programService.createRating(rating, id);
			if(result == 0){

				return "redirect:/programs/" + id;
			} else {

				model.addAttribute("invalidRating", "can not create another rate");
				return "showProgram";
			}
			
		} else {
			return "redirect:/login";
		}
	}

	@RequestMapping("/programs/{id}/edit")
	public String editProgram(@PathVariable("id") Long id, HttpSession session, Model model) {
		if (session.getAttribute("user") != null) {

			Program program = programService.findProgramById(id);
			User user = (User) session.getAttribute("user");
			model.addAttribute("user", user);

			model.addAttribute("program", program);

			System.out.println(program.getUser().getId());
			System.out.println(user.getId());

			if (program.getUser().getId() != user.getId()) {
				model.addAttribute("errorNoUser", "Error, you can not edit a program that do not belongs to you");
				return "showProgram";
			}
			return "editProgram";
		} else {
			return "redirect:/login";
		}
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session,
			Model model) {
		validator.validate(user, result);
		if (service.findByEmail(user.getEmail()) == null) {
			if (result.hasErrors()) {
				return "register";
			} else {
				User u = service.registerUser(user);
				session.setAttribute("user", u);
				return "redirect:/home";
			}
		} else {
			model.addAttribute("errorRegister", "Email has been already taken");
			return "register";
		}

	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginUser(
			@Valid @ModelAttribute("loginUser") LoginUser loginUser,
			BindingResult result,
			HttpSession session,
			Model model) {
		if (result.hasErrors()) {
			return "login";
		}

		if (service.authenticateUser(loginUser)) {
			User user = service.findByEmail(loginUser.getEmail());
			System.out.println(user.getId());
			session.setAttribute("user", user);
			return "redirect:/home";
		} else {

			model.addAttribute("error", "Invalid credentials");
			return "login";
		}
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}

}
