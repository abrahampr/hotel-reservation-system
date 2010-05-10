<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>

<% Vector<String> list = (Vector<String>) session.getAttribute("list");
            int group = Integer.parseInt(list.get(0));//get group id
            String groupname = list.get(1);//get group name
            String grouprules = list.get(3);//get group rules
            String cpStr = request.getParameter("cp");//get the current page
            int currPage = 1;//initial the current page, if cpstr=null, then current page is 1
            if (cpStr != null) {//get the current page
                currPage = Integer.parseInt(cpStr.trim());
            }
            int span = 5;//set the record in each page.
%>
<html>
    <head>
        <title>Rservation list for <%=groupname%></title>
        <link href="css/styleHRS.css" type="text/css" rel="stylesheet">
        <script language="JavaScript" type="text/javascript">
            function checktime(){
                if(document.order.startyear.value>document.order.finishyear.value){
                    alert ("year time is not correct!");
                    return false;
                }
                if(document.order.startyear.value==document.order.finishyear.value && document.order.startmonth.value>document.order.finishmonth.value){
                    alert ("month time is not correct!");
                    return false;
                }
                if(document.order.startyear.value==document.order.finishyear.value && document.order.startmonth.value==document.order.finishmonth.value && document.order.startday.value>=document.order.finishday.value){
                    alert ("start day must not same as end day!");
                    return false;
                }
                document.add.submit();
            }
        </script>
    </head>
    <body><div align="center">
            <table>
                <tr>
                    <td>
                        <table border="0" align="center">
                            <tr bgcolor="#ccccff">
                                <th id="thlabel">Room</th>
                                <th id="thlabel">type</th>
                                <th id="thlabel">price</th>
                                <th id="thlabel">discribe</th>
                                <th id="thlabel">statue</th>
                            </tr>
                            <% Vector<String[]> v = serv.database.getPageContent(currPage, span, group);//get the data in the page
                                        int totalPage = serv.database.getTotal(span, group);//get the total page
                                        for (String[] s : v) { /* show the data*/%>
                            <tr>
                                <td><%=s[0]%></td>
                                <td><%=s[1]%></td>
                                <td><%=s[2]%></td>
                                <td><%=s[3]%></td>
                                <td>
                                    <a target="blank" href=listserv?action=status&&roomname=<%= s[0]%>>Look</a>
                                </td>
                            </tr>
                            <%}%>
                        </table>
                        <table align="center">
                            <tr>
                                <td>
                                    <%if (currPage > 1) {/*implment the last page link*/%>
                                    <a href=roomgrouplist.jsp?cp=<%= currPage - 1%>><< Lastpage</a>
                                    <%}%>
                                </td>

                                <td align="center"><br>
                                    <form action=roomgrouplist.jsp method="post">
                                        <select name="cp" onChange="this.form.submit();">
                                            <% for (int i = 1; i <= totalPage; i++) {//show the pages
                                                            String select = "";
                                                            if (i == currPage) {
                                                                select = "selected";
                                                            }%>
                                            <option value="<%= i%>" <%= select%>>page:<%= i%></option>
                                            <%}%>
                                        </select>
                                    </form>
                                </td>

                                <td>
                                    <%if (currPage < totalPage) {/*implement the next page link*/%>
                                    <a href=roomgrouplist.jsp?cp=<%= currPage + 1%>>nextpage>></a>
                                    <%}%>
                                </td>
                            </tr>
                        </table>
                        <table align="center">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td bgcolor="#ccccff"><strong>
			Reservation rules for <%= groupname%>:<br></strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
			1.please input correct reservation time<br>
			2.please check out the information about the room<br>
			3.<%= grouprules%>
                                            <td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table align="center">
                            <form name="order" action="orderserv" method="post">
                                <tr>
                                    <td id="label">Room:</td><td>
                                        <select name="orderNum">
                                            <%for (String[] s : v) { /*if the room has been ordered, this room will not display in the menu.*/
                                                            if (serv.orderdatabase.isOrdered(s[0])) {
                                                                continue;
                                                            }
                                            %>
                                            <option><%= s[0]%></option>
                                            <%}%>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="label">Group:</td>
                                    <td>
                                        <textarea name="group" readonly="readonly"><%= groupname%></textarea>
                                    </td>
                                </tr>
                                <%Date now = new Date(); //get the time
                                            int year = now.getYear() + 1900;
                                            int month = now.getMonth() + 1;
                                            int day = now.getDate();
                                            int hour = now.getHours();
                                %>
                                <tr>
                                    <td id="label">
  	  start time:
                                    </td>
                                    <td>
                                        <select name="startyear">
                                            <option selected><%=year%></option>
                                            <option><%=year + 1%></option>
                                        </select>year

                                        <select name="startmonth">
                                            <%
                                                        for (int i = 1; i < 13; i++) {
                                                            if (i != month) {
                                            %>
                                            <option><%=i%></option>
                                            <%
                                                                                                        } else {
                                            %>
                                            <option selected><%=i%></option>
                                            <%
                                                                                                        }
                                            %>
                                            <%
                                                        }
                                            %>
                                        </select>month

                                        <select name="startday">
                                            <%
                                                        for (int i = 1; i < 32; i++) {
                                                            if (i != day) {%>
                                            <option><%=i%></option>
                                            <%
                                                                                                        } else {
                                            %>
                                            <option selected><%=i%></option>
                                            <%
                                                            }
                                                        }
                                            %>
                                        </select>day

                                        <select name="starthour">
                                            <%
                                                        for (int i = 0; i < 24; i++) {
                                                            if (i != hour) {
                                            %>
                                            <option><%=i%></option>
                                            <%
                                                                                                        } else {
                                            %>
                                            <option selected><%=i%></option>
                                            <%
                                                            }
                                                        }
                                            %>
                                        </select>hour
                                    </td>
                                </tr>
                                <tr>
                                    <td id="label">
  	  finish time:
                                    </td>
                                    <td>
                                        <select name="finishyear">
                                            <option selected><%= year%></option>
                                            <option><%= year + 1%></option>
                                        </select>Year

                                        <select name="finishmonth">
                                            <%
                                                        for (int i = 1; i < 13; i++) {
                                                            if (i != month) {
                                            %>
                                            <option><%= i%></option>
                                            <%
                                                                                                        } else {
                                            %>
                                            <option selected><%= i%></option>
                                            <%
                                                            }
                                                        }
                                            %>
                                        </select>month

                                        <select name="finishday">
                                            <%
                                                        for (int i = 1; i < 32; i++) {
                                                            if (i != day) {
                                            %>
                                            <option><%= i%></option>
                                            <%
                                                                                                        } else {
                                            %>
                                            <option selected><%= i%></option>
                                            <%
                                                            }
                                                        }
                                            %>
                                        </select>day

                                        <select name="finishhour">
                                            <%
                                                        for (int i = 0; i < 24; i++) {
                                                            if (i != hour) {
                                            %>
                                            <option><%= i%></option>
                                            <%
                                                                                                        } else {
                                            %>
                                            <option selected><%= i%></option>
                                            <%
                                                            }
                                                        }
                                            %>
                                        </select>hour
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <input type="hidden" name="action" value="add">
                                        <input type="submit" name="add" value="add to order" onclick="return checktime()">
                                        <input type="button" name="back" id="back" value="back" onclick="window.location.href='index.jsp'"></td>
                                </tr>
                            </form>
                        </table>
                    </td>
                </tr>
            </table>

        </div>
    </body>
</html>