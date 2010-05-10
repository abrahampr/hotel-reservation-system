package serv;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class logoutserv extends HttpServlet{
    public void init(ServletConfig servletconfig) throws ServletException {
        super.init(servletconfig);
    }

    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse) throws ServletException, IOException {
        doPost(httpservletrequest, httpservletresponse);
    }

    public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse) throws ServletException, IOException {
        String action = httpservletrequest.getParameter("action");
        HttpSession httpsession = httpservletrequest.getSession(true);
        PrintWriter printwriter = httpservletresponse.getWriter();
        String msg = "";

//lougout functions
        if(action.equals("logout")){
//remove all possible account Attribute.
			httpsession.removeAttribute("username");
                        httpsession.removeAttribute("adminroot");
                        httpsession.removeAttribute("adminusername");
			msg = "Thank you! you have been logout saftly<br><br><a href=index.jsp>return?</a>";
			httpservletrequest.setAttribute("msg",msg);
			httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest,httpservletresponse);
		}
    }
}
