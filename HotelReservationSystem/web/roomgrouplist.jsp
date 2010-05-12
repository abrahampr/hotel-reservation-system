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
                var startyear = document.order.startyear.value;
                var startmonth = document.order.startmonth.value;
                var startday = document.order.startday.value;
                var finishyear = document.order.finishyear.value;
                var finishmonth = document.order.finishmonth.value;
                var finishday = document.order.finishday.value;
                var starthour = document.order.starthour.value;
                var finishhour = document.order.starthour.value;
                var startdate = new Date();
                startdate.setFullYear(startyear,startmonth,startday)
                startdate.setHours(starthour,0,0)
                var finishdate = new Date();
                finishdate.setFullYear(finishyear,finishmonth,finishday)
                finishdate.setHours(finishhour,0,0)
                if(startdate>finishdate){
                    alert("your time is wrong value");
                    return false;
                }
               if(eval(startyear)==eval(finishyear) && eval(startmonth)==eval(finishmonth) && eval(startday)==eval(finishday)){
                     alert("You can not reservation a room in same day!");
                    return false;            
               }
                var c=confirm("This will take the order in your order list"+'\n'+"Will you Confirm?");
                if(c==true){
                   return true;
                }else {
                   return false;
                }
                document.order.submit();
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
  	  check in:
                                    </td>
                                    <td>
                                        <select name="startyear">
                                            <option selected><%=year%></option>
                                        </select>year

                                        <select name="startmonth">
                                            <option selected><%=month%></option>
                                            <% int month1=month+1;%>
                                            <option><%=month1%></option>
                                        </select>month

                                        <select name="startday">
                                            <%
                                            int daystatus=0;
                                            if(month==1 || month ==3 || month ==5 || month ==7 || month ==8 || month ==10 || month ==12){
                                            daystatus=32;
                                            } else
                                            if(month==4 || month ==6 || month ==9 || month ==11){
                                            daystatus=31;
                                            } else
                                            if(year%4==0){
                                            daystatus=29;
                                            } else
                                            if(year%4!=0){
                                            daystatus=28;
                                            }%>
                                            <option  selected><%= day %></option>
                                                   <%     for (int i = day; i < daystatus; i++) {
                                                            if (i != day) {%>
                                            <option><%=i%></option>
                                            <%
                                                                                                        } else {
                                            %>
                                            continue;
                                            <%
                                                            }
                                                        }
                                            %>
                                        </select>day

                                        <select name="starthour">
                                            <%
                                                        for (int i = hour; i < 24; i++) {
                                                            if (i != hour) {
                                            %>
                                            <option><%=i%></option>
                                            <%
                                                                                                        } else {
                                            %>
                                            <option  selected><%=i%></option>
                                            <%
                                                            }
                                                        }
                                            %>
                                        </select>hour
                                    </td>
                                </tr>
                                <tr>
                                    <td id="label">
  	  check out:
                                    </td>
                                    <td>
                                        <select name="finishyear">
                                            <option  selected><%= year%></option>
                                            <option><%= year + 1%></option>
                                        </select>year

                                        <select name="finishmonth">
                                            <option  selected><%= month%></option>
                                            <%int month2=month+2;%>
                                            <option><%= month1%></option>
                                            <option><%= month2%></option>
                                        </select>month

                                        <select name="finishday">
                                            <% int finishdays;
                                                    finishdays = day+1;
                                            %>
                                            <option  selected><%= finishdays %></option>
                                            <%
                                                        for (int i = 1; i < daystatus; i++) {
                                                            if (i != finishdays) {
                                            %>
                                            <option><%= i%></option>
                                            <%
                                                       } else {
                                            %>
                                            
                                            <%continue;
                                                            }
                                                        }
                                            %>
                                        </select>day

                                        <select name="finishhour">
                                            <%
                                                        for (int i = 1; i < 24; i++) {
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