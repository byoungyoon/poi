package jbt.test.poi.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Review {
	private int reviewNo;
	private String userId;
	private int poiNo;
	private String reviewContent;
	private MultipartFile reviewImg;
	private String reviewFileName;
	private String lastUpdate;
	private String createDate;
}
