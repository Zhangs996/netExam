<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!-- 获取服务器url -->
<%
String path = request.getContextPath(); //  path = "/travel"
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; // basePath="http://localhost:8080/travel/"
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>线上考试星登录</title>
    <!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->    
    <base href="<%=basePath%>">
    <link href="css/login.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">a {text-decoration: none}</style>
    <script type="text/javascript" src="js/login.js"></script>
</head>
<body>
    <div class="login-wrap"></div>
    <div class="login-content-wrap">
        <div class="login-content">
        	<div class="login-form">
            	<form id="submit_student" name="" action="student_login" method="post">
	                <div class="login-title">
	                    <p>
	                       	 线上考试星登录
	                    </p>
	                </div>
	                <div class="login-username">
	                    <img src="img/username.png"/>
	                    <input  type="text" id="id" name="id" placeholder="考生号或身份证号" maxlength="18" onchange="check_id()">
	                </div>
	                <div class="login-password">
	                    <img src="img/password.png"/>
	                    <input  type="password" id="password" name="student.pwd" placeholder="密码" maxlength="16" onchange="check_pwd()">
	                </div>
           		</form>
            	<div class="login-forget">
                    <a href="jsp/forgetPassword.jsp" style="position: absolute;top: 0;right: 12%;">
                        	忘记密码
                    </a>
                </div>
                <div class="login-button">
                    <input type="button" id="login" onclick="submit_student()" name="login" value="登录">
                </div>
                <div class="login-message">
                    <span id="message">
                        ${message}
                    </span>
                </div>
                <div class="login-register">
                    <a href="jsp/register.jsp" style="position: absolute;top: 0;left: 0;">
                        	考生注册
                    </a>
                    <a href="jsp/manager_login.jsp" style="position: absolute;top: 0;right: 12%;">
                        	进入后台
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>