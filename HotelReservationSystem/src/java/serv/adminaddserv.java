package serv;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class adminaddserv extends HttpServlet{
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
//add an admin
            if(action.equals("adminadd")){
			String adminusername = httpservletrequest.getParameter("adminusername");
			String adminpassword = httpservletrequest.getParameter("adminpassword");
			String sql = "insert into ADMINISTRATOR values(NULL,'"+adminusername+"','"+adminpassword+"','advanced')";
			String sqla = "select * from ADMINISTRATOR where ADMIN_Uname='"+adminusername+"'";
			if(database.isExist(sqla)){
				msg = "Error! the admin username has been existed!<a href=adminlogin.jsp>return to register again!</a>";
			}
			else{
				if(database.update(sql)>0)
				msg = "Admin register success!<a href=adminadd.jsp>return to login</a>";
			}
                        httpservletrequest.setAttribute("msg",msg);
                        httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
		}
        }
}
