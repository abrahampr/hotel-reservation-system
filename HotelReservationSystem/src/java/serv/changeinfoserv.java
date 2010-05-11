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
                sql = "update user set gender='" + gender + "' where username='" + username + "'";
            } else if (realname.equals("") && email.equals("")) {
                sql = "update user set gender='" + gender + "',telephone='" + telephone + "' where username='" + username + "'";
            } else if (realname.equals("") && telephone.equals("")) {
                sql = "update user set gender='" + gender + "',email='" + email + "' where username='" + username + "'";
            } else if (email.equals("") && telephone.equals("")) {
                sql = "update user set gender='" + gender + "',realname='" + realname + "' where username='" + username + "'";
            } else if (realname.equals("")) {
                sql = "update user set gender='" + gender + "',email='" + email + "',telephone='" + telephone + "' where username='" + username + "'";
            } else if (email.equals("")) {
                sql = "update user set gender='" + gender + "',realname='" + realname + "',telephone='" + telephone + "' where username='" + username + "'";
            } else if (telephone.equals("")) {
                sql = "update user set gender='" + gender + "',email='" + email + "',realname='" + realname + "' where username='" + username + "'";
            } else {
                sql = "update user set realname ='" + realname + "',gender='" + gender
                        + "',email='" + email + "',telephone='" + telephone + "' where username='" + username + "'";
            }
            if (database.update(sql) == 1) {
                msg = "Success! Your profile has been changed.<br><a href=index.jsp>return</a>";
                httpservletrequest.setAttribute("msg", msg);
                httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
            }
        }
    }
}
