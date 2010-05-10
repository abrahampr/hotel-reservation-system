<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Add group</title>
        <link href="css/styleHRS.css" type="text/css" rel="stylesheet">
        <script language="JavaScript" type="text/javascript">
            function check()
            {
                if(document.addGroup.groupname.value=="")
                {
                    alert("group name is null!");
                    addGroup.groupname.focus();
                    return false;
                }
                if(document.addGroup.groupimage.value=="")
                {
                    alert("URL is NULL");
                    addGroup.groupimage.focus();
                    return false;
                }
                if(document.addGroup.groupdetails.value=="")
                {
                    alert("details is NULL");
                    addGroup.groupdetails.focus();
                    return false;
                }
                if(document.addGroup.grouprules.value=="")
                {
                    alert("rules is NULL!");
                    addGroup.grouprules.focus();
                    return false;
                }
                document.addGroup.submit();
            }
        </script>
    </head>
    <body>
        <div align="center">
            <fieldset>
                <%              //   Vector<String> groupinfo =
              // 	 (Vector<String>)request.getAttribute("groupinfo");
%>
                <legend>
                    please input correct information
                </legend>
                <table border="0">
                    <form name="addGroup" action="listserv" method="post">
                        <tr>
                            <td id="label">group name:</td>
                            <td><input type="text" name="groupname"></td>
                        </tr>

                        <tr>
                            <td id="label">image url:</td>
                            <td><input type="text" name="groupimage"></td>
                        </tr>

                        <tr>
                            <td id="label">detail:</td>
                            <td>
                                <textarea rows=6 cols=50 name="groupdetails"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td id="label">rule:</td>
                            <td>
                                <textarea rows=6 cols=50 name="grouprules"></textarea>
                            </td>
                        </tr>
                        <tr><td></td>
                            <td>
                                <input type="hidden" name="action" value="addGroup">
                                <input type="submit" value="add" onclick="check()">
                                <input type="reset" value="reset">
                                <label>
                                    <input type="button" name="back" id="back" value="back" onclick="window.location.href='index.jsp'">
                                </label></td>
                        </tr>
                    </form>
                </table></fieldset></div>
    </body>
</html>
