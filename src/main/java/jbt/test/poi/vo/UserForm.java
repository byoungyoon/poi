package jbt.test.poi.vo;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;

@Data
public class UserForm implements UserDetails{
	private String username;
	private String password;
	private boolean isAccountNonLocked;
	private boolean isCredentialsNonExpired;
	private boolean isEnabled;
	private boolean isAccountNonExpired;
	private Collection<? extends GrantedAuthority> authorities;
}
