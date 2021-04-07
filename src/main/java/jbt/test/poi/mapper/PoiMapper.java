package jbt.test.poi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jbt.test.poi.vo.PoiCategory;
import jbt.test.poi.vo.PoiData;
import jbt.test.poi.vo.PoiSubdata;
import jbt.test.poi.vo.Review;

@Mapper
public interface PoiMapper {
	PoiSubdata selectPoiSubDataOneByImg(int poiNo);
	List<PoiData> selectPoiSubDataByCount();
	List<PoiData> selectPoiDataByAdmin(int poiNo);
	String selectReviewByImg(int reviewNo);
	List<PoiData> selectPoiDataByCategoryNameCount();
	String selectPoiSubDataByImg(int poiNo);
	int insertAndUpdatePoiSubData(PoiSubdata poiSubdata);
	int updatePoiDataByAll(PoiData poiData);
	int deleteReviewByAll(int poiNo);
	int deletePoiSubdata(int poiNo);
	int deletePoiData(int poiNo);
	int deleteReview(int reviewNo);
	String selectPoiDataByPoiCategoryCode(PoiData poiData);
	int insertFirstPoiSubdata(PoiSubdata poiSubData);
	int insertPoiData(PoiData poiData);
	List<PoiCategory> selectPoiCategoryByDclasdc(String sclasdc);
	List<PoiCategory> selectPoiCategoryBySclasdc(String mlsfcdc);
	List<PoiCategory> selectPoiCategoryByMlsfcdc(String lclasdc);
	List<PoiCategory> selectPoiCategoryByLclasdc();
	List<PoiData> selectPoiDateByCategory(String lclasdc, int poiNo);
	List<String> selectPoiCategoryList();
	List<PoiData> selectPoiDataBySearch(String searchData);
	PoiData selectPoiDataByRoadView(int poiNo);
	List<Review> selectReview(int poiNo);
	int insertReview(Review review);
	PoiData selectPoiData(int poiNo);
	int updataPoiData(PoiData poiData);
	int insertPoiSubdata(int poiNo);
	List<PoiData> selectPoi();
}
