package jbt.test.poi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jbt.test.poi.vo.Route;

@Mapper
public interface RouteMapper {
	int updateRouteSubData(Route route);
	int deleteRouteSubData(int routeNo);
	int deleteRoute(int routeNo);
	String selectPoiNameByRouteNo(int poiNo);
	List<Route> selectRoute(String userId);
	int insertRouteSubdata(Route route);
	int insertRoute(Route route);
	Route selectOneRoute(int routeNo);
}
