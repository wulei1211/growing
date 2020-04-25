package com.hhit.util;

import org.directwebremoting.Container;
import org.directwebremoting.ServerContextFactory;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.event.ScriptSessionEvent;
import org.directwebremoting.event.ScriptSessionListener;
import org.directwebremoting.extend.ScriptSessionManager;
import org.directwebremoting.servlet.DwrServlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;


/**  
 * DwrScriptSession 管理器
 * 
 */

public class DwrScriptSessionManagerUtil extends DwrServlet {

	/**  
	 * define a field serialVersionUID which type is long
	 */
	private static final long serialVersionUID = 6060064045767028843L;
	
	
	public void init() throws ServletException {

		Container container = ServerContextFactory.get().getContainer();
		ScriptSessionManager manager = container.getBean(ScriptSessionManager.class);
		
		ScriptSessionListener listener = new ScriptSessionListener() {
			public void sessionCreated(ScriptSessionEvent ev) {
				HttpSession session = WebContextFactory.get().getSession();
		        String userId = (String) session.getAttribute("userId");
		        System.out.println("a ScriptSession is created!  "+userId);
		        ev.getSession().setAttribute("userId", userId);
		    }
			
	        public void sessionDestroyed(ScriptSessionEvent ev) {
	        	System.out.println("a ScriptSession is distroyed   "+ev.getSession().getAttribute("userId"));
			}
		};
		
		manager.addScriptSessionListener(listener);
	}
}
