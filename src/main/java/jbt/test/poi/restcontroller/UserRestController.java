package jbt.test.poi.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import jbt.test.poi.service.UserService;

@RestController
public class UserRestController {
	@Autowired UserService userService;
	
	@GetMapping("/all/loginCk")
	public Integer loginCk(
			@RequestParam(value="userId", required = false) String userId) {
		return userService.getLoginCk(userId);
	}
}
