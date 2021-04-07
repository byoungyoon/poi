package jbt.test.poi.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		session.setAttribute("userId", authentication.getName());
		//log.info("{}", authentication.getName());
		
		//log.info("{}", "success");
		
		response.sendRedirect(request.getContextPath()+"/all/index");
	}

}
