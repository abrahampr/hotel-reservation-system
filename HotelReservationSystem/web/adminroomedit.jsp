<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>edit room</title>
        <link href="CSS/styleHRS.css" type="text/css" rel="stylesheet">
        <script language="JavaScript" type="text/javascript">
            function check2()
            {
                if(document.resInfo.newroomname.value=="")
                {
                    alert("ID is null!");
                    resInfo.newroomname.focus();
                    return false;
                }
                if(document.resInfo.style.value=="")
                {
                    alert("style is null!");
                    resInfo.style.focus();
                    return false;
                }
                if(document.resInfo.cost.value=="")
                {
                    alert("cost is null!");
                    resInfo.cost.focus();
                    return false;
                }
                if(document.resInfo.details.value=="")
                {
                    alert("detail is null!");
                    resInfo.details.focus();
                    return false;
                }
                document.resInfo.action.value="changeRes";
                document.resInfo.submit();
            }
            function check()
            {
                if(document.searchRes.roomname.value=="")
                {
                    alert("please input ID");
                    searchRes.roomname.focus();
                    return false;
                }
                document.searchRes.submit();
            }
        </script>
    </head>
    <body><div align="center"><fieldset><legend>Edit Room informaion</legend>
                <table border="1">
                    <tr>
                        <td rowspan="2"><table>
                                <th id="navigator">group</th>
                                <tr>
                                    <td><a href=listserv?action=adminList&&groupid=0>all group</a></td>
                                </tr>
                                <% //get group data
                                            Vector<String[]> vgroup = serv.database.getGroup();
                                            for (String[] s : vgroup) {%>
                                <tr>
                                    <td><a href=listserv?action=adminList&&groupid=<%=s[0]%>><%= s[1]%></a></td>
                                </tr>
                                <%}%>
                            </table></td>
                        <td><table>
                                <tr>
                                    <td><a target="balnk" href="adminroommanage.jsp">create new room</a></td>
                                    <td>Room:
                                        <form name="searchRes" action="listserv" method="post">
                                            <input type="text" name="roomname">
                                            <input type="button" value="check" onclick="return check()">
                                            <input type="hidden" name="action2" value="queryRes">
                                        </form></td>
                                </tr>
                            </table></td></tr>
                    <tr><td><% //get room information
                                Vector<String[]> roominfo =
                                        (Vector<String[]>) request.getAttribute("roominfo");
                                String[] s = roominfo.get(0);
                            %>
                            <table>
                                <form name="resInfo" action="listserv" method="post">
                                    <tr>
                                        <td id="label">ID:</td>
                                        <td><input type="text" name="newroomname" value=<%= s[0]%>></td>
                                    </tr>
                                    <tr>
                                        <td id="label">group:</td>
                                        <td>
                                            <select name="roomgroup">
                                                <% //ergodic the vector
                                                            for (String ss[] : vgroup) {
                                                                if (ss[0].equals(s[5])) {
                                                %>
                                                <option selected value=<%= ss[0]%>><%= ss[1]%></option>
                                                <%
                                                                                                                } else {
                                                %>
                                                <option value=<%= ss[0]%>><%= ss[1]%></option>
                                                <%
                                                                }
                                                            }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td id="label">style:</td>
                                        <td><input type="text" name="style" value=<%= s[1]%>></td>
                                    </tr>
                                    <tr>
                                        <td id="label">cost:</td>
                                        <td><input type="text" name="cost" value=<%= s[2]%>></td>
                                    </tr>
                                    <tr>
                                        <td id="label">detail:</td>
                                        <td>
                                            <textarea rows=4 cols=40 name="details"><%= s[3]%></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td id="label">status:</td>
                                        <td>
                                            <select name="status">
                                                <option>empty</option>
                                                <%
                                                            if (s[4].equals("used")) {
                                                %>
                                                <option selected>used</option>
                                                <%                } else {
                                                %>
                                                <option>used</option>
                                                <%                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr><td></td>
                                        <td align="left">
                                            <input type="hidden" name="action" value="deleteRes">
                                            <input type="hidden" name="roomid" value=<%= s[6]%>>
                                            <input type="hidden" name="oldroomname" value=<%= s[0]%>>
                                            <input type="button" value="save" onclick="check2()">
                                            <input type="submit" value="delete">
                                            <input type="button" name="back" id="back" value="back" onclick="window.location.href='adminroom.jsp'"></td>
                                    </tr>
                                </form>
                            </table></td></tr>
                </table></fieldset>
            <br></div>
    </body>
</html>
