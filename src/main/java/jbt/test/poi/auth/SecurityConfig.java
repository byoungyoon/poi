package jbt.test.poi.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;

import jbt.test.poi.handler.AccessDenidedHandler;
import jbt.test.poi.handler.LoginFailureHandler;
import jbt.test.poi.handler.LoginSuccessHandler;
import jbt.test.poi.service.UserService;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter  {
	
	@Autowired UserService userService;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
			.csrf().disable()
			.authorizeRequests()
				.mvcMatchers("/all/**", "/maps/*").permitAll()
				.mvcMatchers("/admin/**").hasRole("ADMIN")
				.mvcMatchers("/user/**").hasAnyRole("USER", "ADMIN")
				.anyRequest().authenticated();
			
		http
			.formLogin()
				.loginPage("/all/login")
				.loginProcessingUrl("/loginAction")
				.defaultSuccessUrl("/all/index")
				.usernameParameter("userId")
				.passwordParameter("userPw")
				.successHandler(new LoginSuccessHandler())
				.failureHandler(new LoginFailureHandler())
				.permitAll();
		http.httpBasic();
		http.exceptionHandling().accessDeniedHandler(new AccessDenidedHandler());
		http.logout()
			.logoutSuccessUrl("/all/index");
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userService);
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/images/**", "/js/**", "/css/**");
	}
	
	@Bean
	PasswordEncoder PasswordEncoder(){
	    return new BCryptPasswordEncoder();
	}
}
