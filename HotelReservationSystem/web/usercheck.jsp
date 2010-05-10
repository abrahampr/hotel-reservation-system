<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>check</title>
    </head>
    <body><div align="center">
            <% //get the msg attribute and shows 
                        String message = (String) request.getAttribute("msg");
                        if (message != null) {
                            out.println(message);
                        }
            %></div>
    </body>
</html>
