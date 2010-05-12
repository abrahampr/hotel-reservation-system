<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Add room</title>
        <link href="css/styleHRS.css" type="text/css" rel="stylesheet">
        <script language="JavaScript" type="text/javascript">
            function checkadminaddroom()
            {
                if(document.addRes.roomname.value=="")
                {
                    alert("ID is NULL");
                    addRes.roomname.focus();
                    return false;
                }
                if(document.addRes.style.value=="")
                {
                    alert("style is NULL");
                    addRes.style.focus();
                    return false;
                }
                if(document.addRes.cost.value=="")
                {
                    alert("PRICE IS NULL");
                    addRes.cost.focus();
                    return false;
                }
                if(document.addRes.details.value=="")
                {
                    alert("PS is NULL");
                    addRes.details.focus();
                    return false;
                }
                document.addRes.submit();
            }
            function check()
            {
                if(document.searchRes.roomname.value=="")
                {
                    alert("please input id to serach");
                    searchRes.roomname.focus();
                    return false;
                }
                document.searchRes.submit();
            }
        </script>
    </head>
    <body>
        <div align="center">
            <table border="1">
                <tr>
                    <td rowspan="2"><table>
                            <th id="navigator">Group</th>
                            <tr>
                                <td><a href=listserv?action=adminList&&groupid=0>All group</a></td>
                            </tr>
                            <% /*get the group and ergodic data*/
              Vector<String[]> vgroup = serv.database.getGroup();
              for (String[] s : vgroup) {%>
                            <tr>
                                <td><a href=listserv?action=adminList&&groupid=<%=s[0]%>><%= s[1]%></a></td>
                            </tr>
                            <%}%>
                        </table></td>
                    <td><table align="right">
                            <form name="searchRes" action="listserv" method="post">
                                <tr>
                                    <td><a target="balnk" href="adminaddroom.jsp">create room</a></td>
                                    <td>Room:
                                        <input type="text" name="roomname2">
                                        <input type="button" value="check" onclick="check()">
                                        <input type="hidden" name="action2" value="queryRes"></td>
                                </tr>
                            </form>
                        </table></td></tr>
                <tr><td><fieldset>
                            <legend>please input the correct information:</legend>

                            <table>
                                <form name="addRes" action="listserv" method="post">
                                    <tr>
                                        <td id="label">room:</td>
                                        <td><input type="text" name="roomname"></td>
                                    </tr>
                                    <tr>
                                        <td id="label"> group:</td>
                                        <td>
                                            <select name="roomgroup">
                                                <%//ergodic the group and make a list
                                                            for (String s[] : vgroup) {
                                                %>
                                                <option value=<%= s[0]%>><%= s[1]%></option>
                                                <%
                                                            }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td id="label">style:</td>
                                        <td><input type="text" name="style"></td>
                                    </tr>
                                    <tr>
                                        <td id="label">cost:</td>
                                        <td><input type="text" name="cost"></td>
                                    </tr>
                                    <tr>
                                        <td id="label">details:</td>
                                        <td>
                                            <textarea rows=4 cols=40 name="details"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td id="label">status:</td>
                                        <td>
                                            <select name="status">
                                                <option>empty</option>
                                                <option>used</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr><td></td>
                                        <td align="left">
                                            <input type="hidden" name="action" value="addRes">
                                            <input type="submit" value="save" onclick="return checkadminaddroom()">
                                            <input type="reset" value="reset">
                                            <label>
                                                <input type="button" name="back" id="back" value="back" onclick="window.location.href='listserv?action=adminList&&groupid=0'">
                                            </label></td>
                                    </tr>
                                </form>
                            </table></fieldset></td></tr>
            </table><br><br><br>

        </div>
    </body>
</html>
