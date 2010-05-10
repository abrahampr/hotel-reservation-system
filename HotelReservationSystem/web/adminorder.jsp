<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
   <title>manage order</title>
      <link href="css/styleHRS.css" type="text/css" rel="stylesheet">
   <script language="JavaScript" type="text/javascript">
    function check()
    {
       if(document.searchorder.orderid.value=="")
       {
         alert("please input the order ID");
         searchorder.orderid.focus();
         return false;
       }
       document.searchorder.submit();
    }
   </script>
  </head>
 <body><div align="center">
   <br>
   <table>
    <tr>
       <td><a href=orderserv?action=allOrders&&condition=1>All of the order</a></td>
	   <td><a href=orderserv?action=allOrders&&condition=2>excuted</a></td>
	   <td><a href=orderserv?action=allOrders&&condition=3>not accept yet</a></td>

	   <td>order ID:
            <form name="searchorder" action="orderserv" method="post">
	    <input type="hidden" name="action" value="searchOrder">
	    <input type="text" name="orderid">
	    <input type="button" value="search" onclick="check()">
            </form>

	   </td>
	  </tr>

   </table><br>
	   <% //get the order list, if null then display no order
           Vector<String[]> order =
          (Vector<String[]>)request.getAttribute("order");
       if(order==null||order.size()==0){
	     out.println("<center>");
	     out.println("<font>no order</font>");
	     out.println("<br><br><a href="+
	       "orderserv?action=allOrders&&condition=1>return</a></center>");
	    }
	    else{%>
   <table border="1">
	 <tr bgcolor="#999999">
	   <th id="thlabel">ID</th>
           <th id="thlabel">user</th>
           <th id="thlabel">submit time</th>
	   <th id="thlabel">status</th>
           <th id="thlabel">excute admin</th>
           <th id="thlabel">detail</th>
	   <th id="thlabel">PS</th>
           <th id="thlabel">excute order</th>
	 </tr>
	   <% //get the order information into array
	  	 for(int i=0;i<order.size();i++){
		   String[] s = order.get(i);%>

     <tr>
	   <td><%= s[0] %></td>
           <td><%= s[1] %></td>
	   <td><%= s[2] %></td>
           <td><%= s[4] %></td>
	   <td><%= s[3] %></td>
	   <td>
	    <a target="blank" href=orderserv?action=ListDetail&&orderid=<%= s[0] %>>order detail</a>
	   </td>
               <form action="orderserv" method="post">
	   <td>

	      <input type="text" name="reason" size="10" value=<%= s[5] %>>
	   </td><td align="center">
	     <select name="status">
	     <option selected>success</option>
	     <option>failed</option>
	     <option>waiting for apply</option>
	     </select>
	     <input type="hidden" name="action" value="dealOrder">
	     <input type="hidden" name="orderid" value=<%= s[0] %>>
	     <input type="submit" value="submit">

	   </td>
	   	</form>
	</tr> <%}%>
   </table><%}%>
   <input type="button" name="back" id="back" value="back" onclick="window.location.href='index.jsp'">
 </div>
 </body>
</html>