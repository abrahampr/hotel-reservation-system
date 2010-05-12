package serv;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class changeinfoserv extends HttpServlet {

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
//change th user information
        if (action.equals("changeinfo")) {
            String username = (String) httpsession.getAttribute("username");
            String realname = httpservletrequest.getParameter("realname").trim();
            String gender = httpservletrequest.getParameter("gender").trim();
            String email = httpservletrequest.getParameter("email");
            String telephone = httpservletrequest.getParameter("telephone").trim();
            String sql = null;
            if (realname.equals("") && email.equals("") && telephone.equals("")) {
                sql = "update USER set USER_Gender='" + gender + "' where USER_Name='" + username + "'";
            } else if (realname.equals("") && email.equals("")) {
                sql = "update USER set USER_Gender='" + gender + "',USER_Tele='" + telephone + "' where USER_Name='" + username + "'";
            } else if (realname.equals("") && telephone.equals("")) {
                sql = "update USER set USER_Gender='" + gender + "',USER_Email='" + email + "' where USER_Name='" + username + "'";
            } else if (email.equals("") && telephone.equals("")) {
                sql = "update USER set USER_Gender='" + gender + "',USER_RealName='" + realname + "' where USER_Name='" + username + "'";
            } else if (realname.equals("")) {
                sql = "update USER set USER_Gender='" + gender + "',USER_Email='" + email + "',USER_Tele='" + telephone + "' where USER_Name='" + username + "'";
            } else if (email.equals("")) {
                sql = "update USER set USER_Gender='" + gender + "',USER_RealName='" + realname + "',USER_Tele='" + telephone + "' where USER_Name='" + username + "'";
            } else if (telephone.equals("")) {
                sql = "update USER set USER_Gender='" + gender + "',USER_Email='" + email + "',USER_RealName='" + realname + "' where USER_Name='" + username + "'";
            } else {
                sql = "update USER set USER_RealName ='" + realname + "',USER_Gender='" + gender
                        + "',USER_Email='" + email + "',USER_Tele='" + telephone + "' where USER_Name='" + username + "'";
            }
            if (database.update(sql) == 1) {
                msg = "Success! Your profile has been changed.<br><a href=index.jsp>return</a>";
                httpservletrequest.setAttribute("msg", msg);
                httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
            }
        }
    }
}
