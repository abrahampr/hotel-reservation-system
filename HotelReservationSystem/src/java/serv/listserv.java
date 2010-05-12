package serv;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class listserv extends HttpServlet {

    public void init(ServletConfig conf) throws ServletException {
        super.init(conf);
    }

    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
            throws ServletException, IOException {
        doPost(httpservletrequest, httpservletresponse);
    }

    public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
            throws ServletException, IOException {
        String action = httpservletrequest.getParameter("action");
        HttpSession httpsession = httpservletrequest.getSession(true);
        String msg = "";
//list the group infomation through gourpid
        if (action.equals("list")) {
            int groupid = Integer.parseInt(httpservletrequest.getParameter("groupid"));
            Vector<String> list = database.getGroupInfomation(groupid);
            httpsession.setAttribute("list", list);
            httpservletresponse.sendRedirect("roomgrouplist.jsp");
        }
//check the room status
        if (action.equals("status")) {
            Vector<String[]> v = null;
            String isOrdered = "NO";
            String roomname = httpservletrequest.getParameter("roomname");
            if (orderdatabase.isOrdered(roomname)) {
                isOrdered = "YES";
            } else {
                v = orderdatabase.getOrderedDay(roomname);
            }
            httpservletrequest.setAttribute("v", v);
            System.out.println(v);
            httpservletrequest.setAttribute("roomname", roomname);
            httpservletrequest.setAttribute("isOrdered", isOrdered);
            httpservletrequest.getRequestDispatcher("statussearch.jsp").forward(httpservletrequest, httpservletresponse);
        }
//list the group
        if (action.equals("adminList")) {
            Vector<String> list = new Vector<String>();
            if (httpsession.getAttribute("adminusername") != null) {
                int groupid = Integer.parseInt(httpservletrequest.getParameter("groupid"));
                if (groupid == 0) {
                    list.add("0");
                    list.add("all group");
                } else {
                    list = database.getGroupInfomation(groupid);
                }
                httpsession.setAttribute("list", list);
                httpservletresponse.sendRedirect("adminroom.jsp");
            } else {
                msg = "login first<br><br><a href=index.jsp></a>";
                httpservletrequest.setAttribute("msg", msg);
                httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
            }
        }
//add the room
        if (action.equals("addRes")) {
            String roomname = httpservletrequest.getParameter("roomname").trim();
            String roomgroup = httpservletrequest.getParameter("roomgroup");
            String style = httpservletrequest.getParameter("style").trim();
            Double cost = Double.parseDouble(httpservletrequest.getParameter("cost").trim());
            String details = httpservletrequest.getParameter("details").trim();
            String status = httpservletrequest.getParameter("status");
            String sql = "select * from ROOM where ROOM_Name='" + roomname + "'";
            if (database.isExist(sql)) {
                msg = "ID is exist<br><br><a href=adminaddroom.jsp>return</a>";
            } else {
                sql = "insert into ROOM(ROOM_ID,CATE_ID,ROOM_Name,ROOM_Style,ROOM_Cost,ROOM_Detail,ROOM_Status)"
                        + "values(NULL,'" + roomgroup + "','" + roomname + "','" + style + "'," + cost + ",'"
                        + details + "','" + status + "')";
                if (database.update(sql) > 0) {
                    msg = "Success!<br><br><a href=listserv?action=adminList&&groupid=0>return</a>";
                }
            }
            httpservletrequest.setAttribute("msg", msg);
            httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
        }
//get the room information and convinent to edit
        if (action.equals("editRes")) {
            int roomid = Integer.parseInt(httpservletrequest.getParameter("roomid"));
            String sql = "select ROOM_Name,ROOM_Style,ROOM_Cost,ROOM_Detail,ROOM_Status,CATE_ID,ROOM_ID from ROOM where ROOM_ID='" + roomid + "'";
            Vector<String[]> roominfo = database.getRoomInformation(sql);
            httpservletrequest.setAttribute("roominfo", roominfo);
            httpservletrequest.getRequestDispatcher("adminroomedit.jsp").forward(httpservletrequest, httpservletresponse);
        }

//delete the room
        if (action.equals("deleteRes")) {
            String roomid = httpservletrequest.getParameter("roomid");
            String sql = "delete from ROOM where ROOM_ID='" + roomid + "'";
            if (database.update(sql) > 0) {
                msg = "Success!<br><br><a href=listserv?action=adminList&&groupid=0>return</a>";
            } else {
                msg = "wrong! please call your administrator to solve it.<br><br><a href=listserv?action=adminList&&groupid=0>return</a>";
            }
            httpservletrequest.setAttribute("msg", msg);
            httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
        }
//edit the room
        if (action.equals("changeRes")) {
            String oldroomname = httpservletrequest.getParameter("oldroomname");
            String newroomname = httpservletrequest.getParameter("newroomname");
            int roomid = Integer.parseInt(httpservletrequest.getParameter("roomid"));
            String roomgroup = httpservletrequest.getParameter("roomgroup");
            String style = httpservletrequest.getParameter("style").trim();
            double cost = Double.parseDouble(httpservletrequest.getParameter("cost").trim());
            String details = httpservletrequest.getParameter("details").trim();
            String status = httpservletrequest.getParameter("status");
            String sql = "update ROOM set ROOM_Name='" + newroomname + "',CATE_ID='" + roomgroup + "',ROOM_Style='" + style
                    + "',ROOM_Cost=" + cost + ",ROOM_Detail='" + details + "',ROOM_Status='" + status + "' where ROOM_ID='" + roomid + "'";
            if (oldroomname.equals(newroomname)) {
                if (database.update(sql) > 0) {
                    msg = "Done! Room information has been changed<br><br><a href=listserv?action=adminList&&groupid=0>return</a>";
                }
            } else {
                String sqla = "select * from ROOM where ROOM_Name='" + newroomname + "'";
                if (database.isExist(sqla)) {
                    msg = "ID is exist,try another。<br><br><a href=listserv?action=editRes&&roomid=" + roomid + ">return</a>";
                } else {
                    if (database.update(sql) > 0) {
                        msg = "Success!<br><br><a href=listserv?action=adminList&&groupid=0>return</a>";
                    }
                }
            }
            httpservletrequest.setAttribute("msg", msg);
            httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
        }
//check the user if he/she is admin
        if (action.equals("adminGroup")) {
            if (httpsession.getAttribute("adminusername") != null) {
                httpservletresponse.sendRedirect("adminroomgroup.jsp");
            } else {
                msg = "login first";
                httpservletrequest.setAttribute("msg", msg);
                httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
            }
        }
//add a group
        if (action.equals("addGroup")) {
            int groupid = database.getId("roomgroup", "groupid");
            String groupname = httpservletrequest.getParameter("groupname");
            String groupimage = httpservletrequest.getParameter("groupimage");
            String groupdetails = httpservletrequest.getParameter("groupdetails");
            String grouprules = httpservletrequest.getParameter("grouprules");
            String sql = "insert into ROOM_CATEGORY(CATE_ID,CATE_Name,CATE_Image,CATE_Detail,CATE_Rule)values(NULL,'"
                    + groupname + "','" + groupimage + "','" + groupdetails + "','" + grouprules + "')";
            if (database.update(sql) > 0) {
                msg = "Success! New group has been available now.<br><br><a href=listserv?action=adminGroup>return</a>";
            } else {
                msg = "error!";
            }
            httpservletrequest.setAttribute("msg", msg);
            httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
        }
//get the group information
        if (action.equals("editGroup")) {
            int groupid = Integer.parseInt(httpservletrequest.getParameter("groupid"));
            Vector<String> groupinfo = database.getGroupInfomation(groupid);
            httpservletrequest.setAttribute("groupinfo", groupinfo);
            httpservletrequest.getRequestDispatcher("adminroomgroupedit.jsp").forward(httpservletrequest, httpservletresponse);
        }
//edit group
        if (action.equals("changeGroup")) {
            int groupid = Integer.parseInt(httpservletrequest.getParameter("groupid"));
            String oldgroupname = httpservletrequest.getParameter("oldgroupname");
            String newgroupname = httpservletrequest.getParameter("newgroupname");
            String groupimage = httpservletrequest.getParameter("groupimage");
            String groupdetails = httpservletrequest.getParameter("groupdetails");
            String grouprules = httpservletrequest.getParameter("grouprules");
            String sql = "update ROOM_CATEGORY set CATE_Name='" + newgroupname + "',CATE_Detail='" + groupdetails
                    + "',CATE_Rule='" + grouprules + "',CATE_Image='" + groupimage + "' where CATE_ID=" + groupid;
            if (newgroupname.equals(oldgroupname)) {
                if (database.update(sql) > 0) {
                    msg = "Success! Group information has been changed<br><br><a href=listserv?action=adminGroup>return</a>";
                }
            } else {
                String sqla = "select * from ROOM_CATEGORY where CATE_Name='" + newgroupname + "'";
                if (database.isExist(sqla)) {
                    msg = "Group name has been used!try another one<br><br><a href=listserv?action=editGroup&&groupid=" + groupid + ">return</a>";
                } else {
                    if (database.update(sql) > 0) {
                        msg = "Success!<br><br><a href=listserv?action=adminGroup>return</a>";
                    }
                }
            }
            httpservletrequest.setAttribute("msg", msg);
            httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
        }
//delete the group
        if (action.equals("deleteGroup")) {
            int groupid = Integer.parseInt(httpservletrequest.getParameter("groupid"));
            String sqla = "delete from ROOM where CATE_ID=" + groupid;
            String sqlb = "delete from ROOM_CATEGORY where CATE_ID=" + groupid;
            if (database.update(sqla, sqlb) == true) {
                msg = "done!<br><br><a href=listserv?action=adminGroup>return</a>";
            } else {
                msg = "Error";
            }
            httpservletrequest.setAttribute("msg", msg);
            httpservletrequest.getRequestDispatcher("usercheck.jsp").forward(httpservletrequest, httpservletresponse);
        }
//search the room
        if (action.equals("searchRoom")) {
            String roomname = httpservletrequest.getParameter("roomname");
            String sql = "select ROOM_Name,ROOM_Style,ROOM_Cost,ROOM_Detail,ROOM_Status,CATE_ID,ROOM_ID from ROOM where ROOM_Name='" + roomname + "'";
            Vector<String[]> v = database.getRoomInformation(sql);
            httpservletrequest.setAttribute("list", v);
            httpservletrequest.getRequestDispatcher("roomsearch.jsp").forward(httpservletrequest, httpservletresponse);
        }
    }
}
