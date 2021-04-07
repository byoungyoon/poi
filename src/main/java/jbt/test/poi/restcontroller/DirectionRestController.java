package jbt.test.poi.restcontroller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import jbt.test.poi.service.RouteService;
import jbt.test.poi.vo.Route;
import jbt.test.poi.vo.StaticForm;
import lombok.extern.slf4j.Slf4j;

import org.json.simple.JSONObject;
import org.json.simple.parser.*;


@RestController
@Slf4j
public class DirectionRestController {
	@Autowired RouteService routeService;
	
	@PostMapping("/user/modifyRouteSubData")
	public String updateRouteSubData(Route route) {
		routeService.modifyRouteSubData(route);
		return "";
	}
	
	@GetMapping("/user/deleteRoute")
	public String deleteRoute(
			@RequestParam(value="routeNo", required = false) int routeNo) {
		routeService.deleteRoute(routeNo);
		return "";
	}
	
	@GetMapping("/user/getRouteOne")
	public Route getRouteOne(
			@RequestParam(value="routeNo", required = false) int routeNo){
		return routeService.getOneRoute(routeNo);
	}
	
	@PostMapping("/user/addDirectionByRoute")
	public String addRoute(Route route) {
		log.info("{}", "##############" + route);
		routeService.addRoute(route);
		return "";
	}
	
	@PostMapping("/user/getDirectionImage")
	public Map<String, Object> getDirectionImage(StaticForm staticForm) {
		//log.info("{}", "###################" + staticForm);
		
		Float maxX = (float)0;
		Float maxY = (float)0;
		Float minX = (float)99999;
		Float minY = (float)99999;
		List<Float> xArr =  new ArrayList<Float>();
		List<Float> yArr =  new ArrayList<Float>();
		String[] val = staticForm.getStart().split(",");
		xArr.add(Float.parseFloat(val[0])); 
		yArr.add(Float.parseFloat(val[1])); 
		staticForm.setStart(val[1] + "," + val[0]);
		//log.info("{}", "#############" + staticForm.getStart());
		val = staticForm.getGoal().split(",");
		xArr.add(Float.parseFloat(val[0])); 
		yArr.add(Float.parseFloat(val[1])); 
		staticForm.setGoal(val[1] + "," + val[0]);
		String path = "color:0xff0000ff|weight:5|" + staticForm.getStart();
		String markers = "&markers=size:mid|icon:https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png|" + staticForm.getStart();
		markers += "&markers=size:mid|icon:https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png|" + staticForm.getGoal();
		
		if(!staticForm.getWayPoint1().equals("")) {
			val = staticForm.getWayPoint1().split(",");
			xArr.add(Float.parseFloat(val[0])); 
			yArr.add(Float.parseFloat(val[1])); 
			staticForm.setWayPoint1(val[1] + "," + val[0]);
			markers += "&markers=size:mid|icon:https://i.imgur.com/mwEffij.png|" + staticForm.getWayPoint1();
		}
		if(!staticForm.getWayPoint2().equals("")) {
			val = staticForm.getWayPoint2().split(",");
			xArr.add(Float.parseFloat(val[0])); 
			yArr.add(Float.parseFloat(val[1])); 
			staticForm.setWayPoint2(val[1] + "," + val[0]);
			markers += "&markers=size:mid|icon:https://i.imgur.com/NGGt41R.png|" + staticForm.getWayPoint2();
		}
		if(!staticForm.getWayPoint3().equals("")) {
			val = staticForm.getWayPoint3().split(",");
			xArr.add(Float.parseFloat(val[0])); 
			yArr.add(Float.parseFloat(val[1])); 	
			staticForm.setWayPoint3(val[1] + "," + val[0]);
			markers += "&markers=size:mid|icon:https://i.imgur.com/hSZvhCB.png|" + staticForm.getWayPoint3();
		}
		
        for (int i = 0; i < xArr.size(); i++) {
            maxX = Math.max(xArr.get(i), maxX);
            minX = Math.min(xArr.get(i), minX);
        }
        for (int i = 0; i < yArr.size(); i++) {
        	maxY = Math.max(yArr.get(i), maxY);
        	minY = Math.min(yArr.get(i), minY);
        }
		
		Float centerX = (maxX + minX) / 2;
		Float centerY = (maxY + minY) / 2;
		String center = centerY + "," + centerX;
		
		for(int i=0; i<staticForm.getStaticPoints().size(); i++) {
			path += "|" + staticForm.getStaticPoints().get(i);
		}
		
		path += "|" + staticForm.getGoal();
		
		log.info("{}" + staticForm.getLevel());
		
		if(staticForm.getLevel() == 11) {
			staticForm.setLevel(8);
		} else if(staticForm.getLevel() == 10){
			staticForm.setLevel(9);
		} else if(staticForm.getLevel() == 9) {
			staticForm.setLevel(11);
		} else if(staticForm.getLevel() == 8) {
			staticForm.setLevel(11);
		} else if(staticForm.getLevel() == 7) {
			staticForm.setLevel(15);
		} else if(staticForm.getLevel() == 6) {
			staticForm.setLevel(16);
		} else if(staticForm.getLevel() == 12) {
			staticForm.setLevel(7);
		} 
		
		String size ="1200x800";
		String key = "AIzaSyDQ_Naly9J-hgz30WOvwkDEZaGyFIj0cy0";
		String imgSrc = "https://maps.googleapis.com/maps/api/staticmap?size=" + size + "&center=" + center + "&zoom=" + staticForm.getLevel() + "&path=" + path + markers +  "&key=" + key;
		
		log.info("{}", "###################" + imgSrc);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("imgSrc", imgSrc);
		
		return map;
	}
	
	@GetMapping("/all/test")
	public String test(
			@RequestParam(value="start", required = false) String start,
			@RequestParam(value="goal", required = false) String goal,
			@RequestParam(value="wayPoint1", required = false) String wayPoint1,
			@RequestParam(value="wayPoint2", required = false) String wayPoint2,
			@RequestParam(value="wayPoint3", required = false) String wayPoint3) throws Exception{
		String wayPoint = "";
		if(!wayPoint1.equals("")) {
			wayPoint = "&waypoints=" + wayPoint1;
		}
		if(!wayPoint2.equals("")) {
			wayPoint += "|" + wayPoint2;
		}
		if(!wayPoint3.equals("")) {
			wayPoint += "|" + wayPoint3;
		}
		
		String requestUrl = "https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving?start=" + start + "&goal=" + goal + wayPoint;
		
		URL obj = new URL(requestUrl);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		
		con.setRequestMethod("GET");
		
		con.setRequestProperty("Accept-Charset", "UTF-8");
		con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", "dxtkbz7pz2");
		con.setRequestProperty("X-NCP-APIGW-API-KEY", "mWf8LAYG6lznINYKbWKyLe98pzPPd753A4QrTSfm");
		
		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
		String inputLine;
		String resultXmlText = "";
		while((inputLine = in.readLine()) != null) {
			resultXmlText += inputLine;
		}
		
		in.close();
		con.disconnect();
		
		
		return resultXmlText;
	}
	
	public String parseJSONData(BufferedReader bufferedReader) {
		String resultSet = null;
		
		try {
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject)jsonParser.parse(bufferedReader);
			
			resultSet = jsonObject.toJSONString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultSet;
	}
}
