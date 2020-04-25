package com.hhit.interceptor;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


/**
 * 拦截器
 */
@Component("systemInterceptor")
@Aspect
public class SystemInterceptor{

	private static Logger log = LogManager.getLogger();

	@Pointcut(value="execution(* com.hhit.action.*.*(..))")
	public void pointcut(){}

	@Around("pointcut()")
	public Object checkLogin(ProceedingJoinPoint joinPoint){
		String name = joinPoint.getSignature().getName();
		System.out.println("===============>进入了:"+name+"方法");
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		HttpServletResponse response = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getResponse();
		Object result = null;
		String uri = request.getRequestURI();
//		log.debug("Pre-handle url="+uri);
		System.out.println();
		if (uri.startsWith(request.getContextPath()+"/login/tologin") ||
				uri.startsWith(request.getContextPath()+"/login/loginPage") ||
				uri.startsWith(request.getContextPath()+"/AppAction")){
			try {
				result = joinPoint.proceed();
			} catch (Throwable throwable) {
				throwable.printStackTrace();
			}
//			log.debug(uri + " 不进行拦截");

		}else{

			//session失效，到登录页面
			HttpSession session = request.getSession();
			String username = (String) session.getAttribute("USER_NAME_STRING");


			if(username == null || username.equals("")){

				Class[] parameterTypes = ((MethodSignature)joinPoint.getSignature()).getMethod().getParameterTypes();
				try {
					if(joinPoint.getTarget().getClass().getMethod(name,parameterTypes).isAnnotationPresent(ResponseBody.class)){
						try {
							String url = request.getContextPath();
							response.sendRedirect(url);
						} catch (IOException e) {
							e.printStackTrace();
						}
					}else{
						try {
							String url = request.getContextPath();
							response.sendRedirect(url);
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				} catch (NoSuchMethodException e) {
					e.printStackTrace();
				}
			}else{

				try {
					result = joinPoint.proceed();
				} catch (Throwable throwable) {
					throwable.printStackTrace();
				}
			}
		}
		return result;
	}
}

