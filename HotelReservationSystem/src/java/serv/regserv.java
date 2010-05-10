package serv;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class regserv extends HttpServlet {

    public void init(ServletConfig servletconfig) throws ServletException {
        super.init(servletconfig);
    }

    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse) throws ServletException, IOException {
        doPost(httpservletrequest, httpservletresponse);
    }

    public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse) throws ServletException, IOException {
//Get the parameter action.
        String action = httpservletrequest.getParameter("action");
//Initial the message string.
        String msg = "";
//register will be action when parameter action equals reg
        if (action.equals("reg")) {
//Get the parameter information.
            String username = httpservletrequest.getParameter("username").trim();
            String password = httpservletrequest.getParameter("password").trim();
            String realname = httpservletrequest.getParameter("realname").trim();
            String gender = httpservletrequest.getParameter("gender").trim();
            String email = httpservletrequest.getParameter("email").trim();
            String telephone = httpservletrequest.getParameter("telephone").trim();
//Sql syntax,find if there has the same user
            String sqla = "select * from user where username='" + username + "'";
            if (database.isExist(sqla)) {
//output information
                msg = username + ": has been existed try another one!!!<br/><a href=reg.jsp>return to the register page!</a>";
            } else {
//sql syntax, insert user value
                String sql = "insert into user values (NULL,'" + username + "','" + password + "','" + realname + "','" + gender + "','" + email + "','" + telephone + "')";
                database.update(sql);
                msg = "Congratulations,username:" + username + " is our membership now !!!<br/><a href=login.jsp>now login???</a>";
            }
//output the string msg to page.
            httpservletrequest.setAttribute("msg", msg);
            httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
        }
    }
}
