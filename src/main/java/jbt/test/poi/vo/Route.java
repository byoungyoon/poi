package jbt.test.poi.vo;

import lombok.Data;

@Data
public class Route {
	private int routeNo;
	private String userId;
	private int poiStartNo;
	private int poiGoalNo;
	private String poiStartName;
	private String poiGoalName;
	private Integer poiWayPoint1No;
	private Integer poiWayPoint2No;
	private Integer poiWayPoint3No;
	private String poiWayPoint1Name;
	private String poiWayPoint2Name;
	private String poiWayPoint3Name;
	private String lastUpdate;
	private String createDate;
	private int routeTime;
	private Double routeLength;
	private String routeContent;
	private String routeImg;
	private String routeTitle;
}
