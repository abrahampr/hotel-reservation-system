<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit admin</title>
        <link href="css/styleHRS.css" type="text/css" rel="stylesheet">
        <script language="javascript" type="text/javascript">
            function checkadmininformation() {
                if(document.adminedit.adminusername.value=="")
                {
                    alert("please input admin username");
                    adminedit.adminusername.focus();
                    return false;
                }
                if(document.adminedit.adminoldpassword.value=="")
                {
                    alert("please input admin old password");
                    adminedit.adminoldpassword.focus();
                    return false;
                }
                if(document.adminedit.adminnewpassword.value=="")
                {
                    alert("please input admin new password");
                    adminedit.adminoldpassword.focus();
                    return false;
                }
                document.adminedit.submit();
            }
        </script>
    </head>
    <body>
        <div align="center"><fieldset><legend>Edit admin accout</legend>
                <table>
                    <form name="adminedit" action="admineditserv" method="post">
                        <tr>
                            <td id="label">admin username:</td>
                            <td><label>
                                    <input type="text" name="adminusername" id="adminusername">
                                </label></td>
                        </tr>
                        <tr>
                            <td id="label">admin old password:</td>
                            <td><label>
                                    <input type="password" name="adminoldpassword" id="adminoldpassword">
                                </label></td>
                        </tr>
                        <tr>
                            <td id="label">admin new password:</td>
                            <td><label>
                                    <input type="password" name="adminnewpassword" id="adminnewpassword">
                                </label></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><label>
                                    <input type="hidden" name="action" value="adminedit">
                                    <input type="submit" name="submit" id="submit" value="submit" onclick="return checkadmininformation()">
                                    <input type="button" name="back" id="back" value="back" onclick="window.location.href='index.jsp'">
                                </label></td>
                        </tr></form>
                </table></fieldset>
        </div>

    </body>
</html>
