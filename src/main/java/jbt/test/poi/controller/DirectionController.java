package jbt.test.poi.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jbt.test.poi.service.RouteService;
import jbt.test.poi.vo.Route;

@Controller
public class DirectionController {
	@Autowired RouteService routeService;
	
	@GetMapping("/all/direction")
	public String direction(Model model, HttpSession session) {
		Object obj = session.getAttribute("userId");
		String userId = (String)obj;
		
		if(userId != null) {
			List<Route> routeList = routeService.getRoute(userId);
			model.addAttribute("routeList", routeList);
		}
		return "direction";
	}
}
