<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>adminroom</title>
        <link href="css/styleHRS.css" type="text/css" rel="stylesheet">
    </head>
    <body><div align="center">
            <script language="JavaScript" type="text/javascript">
                function check()
                {
                    if(document.search.roomname.value=="")
                    {
                        alert("please input ID!");
                        search.roomname.focus();
                        return false;
                    }
                    document.search.submit();
                }
            </script>
            <br>
            <table>
                <tr>
                    <td rowspan="3"><table>
                            <th id="navigator">group</th>
                            <tr>
                                <td><a href=listserv?action=adminList&&groupid=0>allgroup</a></td>
                            </tr>
                            <% //get the group data into vector
                                        Vector<String[]> vgroup = serv.database.getGroup();
                                        //ergodic the vector
                                        for (String[] s : vgroup) {%>
                            <tr>
                                <td><a href=listserv?action=adminList&&groupid=<%=s[0]%>><%= s[1]%></a></td>
                            </tr>
                            <%}%>
                        </table></td><td><table>
                            <tr>
                                <td>
                                    <a target="balnk" href="adminaddroom.jsp">create new room</a>
                                </td>

                                <td>Room:
                                    <form name="search" action="listserv" method="post">
                                        <input type="text" name="roomname">
                                        <input type="hidden" name="action" value="searchRoom">
                                        <input type="button" value="check" onclick="return check()">

                                    </form>
                                </td>

                            </tr>
                        </table></td></tr>
                <tr>
                    <td><table border="1">
                            <% //get group data
                                        Vector<String> list = (Vector<String>) session.getAttribute("list");
                                        int group = Integer.parseInt(list.get(0)); //get groupid
                                        String groupname = list.get(1); //get group name
                                        String cpStr = request.getParameter("cp"); // get the current page
                                        int currPage = 1;
                                        if (cpStr != null) {  //page is default by 1,if currentpage is not null,then it will be display the current page.
                                            currPage = Integer.parseInt(cpStr.trim());
                                        }
                                        int span = 5;  //set the record in each page.
                                        int totalPage = serv.database.getTotal(span, group); //get the total page.
                            %>
                            <%  //get the page content
                                        Vector<String[]> v = serv.database.getPageContent(currPage, span, group);
                            %>
                            <tr>
                                <th>ID</th>
                                <th>Group</th>
                                <th>style</th>
                                <th>cost</th>
                                <th>detial</th>
                                <th>status</th>
                                <th>Edit/del</th>
                            </tr>
                            <% //ergodic the page content
                                        for (String[] s : v) {
                            %>
                            <tr>
                                <td><%=s[0]%></td>
                                <td><%= s[6]%></td>
                                <td><%=s[1]%></td>
                                <td><font> <%=s[2]%></font></td>
                                <td><%=s[3]%></td>
                                <td><%= s[4]%></td>
                                <td><a href=listserv?action=editRes&&roomid=<%= s[5]%>>Edit/del</a></td>
                            </tr>
                            <%
                                        }
                            %>
                        </table></td>
                </tr>
                <tr><td>

                        <center>
                            <%= groupname%>
                        </center>
                        <table border="0">
                            <tr>
                                <td width="33%">
                                    <%
                                                if (currPage > 1) {
                                    %>
                                    <a href=adminroom.jsp?cp=<%= currPage - 1%>>last page</a>
                                    <%
                                                }
                                    %>&nbsp;
                                </td>

                                <td align="center"><br>
                                    <form action=adminroom.jsp method="post">
                                        <select name="cp" onchange="this.form.submit();">
                                            <%
                                                        for (int i = 1; i <= totalPage; i++) {
                                                            String s = "";
                                                            if (i == currPage) {
                                                                s = "selected";
                                                            }
                                            %>
                                            <option value="<%= i%>" <%= s%>>page:<%= i%></option>
                                            <%
                                                        }
                                            %>
                                        </select>
                                    </form>
                                </td>

                                <td align="right" width="33%">
                                    <%
                                                if (currPage < totalPage) {
                                    %>
                                    <a href=adminroom.jsp?cp=<%= currPage + 1%>>next page</a>
                                    <%
                                                }
                                    %>
                                </td>
                            </tr>
                        </table></td></tr>
            </table>
            <a href="index.jsp">
                <input type="button" name="back" id="back" value="back" onclick="window.location.href='index.jsp'">
            </a>
        </div>
    </body>
</html>
