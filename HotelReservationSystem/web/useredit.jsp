<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edid your profile</title>
        <link href="css/styleHRS.css" type="text/css" rel="stylesheet">
        <script language="Javascript" type="text/javascript">
            function checkpassword(){
                if(document.useredit.oldpassword.value=="")
                {
                    alert("please input your current password!");
                    useredit.oldpassword.focus();
                    return false;
                }

                if(document.useredit.newpassword.value=="")
                {
                    alert("please input your new password!");
                    useredit.oldpassword.focus();
                    return false;
                }
            }
            function checkinformation(){
                var emailcheck1=document.useredit.email.value.charAt(0)==".";
                var emailcheck2=document.useredit.email.value.charAt(0)=="@";
                var emailcheck3=document.useredit.email.value.charAt(document.useredit.email.value.length-1)==".";
                var emailcheck4=document.useredit.email.value.charAt(document.useredit.email.value.length-1)=="@";
                var emailcheck5=document.useredit.email.value.indexOf(".")==document.useredit.email.value.lastIndexOf(".");
                var emailcheck6=document.useredit.email.value.indexOf("@")==document.useredit.email.value.lastIndexOf("@");
                var emailcheck7=document.useredit.email.value.indexOf(".")==-1;
                var emailcheck8=document.useredit.email.value.indexOf("@")==-1;
                if(emailcheck1||emailcheck2||emailcheck3||emailcheck4||!emailcheck5||!emailcheck6||emailcheck7||emailcheck8){
                    alert("invalid email address");
                    reg.email.focus();
                    return false;
                }
                if(document.useredit.telephone.value==""){
                    alert("please input yoru telephone number");
                    reg.telephone.focus();
                    return false;
                }
            }
        </script>
    </head>
    <body>
        <div align="center"><div id="widthdiv"><fieldset><legend>change your password</legend>
                    <table width="300" border="0">
                        <form name="changepassword" action="changepasswordserv" method="post">
                            <tr>
                                <td id="label">old password:</td>
                                <td><label>
                                        <input type="password" name="oldpassword" id="oldpassword">
                                    </label></td>
                            </tr>
                            <tr>
                                <td id="label">new password:</td>
                                <td><label>
                                        <input type="password" name="newpassword" id="newpassword">
                                    </label></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td><label>
                                        <input type="hidden" name="action" value="changepassword">
                                        <input type="submit" name="submit" id="submit" value="submit" onclick="return checkpassword()">
                                    </label></td>
                            </tr></form>
                    </table>
                </fieldset>
                <fieldset><legend>change your information</legend>
                    <table width="300" border="0">
                        <form name="changeinfo" action="changeinfoserv" method="post">
                            <tr>
                                <td id="label">real name:</td>
                                <td><label>
                                        <input type="text" name="realname" id="realname">
                                    </label></td>
                            </tr>
                            <tr>
                                <td id="label">gender:</td>
                                <td><label>
                                        <select name="gender" id="gender">
                                            <option>male</option>
                                            <option>female</option>
                                        </select>
                                    </label></td>
                            </tr>
                            <tr>
                                <td  id="label">email:</td>
                                <td><label>
                                        <input type="text" name="email" id="email">
                                    </label></td>
                            </tr>
                            <tr>
                                <td id="label">telephone:</td>
                                <td><label>
                                        <input type="text" name="telephone" id="telephone">
                                    </label></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>
                                    <label>
                                        <input type="hidden" name="action" value="changeinfo">
                                        <input type="submit" name="submit" id="submit" value="submit" onclick="return checkinformation()"></label>
                                    <label>
                                        <input type="button" name="back" id="back" value="back" onclick="window.location.href='index.jsp'">
                                    </label></td>
                            </tr></form>
                    </table></fieldset>
            </div>
        </div>

    </body>
</html>
