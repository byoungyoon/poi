package jbt.test.poi.restcontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import jbt.test.poi.service.PoiService;
import jbt.test.poi.vo.PoiCategory;
import jbt.test.poi.vo.PoiData;
import jbt.test.poi.vo.PoiSubdata;
import jbt.test.poi.vo.Review;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class IndexRestController {
	@Autowired PoiService poiService;
	
	@GetMapping("/all/getPoiSubDataOneByImg")
	public Map<String, Object> getPoiSubDataOneByImg(
			@RequestParam(value="poiNo", required = false) int poiNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("poiSubData", poiService.getPoiSubDataOneByImg(poiNo));
		return map;
	}
	
	@GetMapping("/all/getPoiSubDataByCount")
	public List<PoiData> getPoiSubDataByCount(){
		return poiService.getPoiSubDataByCount();
	}
	
	@GetMapping("/all/modifyPoiSubdata")
	public String modifyPoiSubdata(
			@RequestParam(value="poiNo", required = false) int poiNo) {
		poiService.modifyPoiSubdata(poiNo);
		return "";
	}
	
	@PostMapping("/admin/updatePoiDataAll")
	public String modifyAction(PoiData poiData) {
		poiService.modifyPoiData(poiData);
		return "";
	}
	
	@GetMapping("/admin/deletePoiDataAll")
	public String deletePoiDataAll(
			@RequestParam(value="poiNo", required = false) int poiNo) {
		poiService.deletePoiDataAll(poiNo);
		return "";
	}
	
	@GetMapping("/user/deleteReview")
	public String deleteReview(
			@RequestParam(value="reviewNo", required = false) int reviewNo) {
		poiService.deleteReview(reviewNo);
		return "";
	}
	
	@PostMapping("/admin/addPoi")
	public String addPoiData(PoiData poiData) {
		log.info("{}", "##################" + poiData);
		poiService.addPoiData(poiData);
		return "";
	}
	
	@GetMapping("/admin/addDclasdc")
	public List<PoiCategory> getPoiCategoryByDclasdc(
			@RequestParam(value="sclasdc", required = false) String sclasdc){
		return poiService.getPoiCategoryByDclasdc(sclasdc);
	}
	
	@GetMapping("/admin/addSclasdc")
	public List<PoiCategory> getPoiCategoryBySclasdc(
			@RequestParam(value="mlsfcdc", required = false) String mlsfcdc){
		return poiService.getPoiCategoryBySclasdc(mlsfcdc);
	}
	
	@GetMapping("/admin/addMlsfcdc")
	public List<PoiCategory> getPoiCategoryByMlsfcdc(
			@RequestParam(value="lclasdc", required = false) String lclasdc){
		return poiService.getPoiCategoryByMlsfcdc(lclasdc);
	}
	
	@GetMapping("/admin/addLclasdc")
	public List<PoiCategory> getpoiCategoryByLclasdc(){
		return poiService.getPoiCategoryByLclasdc();
	}
	
	@GetMapping("/all/categoryData")
	public List<PoiData> getPoiDateByCategory(
			@RequestParam(value="lclasdc", required = false) String lclasdc,
			@RequestParam(value="poiNo", required = false) int poiNo){
		return poiService.getPoiDateByCategory(lclasdc, poiNo);
	}
	
	@GetMapping("/all/searchData")
	public List<PoiData> getPoiDataBySearch(
			@RequestParam(value="searchData", required = false) String searchData){
		return poiService.getPoiDataBySearch(searchData);
	}
	
	@GetMapping("/all/getRoadView")
	public Map<String, Object> getPoiDataByRoadView(
			@RequestParam(value="poiNo", required = false) int poiNo){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("lonAndLat", poiService.getPoiDataByRoadView(poiNo));
		return map;
	}
	
	@GetMapping("/all/reviewList")
	public List<Review> getReview(
			@RequestParam(value="poiNo", required = false) int poiNo){
		return poiService.getReview(poiNo);
	}
	
	@PostMapping("/user/addReview")
	public String addReview(Review review) {
		log.info("{}", review);
		
		poiService.addReview(review);
		return "success";
	}
	
	@GetMapping("/admin/")
	public String admin() {
		return "";
	}
	
	@GetMapping("/all/poiOneData")
	public Map<String, Object> poiOneData(
			@RequestParam(value="poiNo", required = false) int poiNo) {
		//log.info("{}", "##############################" + poiNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("poiOneData", poiService.getPoiData(poiNo));
		return map;
	}
	
	@GetMapping("/all/poiData")
	public List<PoiData> getPoi(){
		return poiService.getPoi();
	}
}
