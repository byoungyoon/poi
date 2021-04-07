package jbt.test.poi.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class PoiData {
	private String name;
	private String poiCategoryCode;
	private String lclas;
	private String mlsfc;
	private String sclas;
	private String dclas;
	private String telNo;
	private Double lon;
	private Double lat;
	private int poiNo;
	private String poiContent;
	private MultipartFile poiImg;
	private String bclasdc;
	private PoiSubdata poiSubdata;
	private PoiCategory poiCategory;
	private int categoryCount;
}
