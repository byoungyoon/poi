package jbt.test.poi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import jbt.test.poi.service.PoiService;
import jbt.test.poi.service.UserService;
import jbt.test.poi.vo.User;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserController {
	@Autowired UserService userService;
	@Autowired PoiService poiService;
	
	@GetMapping("/all/tests")
	public String test() {
		return "test";
	}
	
	@GetMapping("/all/error")
	public String error() {
		return "403";
	}
	
	@PostMapping("/all/signup")
	public String signup(User user) {
		userService.addUser(user);
		//log.info("{}", "########################### signup check");
		return "redirect:/all/login";
	}
	
	@GetMapping("/all/login")
	public String login() {
		return "login";
	}
	
	@GetMapping("/all/signup")
	public String signup(){
		return "signup";
	}
	
	@GetMapping("/all/index")
	public String index(Model model) {
		List<String> poiCategoryList = poiService.getPoiCategoryList();
		model.addAttribute("poiCategoryList", poiCategoryList);
		return "index";
	}
}
