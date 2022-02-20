<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri= "/struts-tags" %>
<!-- 获取服务器url -->
<%
	String path = request.getContextPath(); //  path = "/travel"
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/"; // basePath="http://localhost:8080/travel/"
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>线上考试星忘记密码</title>
      <!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->    
	<base href="<%=basePath%>">
	<style type="text/css">a {text-decoration: none}</style>
    <link rel="stylesheet" href="css/forgetPassword.css">
    <script type="text/javascript" src="js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="js/jquery.cookie.js"></script>
    <script type="text/javascript" src="js/forgetPassword.js"></script>
    <script type="text/javascript">
    	function myReload() {
    		document.getElementById("CreateCheckCode").src = document
    			.getElementById("CreateCheckCode").src
    		+ "?nocache=" + new Date().getTime();
    	}
    </script>
</head>
<body>
	<div class="wrapper">
		<div class="panel-block">
		    <div class="title ellipsis">重置密码</div>
		    	<form id="queryForm" method="post" action="getPassword" onSubmit="return getPassword()" enctype="multipart/form-data">
					<div class="items">
		 				<div class="item item-input item-account">
		        			<input id="tel" name="student.tel" class="input" type="text" placeholder="请输入手机号码" onblur="oBlur_1();">
						</div>
						<div class="item item-input item-phone">
		    				<input name="student.pwd" class="input" type="password" id ="password" placeholder="请输入新密码" onblur="oBlur_3()">
						</div>
						<div class="item item-input item-phone">
		    				<input name="verifyPassword" class="input" type="password" id="verifyPassword" placeholder="确认密码" onblur="oBlur_4()">
		 				</div>
						<div class="item item-input item-phone">
		     				<input name="vCode" class="input" type="text" placeholder="请输入手机验证码" onblur="oBlur_2();">
							<button  id="getVCode" type="button" onclick="sendVCode();">获取验证码</button>
						</div>
						<div class="item item-input item-captcha">
		    				<span class="required">*</span>
						<input name="captchaText" class="input" type="text" placeholder="图形验证码" onblur="oBlur_5();">
						<a href="javascript:CreateCheckCode.onclick()" onclick="myReload()"><img alt="" src="validateCode.servlet" id="CreateCheckCode"/>  看不清,换一个</a>
		    		</div>
				</div>
		 		<div class="footer-row">
					<span class="error-info" id="errorInfo">
						${message }
					</span>
		        	<input class="btn btn-primary disabled" id="findPwdBtn" type="submit"  value="确认修改"></input>
		        	<input style="position:absolute;right:50px;" class="btn btn-primary" id="" type="button" onclick="location='/netExam/jsp/login.jsp'" value="返回登录"></input>
		    	</div>
		    </form>
		</div>
	</div>
</body>
</html>