<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>user order</title>
        <link href="css/styleHRS.css" type="text/css" rel="stylesheet">
    </head>
    <body><div align="center">
            <%Vector<String[]> OrderList = (Vector<String[]>) session.getAttribute("OrderList");
                        if (OrderList == null || OrderList.size() == 0) {
                            out.println("<center>");
                            out.println("<font>You have not reserve yet!</font>");
                            out.println("<br><br><a href=index.jsp>return");
              } else {%>
            <table border="1">
                <tr bgcolor="#999999">
                    <th id="thlabel">Room</th>
                    <th id="thlabel">type</th>
                    <th id="thlabel">start time</th>
                    <th id="thlabel">end time</th>
                    <th id="thlabel">delete</th>
                </tr>
                <% //get order list and insert into array
                    for (int i = 0; i < OrderList.size(); i++) {
                        String[] s = OrderList.get(i);%>
                <tr>
                    <td><%=s[0]%></td>
                    <td><%=s[1]%></td>
                    <td><%=s[2]%></td>
                    <td><%=s[3]%></td>
                    <td>
                        <form action="orderserv" name="delete" method="post">
                            <input type="hidden" name="index" value=<%= i%>>
                            <input type="hidden" name="action" value="delete">
                            <input type="submit" value="delete">
                        </form>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td align="center" colspan="2">
                        <form action="orderserv" name="empty" method="post">
                            <input type="hidden" name="action" value="empty">
                            <input type="submit" value="empty">
                        </form>
                    </td>
                    <td>
                        <form action="orderserv" name="submit" method="post">
                            <input type="hidden" name="action" value="submit">
                            <input type="submit" value="submit">
                        </form>
                    </td>
                    <td><label>
                            <input type="submit" name="back" id="back" value="continue" onclick="window.location.href='roomgrouplist.jsp'">
                        </label></td>
                    <td><label>
                            <input type="button" name="back" id="back" value="back" onclick="window.location.href='index.jsp'">
                        </label></td>
                </tr>
            </table><%}%>
        </div> </body>
</html>
