<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>edit group</title>
        <link href="CSS/styleHRS.css" type="text/css" rel="stylesheet">
        <script language="JavaScript" type="text/javascript">
            function check()
            {
                if(document.groInfo.newgroupname.value=="")
                {
                    alert("gourpname is NULL!!");
                    groInfo.newgroupname.focus();
                    return false;
                }
                if(document.groInfo.groupimage.value=="")
                {
                    alert("img is null");
                    groInfo.groupimage.focus();
                    return false;
                }
                if(document.groInfo.groupdetails.value=="")
                {
                    alert("details is null");
                    groInfo.groupdetails.focus();
                    return false;
                }
                if(document.groInfo.grouprules.value=="")
                {
                    alert("rules is null");
                    groInfo.grouprules.focus();
                    return false;
                }
                document.groInfo.action.value="changeGroup";
                document.groInfo.submit();
            }
        </script>
    </head>
    <body><div align="center"><fieldset>
                <%
                            Vector<String> groupinfo =
                                    (Vector<String>) request.getAttribute("groupinfo");
                %>
                <legend>
                    <%= groupinfo.get(1)%>infomation
                </legend>
                <table>
                    <form name="groInfo" action="listserv" method="post">
                        <tr>
                            <td id="label">groupname:</td>
                            <td><input type="text" name="newgroupname" value=<%= groupinfo.get(1)%>></td>
                        </tr>

                        <tr>
                            <td id="label">image url:</td>
                            <td><input type="text" name="groupimage" value=<%= groupinfo.get(4)%>></td>
                        </tr>

                        <tr>
                            <td id="label">details:</td>
                            <td>
                                <textarea rows=6 cols=50 name="groupdetails"><%= groupinfo.get(2)%></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td id="label">rule:</td>
                            <td>
                                <textarea rows=6 cols=50 name="grouprules"><%= groupinfo.get(3)%></textarea>
                            </td>
                        </tr>
                        <tr><td></td>
                            <td>
                                <input type="hidden" name="action" value="deleteGroup">
                                <input type="hidden" name="groupid" value=<%= groupinfo.get(0)%> >
                                <input type="hidden" name="oldgroupname" value=<%= groupinfo.get(1)%>>
                                <input type="button" value="save" onclick="return check()">
                                <input type="submit" value="delete">
                                <input type="button" name="back" id="back" value="back" onclick="window.location.href='adminroomgroup.jsp'"></td>
                        </tr>
                    </form>
                </table></fieldset></div>
    </body>
</html>