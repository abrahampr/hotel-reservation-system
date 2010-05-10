package serv;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class orderserv extends HttpServlet {

    public void init(ServletConfig conf) throws ServletException {
        super.init(conf);
    }

    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
            throws ServletException, IOException {
        doPost(httpservletrequest, httpservletresponse);
    }

    public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
            throws ServletException, IOException {
//get the parameter action
        String action = httpservletrequest.getParameter("action");
        HttpSession session = httpservletrequest.getSession(true);
        String msg = "";
//get the session of username
        String username = (String) session.getAttribute("username");
//initial the value of reservation
        String accept = "waiting for accept";
        String successfully = "success";
        String failed = "failed";
//get the value of orderlist
        Vector<String[]> OrderList = (Vector<String[]>) session.getAttribute("OrderList");
        if (OrderList == null) {
            OrderList = new Vector<String[]>();
        }
//action equals order,will make a list from database and output
        if (action.equals("order")) {
            if (username == null) {
                msg = "you are not login yet。<br><br>"
                        + "<a href=login.jsp>login now?>>";
                httpservletrequest.setAttribute("msg", msg);
                httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
            } else {
//Sql syntax, find the users order.
                String sql = "select * from orders where orderuser='" + username + "'";
                Vector<String[]> list = orderdatabase.getOrderList(sql);
//print result to attribute list
                httpservletrequest.setAttribute("list", list);
                httpservletrequest.getRequestDispatcher("userorderstatus.jsp").forward(httpservletrequest, httpservletresponse);
            }
        }
//add an order
        if (action.equals("add")) {
            String orderNum = (String) httpservletrequest.getParameter("orderNum");
            if (orderNum != null) {
//get parameter information
                String startyear = (String) httpservletrequest.getParameter("startyear");
                String startmonth = (String) httpservletrequest.getParameter("startmonth");
                String startday = (String) httpservletrequest.getParameter("startday");
                String starthour = (String) httpservletrequest.getParameter("starthour");

                String finishyear = (String) httpservletrequest.getParameter("finishyear");
                String finishmonth = (String) httpservletrequest.getParameter("finishmonth");
                String finishday = (String) httpservletrequest.getParameter("finishday");
                String finishhour = (String) httpservletrequest.getParameter("finishhour");

                String group = (String) httpservletrequest.getParameter("group");
//make the start time and end time.
                String starttime = startyear + "-" + startmonth + "-" + startday + "-" + starthour + ":" + "00";
                String endtime = finishyear + "-" + finishmonth + "-" + finishday + "-" + finishhour + ":" + "00";
//make the value into the OrderList attribute.
                String[] s = new String[4];
                s[0] = orderNum;
                s[1] = group;
                s[2] = starttime;
                s[3] = endtime;
                OrderList.add(s);
                session.setAttribute("OrderList", OrderList);
                msg = "Reservation successful!<br><br><a href=roomgrouplist.jsp>continue?</a> or <a href=index.jsp>return</a>";
            }
            httpservletrequest.setAttribute("msg", msg);
            httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
        }
//delete an order
        if (action.equals("delete")) {
            String id = httpservletrequest.getParameter("index");
//get order id and remove it from OrderList.
            int index = Integer.parseInt(id);
            OrderList.remove(index);
            httpservletresponse.sendRedirect("userorder.jsp");
        }
//remove all of the order.
        if (action.equals("empty")) {
            OrderList.removeAllElements();
            session.setAttribute("OrderList", OrderList);
            httpservletresponse.sendRedirect("userorder.jsp");
        }
//submit the order
        if (action.equals("submit")) {
            if (username != null) {
//recall addorderfunction to add value into database.
                if (orderdatabase.addOrder(username, OrderList) != -1) {
//empty the OrderList session.
                    OrderList.removeAllElements();
                    msg = "Success!<br><br>"
                            + "<a href=index.jsp>return";
                } else {
                    msg = "Sorry,crashed!<br><br>"
                            + "<a href=index.jsp>return";
                }
            } else {
                msg = "you are not login yet。<br><br>"
                        + "<a href=login.jsp>login>>";
            }
            httpservletrequest.setAttribute("msg", msg);
            httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
        }
//get all order information
        if (action.equals("allOrders")) {
//check if the user is admin.
            if (session.getAttribute("adminusername") != null) {
                String sql = "";
//getcondition from jsp page.
                int conditon = Integer.parseInt(httpservletrequest.getParameter("condition"));
                switch (conditon) {
                    case 1:
//show all orders
                        sql = "select * from orders";
                        break;
                    case 2:
//show success/failed order
                        sql = "select * from orders where status='" + successfully + "' or status='" + failed + "'";
                        break;
                    case 3:
//show the orders that has not accpet.
                        sql = "select * from orders where status='" + accept + "'";
                        break;
                }
                Vector<String[]> order = orderdatabase.getOrderList(sql);
                httpservletrequest.setAttribute("order", order);
                httpservletrequest.getRequestDispatcher("adminorder.jsp").forward(httpservletrequest, httpservletresponse);
            } else {
                msg = "login first";
                httpservletrequest.setAttribute("msg", msg);
                httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
            }
        }
//get the list of order detail information
        if (action.equals("ListDetail")) {
            String orderid = httpservletrequest.getParameter("orderid");
            Vector<String[]> ListDetail = orderdatabase.getOrderDetail(orderid);
            httpservletrequest.setAttribute("ListDetail", ListDetail);
            httpservletrequest.setAttribute("orderid", orderid);
            httpservletrequest.getRequestDispatcher("adminorderdetail.jsp").forward(httpservletrequest, httpservletresponse);
        }
//deal the order
        if (action.equals("dealOrder")) {
            String adminusername = (String) session.getAttribute("adminusername");
            String orderPS = httpservletrequest.getParameter("reason");
            String status = httpservletrequest.getParameter("status");
            int orderid = Integer.parseInt(httpservletrequest.getParameter("orderid"));
            String sqla = "update orders set status='" + status + "',orderPS='"
                    + orderPS + "',applyadmin='" + adminusername + "'where orderid=" + orderid;
            String sqlb = "update orderdetail set status='" + status + "' where orderid=" + orderid;
            boolean b = database.update(sqla, sqlb);
            if (b == true) {
                msg = "deal!<br><br>"
                        + "<a href=orderserv?action=allOrders&&condition=1>return";
            } else {
                msg = "error";
            }
            httpservletrequest.setAttribute("msg", msg);
            httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
        }
//search order
        if (action.equals("searchOrder")) {
            Vector<String[]> order = null;
            try {
                int orderid = Integer.parseInt(httpservletrequest.getParameter("orderid"));
                String sql = "select * from orders where orderid=" + orderid;
                order = orderdatabase.getOrderList(sql);
            } catch (NumberFormatException nfe) {
                order = new Vector<String[]>();
            }
            httpservletrequest.setAttribute("order", order);
            httpservletrequest.getRequestDispatcher("adminorder.jsp").forward(httpservletrequest, httpservletresponse);
        }

    }
}
