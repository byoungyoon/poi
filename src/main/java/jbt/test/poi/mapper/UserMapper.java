package jbt.test.poi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jbt.test.poi.vo.User;

@Mapper
public interface UserMapper {
	int deleteUser(String userId);
	int deleteReviewByAdmin(String userId);
	int delteRouteByAdmin(String userId);
	int deleteRouteSubDataByAdmin(int routeNo);
	List<Integer> selectRouteByAdmin(String userId);
	List<User> selectUserByAdmin();
	int selectLoginCk(String userId);
	int insertUser(User user);
	User selectUserByLogin(String userId);
}
