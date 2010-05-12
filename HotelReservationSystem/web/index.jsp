<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*,serv.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Index</title>
        <link href="css/styleHRS.css" type="text/css" rel="stylesheet">
        <!--[if lt IE 7]>
        <style type="text/css">
        #sidebar { margin-top:1em; }
        #sidebarset { padding-bottom: 22em; padding-left:10px;padding-right:10px;}
        </style>
<![endif]-->
    </head>
    <body>
        <div align="center">
            <table id="indextable" width="1024" border="0" bgcolor="#FFFFFF">
                <tr>
                    <td align="center" height="100" colspan="2">
                        <img src="image/logo.jpg" width="1020" height="150" alt="">
                    </td>
                </tr>
                <tr>
                    <td id="sidebar" width="200" bgcolor="#CCCCCC"><div id="sidebarset">
                        <%if (session.getAttribute("username") == null && session.getAttribute("adminusername") == null && session.getAttribute("adminroot") == null) {/* check the user account, if null */%>
                        <table id="sidebar" width="200" align="center"><tr><td id="navigator"><strong>Welcome, Guest :<br>
                                    </strong></td></tr>
                            <tr><td id="menu"><a href=login.jsp>Sign in</a></td></tr>
                            <tr><td id="menu"><a href="reg.jsp">Sign up</a></td></tr></table>
                            <%} else if (session.getAttribute("username") != null /*if not null,then check user authority*/) {%>
                            <%String username = (String) session.getAttribute("username");%>
                        <table id="sidebar" width="200" align="center" ><tr><td id="navigator"><strong>Welcome,
                                        <%out.println(username);%>
                                        :</strong></td></tr>
                            <tr><td id="menu"><a href=useredit.jsp>Edit my profile</a></td></tr>
                            <tr><td id="menu"><a href=userorder.jsp>My Order</a></td></tr>
                            <tr><td id="menu"><a href=orderserv?action=order>Check order status</a></td></tr>
                            <tr><td id="menu"><a href=logoutserv?action=logout>Logout</a></td></tr></table>

                        <%} else if (session.getAttribute("adminusername") != null) {%>
                        <%String adminusername = (String) session.getAttribute("adminusername");%>
                        <table id="sidebar" width="200" align="center" ><tr><td id="navigator"><strong>Welcome,
                                        <%out.println(adminusername);%>
                                        :</strong></td></tr>
                            <tr><td id="menu"><a href=listserv?action=adminList&&groupid=0>manage room</a></td></tr>
                            <tr><td id="menu"><a href=listserv?action=adminGroup>manage room group</a></td></tr>
                            <tr><td id="menu"><a href=orderserv?action=allOrders&&condition=1>manage order</a></td></tr>
                            <tr><td id="menu"><a href=logoutserv?action=logout>logout</a></td></tr></table>
                            <%} else if (session.getAttribute("adminroot") != null) {%>
                            <%String adminroot = (String) session.getAttribute("adminroot");%>
                        <table id="sidebar" width="200" align="center"><tr><td id="navigator"><strong>Welcome,
                                        <%out.println(adminroot);%>
                                    </strong></td></tr>
                            <tr><td id="menu"><a href=adminmanage.jsp>manage admin</a></td></tr>
                            <tr><td id="menu"><a href=adminedit.jsp>edit password</a></td></tr>
                            <tr><td id="menu"><a href=logoutserv?action=logout>Logout</a></td></tr></table>
                            <%}%></div>
                    </td>
                    <td width="808" height="300">
                        <table id="main" width="90%" border="0" align="center">
                            <%Vector<String[]> v = database.getGroup(); /*get group from database and ergodic the result */
                                        for (String[] s : v) {%>
                            <tr><td align="center" width="150" rowspan="2"><img alt="RoomPic" src="<%=s[4]%>"/></td>
                                <td id="maintitle" height="30" ><%=s[1]%></td>
                                <td width="150" rowspan="2" ><a href=listserv?action=list&&groupid=<%=s[0]%>><img alt="reservation this room" src="image/RTR.png" /></a></td>
                            </tr>
                            <tr>
                                <td id="maincontent" width="300"><%=s[2]%></td>
                            </tr>
                            <%}%>

                        </table>
                    </td>
                </tr>
                <tr bgcolor="#CCCCFF">
                    <td align="center" colspan="2">
                        <hr>
                        <p>Copyright © 2010 Group16. All Rights Reserved.</p></td>
                </tr>
            </table>
        </div>
    </body>
</html>
