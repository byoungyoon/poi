package jbt.test.poi.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jbt.test.poi.mapper.UserMapper;
import jbt.test.poi.vo.User;
import jbt.test.poi.vo.UserForm;

@Service
@Transactional
public class UserService implements UserDetailsService{
	@Autowired UserMapper userMapper;
	@Autowired PasswordEncoder passwordEncoder;
	
	public void removeUser(String userId) {
		List<Integer> list = userMapper.selectRouteByAdmin(userId);
		for(int i=0; i<list.size(); i++) {
			userMapper.deleteRouteSubDataByAdmin(list.get(i));
		}
		userMapper.delteRouteByAdmin(userId);
		userMapper.deleteReviewByAdmin(userId);
		userMapper.deleteUser(userId);
	}
	
	public List<User> getUserByAdmin(){
		return userMapper.selectUserByAdmin();
	}
	
	public int getLoginCk(String userId) {
		return userMapper.selectLoginCk(userId);
	}
	
	public void addUser(User user) {
		user.setUserPw(passwordEncoder.encode(user.getUserPw()));
		user.setUserRole("ROLE_USER");
		
		userMapper.insertUser(user);
	}
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userMapper.selectUserByLogin(username);
		
		
		if(user == null) {
			throw new UsernameNotFoundException(username);
		}
		UserForm userForm = new UserForm();
		userForm.setUsername(user.getUserId());
		userForm.setPassword(user.getUserPw());
		userForm.setAuthorities(getAuthorities(user.getUserId()));
		userForm.setAccountNonExpired(true);
		userForm.setAccountNonLocked(true);
		userForm.setCredentialsNonExpired(true);
		userForm.setEnabled(true);
		
		return userForm;
	}
	
    public Collection<GrantedAuthority> getAuthorities(String username) {
    	User user = userMapper.selectUserByLogin(username);
    	String auth = user.getUserRole();
        List<String> authList = new ArrayList<String>();
        authList.add(auth);

        List<GrantedAuthority> authorities = new ArrayList<>();
        for (String authority : authList) {
            authorities.add(new SimpleGrantedAuthority(authority));
        }
        return authorities;
    }
}
