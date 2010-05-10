<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add admin</title>
        <link href="css/styleHRS.css" type="text/css" rel="stylesheet">
        <script language="javascript" type="text/javascript">
            function checkadminreg(){
                if(document.adminadd.adminusername.value=="")
                {
                    alert("please input the admin username.");
                    adminadd.adusername.focus();
                    return false;
                }

                if(document.adminadd.adminusername.value=="")
                {
                    alert("please input the admin password.");
                    adminadd.adminpassword.focus();
                    return false;
                }
                document.adminadd.submit();
            }
        </script>
    </head>
    <body>
        <div align="center">
            <fieldset>
                <legend align="left">Create admin account：</legend>
                <table><form name="adminadd" action="adminaddserv" method="post">
                        <tr>
                            <td id="label">admin username:</td>
                            <td><label>
                                    <input type="text" name="adminusername" id="adminusername">
                                </label></td>
                        </tr>
                        <tr>
                            <td id="label">admin password:</td>
                            <td><label>
                                    <input type="password" name="adminpassword" id="adminpassword">
                                </label></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td><label>
                                    <input type="hidden" name="action" value="adminadd">
                                    <input type="submit" name="submit" id="submit" value="submit" onclick="checkadminreg()">
                                    <input type="button" name="back" id="back" value="back" onclick="window.location.href='adminmanage.jsp'">
                                </label></td>
                        </tr></form>

                </table></fieldset>
        </div>

    </body>
</html>
