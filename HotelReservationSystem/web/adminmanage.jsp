<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>manage admin</title>
        <link href="css/styleHRS.css" type="text/css" rel="stylesheet">
        <script language="javascript" type="text/javascript">
            function check_confirm(){
            var c=confirm("Are you really want to delete this administrator?");
            if(c==true){
                return true;
            } else {
                return false;
            }
        }
            </script>
    </head>
    <body><div align="center">
            <table>
                <tr>
                    <td><a href=adminadd.jsp>Create admin account</a><br><br>
                        <a href=adminedit.jsp>Edit admin info</a></td>
                    <td>    <% //set the admin information into the vector array
                                Vector<String[]> vadmin = serv.database.getAdminInfo();
                        %>
                        <table border="1">
                            <tr bgcolor="#999999">
                                <th id="thlabel">adminID</th>
                                <th id="thlabel">adminlevel</th>
                                <th id="thlabel">delete</th>
                            </tr>
                            <% //ergodic the admin authrity
                                        for (String[] s : vadmin) {
                            %>
                            <tr>
                                <td><%= s[0]%></td>
                                <%
                                          if (s[1].equals("root")) {
                                %>
                                <td>root</td>
                                <%                } else {
                                %>
                                <td>advanced</td>
                                <% }%>
                                <td>
                                    <a onclick="return check_confirm()" href=admindelserv?action=deladmin&&adminusername=<%= s[0]%>>Del</a>
                                </td>
                            </tr>
                            <%
                                        }
                            %>

                        </table></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td> <label>
                            <input type="button" name="back" id="back" value="back" onclick="window.location.href='index.jsp'">
                        </label></td>
            </table>


        </div>
    </body>
</html>
