package jbt.test.poi.vo;

import java.util.List;

import lombok.Data;

@Data
public class StaticForm {
	private String start;
	private String goal;
	private String wayPoint1;
	private String wayPoint2;
	private int level;
	private String wayPoint3;
	private List<String> staticPoints;
}
