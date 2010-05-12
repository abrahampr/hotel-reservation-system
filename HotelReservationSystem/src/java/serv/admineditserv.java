package serv;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class admineditserv extends HttpServlet{
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
//edit the admin password
            if(action.equals("adminedit")){
                        String adminusername = httpservletrequest.getParameter("adminusername");
			String adminoldpassword = httpservletrequest.getParameter("adminoldpassword");
			String adminnewpassword = httpservletrequest.getParameter("adminnewpassword");
			String sql = "select ADMIN_PW from ADMINISTRATOR where ADMIN_Uname='"+adminusername+"'";
			String databasepassword = database.getInfo(sql);
			if(databasepassword==null){
				msg = "invalid admin account<a href=adminmanage.jsp>return</a>";
			}
			else if(!databasepassword.equals(adminoldpassword)){
				msg = "your password as same as your current password!<a href=adminmanage.jsp>return</a>";
			}
			else{
				sql = "update ADMINISTRATOR set ADMIN_PW='"+adminnewpassword+"' where ADMIN_Uname='"+adminusername+"'";
				if(database.update(sql)>0){
					msg = "Edit Successed!<a href=adminmanage.jsp>return</a>";
				}
			}
                httpservletrequest.setAttribute("msg",msg);
                httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
		}
            }
}
