package jbt.test.poi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jbt.test.poi.mapper.RouteMapper;
import jbt.test.poi.vo.Route;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class RouteService {
	@Autowired RouteMapper routeMapper;
	
	public void modifyRouteSubData(Route route) {
		routeMapper.updateRouteSubData(route);
	}
	
	public void deleteRoute(int routeNo) {
		routeMapper.deleteRouteSubData(routeNo);
		routeMapper.deleteRoute(routeNo);
	}
	
	public Route getOneRoute(int routeNo) {
		Route route = routeMapper.selectOneRoute(routeNo);
		route.setPoiStartName(routeMapper.selectPoiNameByRouteNo(route.getPoiStartNo()));
		route.setPoiGoalName(routeMapper.selectPoiNameByRouteNo(route.getPoiGoalNo()));
		if(route.getPoiWayPoint1No() != null) {
			route.setPoiWayPoint1Name(routeMapper.selectPoiNameByRouteNo(route.getPoiWayPoint1No()));
		}
		if(route.getPoiWayPoint2No() != null) {
			route.setPoiWayPoint2Name(routeMapper.selectPoiNameByRouteNo(route.getPoiWayPoint2No()));
		}
		if(route.getPoiWayPoint3No() != null) {
			route.setPoiWayPoint3Name(routeMapper.selectPoiNameByRouteNo(route.getPoiWayPoint3No()));
		}
		return route;
	}
	
	public List<Route> getRoute(String userId){
		return routeMapper.selectRoute(userId);
	}
	
	public void addRoute(Route route) {
		if(route.getPoiWayPoint1No() == 0) {
			route.setPoiWayPoint1No(null);
		}
		if(route.getPoiWayPoint2No() == 0) {
			route.setPoiWayPoint2No(null);
		}
		if(route.getPoiWayPoint3No() == 0) {
			route.setPoiWayPoint3No(null);
		}
		
		log.info("{}", "#############" + route);
		
		routeMapper.insertRoute(route);
		routeMapper.insertRouteSubdata(route);
	}
}
