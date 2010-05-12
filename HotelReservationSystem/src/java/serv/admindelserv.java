package serv;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class admindelserv extends HttpServlet{

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
//delete the admin
if(action.equals("deladmin")){
                    String adminusername = (String)httpsession.getAttribute("adminusername");

			String cadminusername = httpservletrequest.getParameter("adminusername");
			if(cadminusername.equals(adminusername)){
				msg = "ID is yourself";
			}
			else{
				String sql = "delete from ADMINISTRATOR where ADMIN_Uname='"+cadminusername+"'";
				database.update(sql);
				msg = "delete!<a href=adminmanage.jsp>return</a>";
			}
			httpservletrequest.setAttribute("msg",msg);
                        httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
		}
    }
}