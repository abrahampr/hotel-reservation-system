<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link href="css/styleHRS.css" type="text/css" rel="stylesheet">
        <script language="JavaScript" type="text/javascript">
            function checkinformation(){
                if(document.reg.username.value==""){
                    alert("plase input your username!");
                    reg.username.focus();
                    return false;
                }
                if(document.reg.username.value.indexOf(" ")!=-1 || document.reg.password.value.indexOf(" ")!=-1){
                    alert("no space value!");
                    reg.password.focus();
                    return false;
                }
                if(document.reg.username.value.length<5 || document.reg.username.value.length>10){
                    alert("username must larger than 5 and smaller than 10");
                    reg.username.focus();
                    return false;
                }
                if(document.reg.password.value.length<6 || document.reg.password.value.length>12){
                    alert("password must larger than 6 and smaller than 12!");
                    reg.password.focus();
                    return false;
                }
                if(document.reg.password.value==""){
                    alert("please input your password!");
                    reg.password.focus();
                    return false;
                }
                if(document.reg.password.value!=document.reg.confirmpassword.value){
                    alert("confirm password is different!");
                    reg.password.focus();
                    return false;
                }
                if(document.reg.realname.value==""){
                    alert("please input your real name!");
                    reg.realname.focus();
                    return false;
                }
                if(document.reg.email.value==""){
                    alert("please input your email address!");
                    reg.email.focus();
                    return false;
                }
                var emailcheck1=document.reg.email.value.charAt(0)==".";
                var emailcheck2=document.reg.email.value.charAt(0)=="@";
                var emailcheck3=document.reg.email.value.charAt(document.reg.email.value.length-1)==".";
                var emailcheck4=document.reg.email.value.charAt(document.reg.email.value.length-1)=="@";
                var emailcheck5=document.reg.email.value.indexOf(".")==document.reg.email.value.lastIndexOf(".");
                var emailcheck6=document.reg.email.value.indexOf("@")==document.reg.email.value.lastIndexOf("@");
                var emailcheck7=document.reg.email.value.indexOf(".")==-1;
                var emailcheck8=document.reg.email.value.indexOf("@")==-1;
                if(emailcheck1||emailcheck2||emailcheck3||emailcheck4||!emailcheck5||!emailcheck6||emailcheck7||emailcheck8){
                    alert("invalid email address");
                    reg.email.focus();
                    return false;
                }
                if(document.reg.telephone.value==""){
                    alert("please input yoru telephone number");
                    reg.telephone.focus();
                    return false;
                }
                document.reg.submit();
            }
        </script>
    </head>
    <body>
        <div align="center">
            <div id="widthdiv">
                <fieldset><legend>Create your account</legend>
                    <table width="200" border="0">
                        <form name="reg" action="regserv" method="post">
                            <tr>
                                <td id="label">Username: </td>
                                <td><label>
                                        <input type="text" name="username" id="username">
                                    </label></td>
                            </tr>
                            <tr>
                                <td id="label">Password:</td>
                                <td><label>
                                        <input type="password" name="password" id="password">
                                    </label></td>
                            </tr>
                            <tr>
                                <td id="label"> Confrim Password:</td>
                                <td><label>
                                        <input type="password" name="confirmpassword" id="confirmpassword">
                                    </label></td>
                            </tr>
                            <tr>
                                <td id="label">Real name:</td>
                                <td><label>
                                        <input type="text" name="realname" id="realname">
                                    </label></td>
                            </tr>
                            <tr>
                                <td id="label">Gender:</td>
                                <td><label>
                                        <select name="gender" id="gender">
                                            <option value="male">male</option>
                                            <option value="female">female</option>
                                        </select>
                                    </label></td>
                            </tr>
                            <tr>
                                <td id="label">E-mail:</td>
                                <td><label>
                                        <input type="text" name="email" id="email">
                                    </label></td>
                            </tr>
                            <tr>
                                <td id="label">Telephone:</td>
                                <td><label>
                                        <input type="text" name="telephone" id="telephone" >
                                    </label></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td><label>
                                        <input type="hidden" name="action" value="reg">
                                        <input type="submit" name="submit" id="submit" value="submit" onclick="return checkinformation()">
                                        <input type="button" name="back" id="back" value="back" onclick="window.location.href='index.jsp'">
                                    </label></td>
                            </tr>
                        </form>
                    </table></fieldset></div>
        </div>
        <h1>&nbsp;</h1>
    </body>
</html>
