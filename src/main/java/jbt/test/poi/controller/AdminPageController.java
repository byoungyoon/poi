package jbt.test.poi.controller;

import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jbt.test.poi.service.MemoService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdminPageController {
	@Autowired MemoService memoService;
	
	@GetMapping("/admin/adminPage")
	public String adminPage(Model model) {
		Calendar cal = Calendar.getInstance();
		int dayOfTheWeek = cal.get(Calendar.DAY_OF_WEEK);
		int currentYear = cal.get(Calendar.YEAR);
		int currentMonth = cal.get(Calendar.MONTH);
		//log.info("{}", "###################" + dayOfTheWeek);
		int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		model.addAttribute("dayOfTheWeek", dayOfTheWeek);
		model.addAttribute("lastDay", lastDay);
		model.addAttribute("currentYear", currentYear);
		model.addAttribute("currentMonth", currentMonth + 1);
		
		return "adminPage";
	}
}
