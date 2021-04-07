package jbt.test.poi.restcontroller;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import jbt.test.poi.service.MemoService;
import jbt.test.poi.service.PoiService;
import jbt.test.poi.service.UserService;
import jbt.test.poi.vo.CalendarForm;
import jbt.test.poi.vo.Memo;
import jbt.test.poi.vo.PoiData;
import jbt.test.poi.vo.User;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class AdminPageRestController {
	@Autowired MemoService memoService;
	@Autowired PoiService poiService;
	@Autowired UserService userService;
	
	@GetMapping("/admin/getPoiDataByAdmin")
	public List<PoiData> getPoiDataByAdmin(
			@RequestParam(value="poiNo", required = false)int poiNo){
		return poiService.getPoiDataByAdmin(poiNo);
	}
	
	@GetMapping("/admin/removeUser")
	public String removeUser(
			@RequestParam(value="userId", required = false) String userId) {
		userService.removeUser(userId);
		return "";
	}
	
	@GetMapping("/admin/getUserByAdmin")
	public List<User> getUserByAdmin()	{
		return userService.getUserByAdmin();
	}
	
	@GetMapping("/admin/getChart")
	public List<PoiData> getPoiDataByCategoryNameCount(){
		return poiService.getPoiDataByCategoryNameCount();
	}
	
	@GetMapping("/admin/getPoi")
	public List<PoiData> getPoi(){
		return poiService.getPoi();
	}
	
	@GetMapping("/admin/getMemoByLastUpdate")
	public List<Memo> getMemoByLastUpdate() {
		return memoService.getMemoByLastUpdate();
	}
	
	@PostMapping("/admin/addMemo")
	public String addMemo(Memo memo) {
		log.info("{}", "##################" + memo);
		memoService.addMemo(memo);
		return "";
	}
	
	@GetMapping("/admin/romoveMemo")
	public String romoveMemo(
			@RequestParam(value="memoNo", required = false) int memoNo) {
		memoService.removeMemo(memoNo);
		
		return "";
	}
	
	@GetMapping("/admin/getMemoOneByDay")
	public Map<String, Object> getMemoOneByDay(
			@RequestParam(value="year", required = false) String year,
			@RequestParam(value="month", required = false) int monthInt,
			@RequestParam(value="day", required = false) int dayInt){
		String month = "";
		String day = "";
		if(monthInt < 10) {
			month += "0" + monthInt;
		} else {
			month += monthInt;
		}
		if(dayInt < 10) {
			day += "0" + dayInt;
		} else {
			day += dayInt;
		}
		
		String memoDate = year + "-" + month + "-" + day;
		
		
		Memo memo = memoService.getMemoOneByDay(memoDate);
		
		log.info("{}", "##################" + memo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memo", memo);
		
		return map;
	}
	
	@PostMapping("/admin/modifyMonth")
	public Map<String, Object> modifyMonth(CalendarForm calendarForm){
		//log.info("{}", calendarForm);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(calendarForm.getJudgment().equals("next")) {
			calendarForm.setCurrentMonth(calendarForm.getCurrentMonth() + 1);
			if(calendarForm.getCurrentMonth() > 12) {
				calendarForm.setCurrentYear(calendarForm.getCurrentYear() + 1);
				calendarForm.setCurrentMonth(calendarForm.getCurrentMonth() - 12);
			}
		} else if(calendarForm.getJudgment().equals("pre")) {
			calendarForm.setCurrentMonth(calendarForm.getCurrentMonth() - 1);		
			if(calendarForm.getCurrentMonth() < 1) {
				calendarForm.setCurrentYear(calendarForm.getCurrentYear() - 1);
				calendarForm.setCurrentMonth(calendarForm.getCurrentMonth() + 12);
			}
		} else {
			calendarForm.setCurrentMonth(calendarForm.getCurrentMonth());		
		}
		
		Calendar cal = Calendar.getInstance();
		cal.set(calendarForm.getCurrentYear(), calendarForm.getCurrentMonth()-1, 1);
		
		int dayOfTheWeek = cal.get(Calendar.DAY_OF_WEEK);
		int lastDay = cal.getActualMaximum((Calendar.DAY_OF_MONTH));
		
		map.put("dayOfTheWeek", dayOfTheWeek);
		map.put("lastDay", lastDay);
		map.put("currentYear", calendarForm.getCurrentYear());
		map.put("currentMonth", calendarForm.getCurrentMonth());
		
		String month = "";
		if(calendarForm.getCurrentMonth() < 10) {
			month = "0" + calendarForm.getCurrentMonth();
		} else {
			month += calendarForm.getCurrentMonth();
		}
		String memoDate = calendarForm.getCurrentYear() + "-" + month;
		List<Integer> dayList = memoService.getByYearAndMonth(memoDate);
		
		map.put("dayList", dayList);
		
		return map;
	}
}
