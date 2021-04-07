package jbt.test.poi.service;

import java.io.File;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jbt.test.poi.mapper.PoiMapper;
import jbt.test.poi.vo.PoiCategory;
import jbt.test.poi.vo.PoiData;
import jbt.test.poi.vo.PoiSubdata;
import jbt.test.poi.vo.Review;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class PoiService {
	@Value("${upload.path}")
	private String path;
	
	@Autowired PoiMapper poiMapper;
	private static String OS = System.getProperty("os.name").toLowerCase();
	
	public PoiSubdata getPoiSubDataOneByImg(int poiNo) {
		return poiMapper.selectPoiSubDataOneByImg(poiNo);
	}
	
	public List<PoiData> getPoiSubDataByCount(){
		return poiMapper.selectPoiSubDataByCount();
	}
	
	public void modifyPoiSubdata(int poiNo) {
		poiMapper.insertPoiSubdata(poiNo);
	}
	
	public List<PoiData> getPoiDataByAdmin(int poiNo){
		//log.info("{}", poiMapper.selectPoiDataByAdmin(poiNo));
		return poiMapper.selectPoiDataByAdmin(poiNo);
	}
	
	public List<PoiData> getPoiDataByCategoryNameCount(){
		return poiMapper.selectPoiDataByCategoryNameCount();
	}
	
	public void modifyPoiData(PoiData poiData) {
		
		PoiSubdata poiSubData = new PoiSubdata();
		poiSubData.setPoiNo(poiData.getPoiNo());
		poiSubData.setPoiContent(poiData.getPoiContent());
		
		String lastPoiImg = poiMapper.selectPoiSubDataByImg(poiData.getPoiNo());
		
		if(poiData.getPoiImg() != null && lastPoiImg != null) {
			int p = poiData.getPoiImg().getOriginalFilename().lastIndexOf(".");
			String ext = poiData.getPoiImg().getOriginalFilename().substring(p).toLowerCase();
			String fileName = UUID.randomUUID().toString().replace("-", "");
			File file = Paths.get(path, fileName + ext).toFile();
			log.info("{}", file);
			
			
			try {
				poiData.getPoiImg().transferTo(file);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException();
			}
			
			File lastFile = Paths.get(path, lastPoiImg).toFile();
			if(lastFile.exists()) {
				lastFile.delete();
			}
			
			poiSubData.setPoiImg(fileName + ext);
			
		} else {
			if(lastPoiImg == null) {
				poiSubData.setPoiImg("default.jpg");
			} else {				
				poiSubData.setPoiImg(lastPoiImg);
			}
		}
		
		//log.info("{}", "####################" + poiData);
		//log.info("{}", "####################" + poiSubData);
		
		poiMapper.updatePoiDataByAll(poiData);
		poiMapper.insertAndUpdatePoiSubData(poiSubData);
		
	}
	
	public void deletePoiDataAll(int poiNo) {
		poiMapper.deleteReviewByAll(poiNo);
		poiMapper.deletePoiSubdata(poiNo);
		poiMapper.deletePoiData(poiNo);
	}
	
	public void deleteReview(int reviewNo) {
		String fileName = poiMapper.selectReviewByImg(reviewNo);
		poiMapper.deleteReview(reviewNo);
		
		//log.info("{}", "#########################" + fileName);
		
		if(!fileName.equals("default.jpg")) {
			File lastFile = Paths.get(path, fileName).toFile();			

			if(lastFile.exists()) {
				lastFile.delete();
			}
		}
	}
	
	public void addPoiData(PoiData poiData) {
		if(poiData.getDclas() != null) {
			String[] dclascds = poiData.getDclas().split("-");
			if(dclascds.length == 1) {
				poiData.setDclas(dclascds[0]);
				poiData.setBclasdc("");
			} else {
				poiData.setDclas(dclascds[0]);
				poiData.setBclasdc(dclascds[1]);							
			}
		} else {
			poiData.setDclas("");
			poiData.setBclasdc("");
		}
		
		String poiCategoryCode = poiMapper.selectPoiDataByPoiCategoryCode(poiData);
		//log.info("{}", "######################" + poiCategoryCode);
		poiData.setPoiCategoryCode(poiCategoryCode);
		
		//log.info("{}", "######################" + poiData);
			
		poiMapper.insertPoiData(poiData);
		
		PoiSubdata poiSubData = new PoiSubdata();
		if(poiData.getPoiImg() != null) {
			int p = poiData.getPoiImg().getOriginalFilename().lastIndexOf(".");
			String ext = poiData.getPoiImg().getOriginalFilename().substring(p).toLowerCase();
			String fileName = UUID.randomUUID().toString().replace("-", "");
			
			File file = Paths.get(path, fileName + ext).toFile();

			try {
				poiData.getPoiImg().transferTo(file);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException();
			}	
			poiSubData.setPoiImg(fileName + ext);
		} else {
			poiSubData.setPoiImg("default.jpg");
		}
		
		poiSubData.setPoiNo(poiData.getPoiNo());
		poiSubData.setPoiContent(poiData.getPoiContent());
		
		poiMapper.insertFirstPoiSubdata(poiSubData);
	}
	
	public List<PoiCategory> getPoiCategoryByDclasdc(String sclasdc){
		return poiMapper.selectPoiCategoryByDclasdc(sclasdc);
	}
	
	public List<PoiCategory> getPoiCategoryBySclasdc(String mlsfcdc){
		return poiMapper.selectPoiCategoryBySclasdc(mlsfcdc);
	}
	
	public List<PoiCategory> getPoiCategoryByMlsfcdc(String lclasdc){
		return poiMapper.selectPoiCategoryByMlsfcdc(lclasdc);
	}
	
	public List<PoiCategory> getPoiCategoryByLclasdc(){
		//log.info("{}", "##################" + poiMapper.selectPoiCategoryByLclasdc());
		return poiMapper.selectPoiCategoryByLclasdc();
	}
	
	public List<PoiData> getPoiDateByCategory(String lclasdc, int poiNo){
		return poiMapper.selectPoiDateByCategory(lclasdc, poiNo);
	}
	
	public List<String> getPoiCategoryList(){
		return poiMapper.selectPoiCategoryList();
	}
	
	public List<PoiData> getPoiDataBySearch(String searchData){
		//log.info("{}", "#####################" + searchData);
		return poiMapper.selectPoiDataBySearch(searchData);
	}
	
	public PoiData getPoiDataByRoadView(int poiNo) {
		return poiMapper.selectPoiDataByRoadView(poiNo);
	}
	
	public List<Review> getReview(int poiNo) {
		return poiMapper.selectReview(poiNo);
	}
	
	public void addReview(Review review) {
		if(review.getReviewImg()!= null) {
			int p = review.getReviewImg().getOriginalFilename().lastIndexOf(".");
			String ext = review.getReviewImg().getOriginalFilename().substring(p).toLowerCase();
			String fileName = UUID.randomUUID().toString().replace("-", "");
			
			File file = Paths.get(path, fileName + ext).toFile();
			
			try {
				review.getReviewImg().transferTo(file);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException();
			}	
			review.setReviewFileName(fileName + ext);
		} else {
			review.setReviewFileName("default.jpg");
		}
		
		poiMapper.insertReview(review);
	}
	
	public PoiData getPoiData(int poiNo) {
		//log.info("{}", "#####################" + poiMapper.selectPoiData(poiNo));
		return poiMapper.selectPoiData(poiNo);
	}
	
	public List<PoiData> getPoi(){
		return poiMapper.selectPoi();
	}
}
