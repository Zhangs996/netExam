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
    <title>线上考试星注册</title>
    <!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->    
    <base href="<%=basePath%>">
    <style type="text/css">a {text-decoration: none}</style>
    <link href="css/register.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="js/register.js"></script>
</head>
<body>
    <div class="register-wrap"></div>
    <div class="register-content-wrap">
        <div class="register-content">
        	<div class="register-form">
	            <form id="submit_register" name="" action="student_register">
	                <div class="register-title">
	                    <p>
	                        线上考试星注册
	                    </p>
	                </div>
	                <div class="register-username">
	                    <img src="img/username.png"/>
	                    <input  type="text" id="username" name="student.name" placeholder="姓名" maxlength="10" onchange="check_username()">
	                </div>
	                <div class="register-idcard">
	                    <img src="img/idcard.png"/>
	                    <input  type="text" id="cardid" name="student.cardNo" placeholder="身份证号码" maxlength="18" onchange="check_cardid()">
	                </div>
	                <div class="register-tel">
	                    <img src="img/tel.png"/>
	                    <input  type="text" id="tel" name="student.tel" placeholder="手机号" maxlength="11" onchange="check_password()">
	                </div>
	                <div class="register-password">
	                    <img src="img/password.png"/>
	                    <input  type="password" id="password" name="student.pwd" placeholder="密码" maxlength="16" onchange="check()">
	                </div>
	                <div class="register-password1">
	                    <img src="img/password.png"/>
	                    <input  type="password" id="password1" name="" placeholder="确认密码" maxlength="16" onchange="check_password1()">
	                </div>
	                <div class="register-sex">
	                    <img src="img/sex.png"/>
	                    <select id="sex" name="student.sex" >
	                        <option>男</option>
	                        <option>女</option>
	                    </select>
	                </div>
	                <div class="register-profession">
	                    <img src="img/profession.png"/>
	                    <select id="profession" name="student.profession" >
	                        <option>电子信息工程</option>
	                        <option>通信工程</option>
	                        <option>电子信息科学与技术</option>
	                        <option>自动化</option>
	                        <option>计算机科学与技术</option>
	                        <option>网络工程</option>
	                        <option>教育技术学</option>
	                        <option>电气工程及其自动化</option>
	                    </select>
	                </div>
	            </form>
	            <div class="register-message">
	                 <span id="message">
	                 	${message}
	                 </span>
	             </div>
	             <div class="register-button">
	                 <input type="button" onclick="submit_register()" id="register" value="注册">
	             </div>
	             <div class="register-return">
	                 <a href="jsp/login.jsp">返回登录</a>
	             </div>
             </div>
        </div>
    </div>
</body>
</html>