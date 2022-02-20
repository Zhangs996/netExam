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
    <title>线上考试星管理员登录</title>
    <!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->    
    <base href="<%=basePath%>">
    <style type="text/css">a {text-decoration: none}</style>
    <link href="css/manager_login.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="js/manager_login.js"></script>
</head>
<body>
	<div class="login-wrap"></div>
	<div class="login-content-wrap">
	    <div class="login-content">
	    	<div class="login-form">
		        <form id="submit_manager" name="" action="manager_login" method="post">
		            <div class="login-title">
		                <p>
		                   线上考试星管理员登录
		                </p>
		            </div>
		            <div class="login-username">
		                <img src="img/manager.png"/>
		                <input  type="text" id="id" name="manager.id" placeholder="ID号" maxlength="18" onchange="check_id()">
		            </div>
		            <div class="login-password">
		                <img src="img/password.png"/>
		                <input  type="password" id="password" name="manager.pwd" placeholder="密码" maxlength="16" onchange="check_pwd()">
		            </div>
		            
			        </form>
			        <div class="login-button">
		                <input type="button" onclick="submit_manager()" id="manager_login" value="登录">
		            </div>
		            <div class="login-message">
		                    <span id="message">
		                        ${message}
		                    </span>
		            </div>
		            <div class="login-register">
	                    <a href="jsp/login.jsp" style="position: absolute;top: 0;right: 12%;">
	                        	返回学生登录
	                    </a>
	                </div>
	        </div>
	    </div>
	</div>
</body>
</html>