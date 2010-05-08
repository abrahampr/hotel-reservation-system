<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
 <head>
   <title>orderstatus</title>
    <link href="css/styleHRS.css" type="text/css" rel="stylesheet">
 </head>
 <div align="center">
 <body>
   <%Vector<String[]> list = (Vector<String[]>)request.getAttribute("list");
    if(list==null||list.size()==0){
      out.println("<center>");
      out.println("<font>you have not order yet</font>");
      out.println("<br><br><a href=index.jsp>return");
    }else{%>
  <table>
      <tr bgcolor="ccccff">
            <th id="thlabel">ID</th>
           <th id="thlabel">user</th>
	   <th id="thlabel">ordertime</th>
           <th id="thlabel">status</th>
	   <th id="thlabel">execute admin</th>
           <th id="thlabel">Details</th>
           <th id="thlabel">PS</th>
	 </tr>
	   <%int color = 0;
	  	 for(int i=0;i<list.size();i++){
		   String[] s = list.get(i);%>
          <tr align="center">
	   <td><%= s[0] %></td>
           <td><%= s[1] %></td>
	   <td><%= s[2] %></td>
           <td><%= s[4] %></td>
	   <td><%= s[3] %></td>
	   <td>
	    <a target="blank" href=orderserv?action=ListDetail&&orderid=<%= s[0] %>>order detail</a>
	   </td>
	   <td align="center"><%= s[5] %></td>
	</tr><%}%>
   </table>
   <%}%>
 <center><a href="index.jsp">return</a></center
 </div>

 </body>
</html>