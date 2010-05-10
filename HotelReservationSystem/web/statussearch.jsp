<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <% //get vector, roomname and is ordered attribute
                    Vector<String[]> v = (Vector<String[]>) request.getAttribute("v");
                    String title = "No." + (String) request.getAttribute("roomname");
                    String isOrdered = (String) request.getAttribute("isOrdered");%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>statues of <%=title%></title>
        <link href="css/styleHRS.css" type="text/css" rel="stylesheet">
    </head>
    <body><div align="center">
            <% if (isOrdered.trim().equals("YES")) {
                            out.println("<center>");
                            out.println("<font>sorry,this room has been reserved.<br><br><br>");
                            out.println("<a href=roomgrouplist.jsp>return");
                            out.println("</center>");
                        } else {
                            if (v.size() == 0) {
                                out.println("<center>");
                                out.println("<font>no order<br><br><br>");
                                out.println("<a href=roomgrouplist.jsp>return");
                                out.println("</center>");
                        } else {%>
            <table border="1">
                <tr>
                    <th id="label">start time</th>
                    <th id="label">end time</th>
                    <th id="label">status</th>
                </tr>
                <% //ergodic the vector v
                                        for (String s[] : v) {%>
                <tr>
                    <td><%= s[0]%></td> <td align="center"><%= s[1]%></td>
                    <td>has been reserved</td>
                </tr>
                <tr>
                    <td colspan="3" align="center"><input type="button" name="back" id="back" value="back" onclick="window.location.href='roomgrouplist.jsp'"></td>
                </tr>
                <%}%>
            </table><%}
                    }%></div>
    </body>
</html>
