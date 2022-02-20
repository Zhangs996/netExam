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
    <title>线上考试星注册成功</title>
    <!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->    
    <base href="<%=basePath%>">
    <style type="text/css">a {text-decoration: none}</style>
    <link href="css/register_success.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <div class="register-wrap"></div>
    <div class="register-content-wrap">
        <div class="register-content">
            <form class="register-form" name="" action="jsp/login.jsp" method="get">
                <div class="register-title">
                    <p>
                        注册成功！
                    </p>
                </div>
                <div class="register-success-img">
                </div>
                <div class="register-message">
                        <span id="message">
                            您的考生号：${message}
                        </span>
                </div>
                <div class="register-button">
                    <input type="submit" id="" value="去登录">
                </div>
            </form>
        </div>
    </div>
</body>
</html>