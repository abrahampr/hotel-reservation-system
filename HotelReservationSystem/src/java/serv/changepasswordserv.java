package serv;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class changepasswordserv extends HttpServlet{
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
//change password
        if (action.equals("changepassword")) {
			String username=(String)httpsession.getAttribute("username");
			String oldpassword = httpservletrequest.getParameter("oldpassword").trim();
			String newpassword = httpservletrequest.getParameter("newpassword").trim();
			String sqla = "select password from user where username='"+username+"'";
			String DBpwd =  database.getInfo(sqla);
			if(oldpassword.equals(DBpwd)){
				String sqlb = "update user set password='"+newpassword+"'where username='"+
								username+"'";
				database.update(sqlb);
				msg = "Success! please login your account with new password next time.<br>";
			}
			else{
				msg = "Wrong value!<br>"+
				       "<a href=useredit.jsp> please retry.";
			}
			httpservletrequest.setAttribute("msg",msg);
			httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
        }
    }
}
