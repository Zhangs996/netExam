<%@page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- 获取服务器url -->
<%
String path = request.getContextPath(); //  path = "/travel"
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; // basePath="http://localhost:8080/travel/"
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>在线考试星首页</title>
    <!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->    
    <base href="<%=basePath%>">
    <link href="css/menu.css" rel="stylesheet" type="text/css">
    <script src="js/jquery.min.js?v=8101d596b257" type="text/javascript"></script>
    <script src="js/bootstrap.min.js?v=87d37353ad57" type="text/javascript"></script>
    <script src="js/admin-base.js?v=127797ede057" type="text/javascript"></script>
    <style type="text/css">a {text-decoration: none}
    .div{ 
    	margin:0 auto; 
    	width:400px; 
    	height:100px; 
    	border:1px solid #F00;
   	} 
    label {
    	width:100px;
    	display:inline-block;
    }
    </style>
</head>
<body>
<div style="background: url(img/zs2.jpg);height:1000px;width:100% " >
<div style="margin-left:40%;">
	    <br><br><br><br><br><br><br><br><br>
	        <label><font size="5" color="#483D8B">准考证号</font></label>
	        <font size="4" color="#009ACD">${student.id}</font>
	    <br><br>
	        <label><font size="5" color="#483D8B">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</font></label>
	        <font size="4" color="#009ACD">${student.name}</font>
	    <br><br>
	        <label><font size="5" color="#483D8B">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</font></label>
	        <font size="4" color="#009ACD">${student.sex}</font>
	    <br><br>
	        <label><font size="5" color="#483D8B">注册日期</font></label>
	        <font size="4" color="#009ACD">${student.joinTime}</font>
        <br><br>
	        <label><font size="5" color="#483D8B">专业名称</font></label>
	        <font size="4" color="#009ACD">${student.profession}</font>
	    <br><br>
	        <label><font size="5" color="#483D8B">身&nbsp;&nbsp;份&nbsp;&nbsp;证</font></label>
	        <font size="4" color="#009ACD">${student.cardNo}</font>

    </div>
    </div>
</body>
</html>