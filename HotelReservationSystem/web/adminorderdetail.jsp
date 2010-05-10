<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>order detail</title>
        <link href="css/styleHRS.css" type="text/css" rel="stylesheet">
    </head>
    <body><div align="center">
            <% //get the list detail data into vector
                        Vector<String[]> ListDetail =
                                (Vector<String[]>) request.getAttribute("ListDetail");
               String orderid = (String) request.getAttribute("orderid");%>
            <br><center><strong>Order:<%= orderid%></strong></center><br>
            <table border="1">
                <tr bgcolor="#999999">
                    <th id="thlabel">ID</th>
                    <th id="thlabel">type</th>
                    <th id="thlabel">starttime</th>
                    <th id="thlabel">endtime</th>
                    <th id="thlabel">statue</th>
                </tr>
                <% //ergodic the order list detail
                       for (int i = 0; i < ListDetail.size(); i++) {
                           String[] s = ListDetail.get(i);%>
                <tr>
                    <td><%= s[0]%></td>
                    <td><%= s[4]%></td>
                    <td><%= s[1]%></td>
                    <td><%= s[2]%></td>
                    <td><%= s[3]%></td>
                </tr><%}%>
            </table>
            <%if (session.getAttribute("username") != null) {%>
            <input type="button" name="back" id="back" value="back" onclick="window.location.href='orderserv?action=order'">
            <%} else {%>
            <input type="button" name="back" id="back" value="back" onclick="window.location.href='orderserv?action=allOrders&&condition=1'">
            <%}%>

        </div>
    </body>
</html>
