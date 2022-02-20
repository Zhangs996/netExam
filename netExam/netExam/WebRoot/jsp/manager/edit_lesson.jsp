<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- 获取服务器url -->
<%
	String path = request.getContextPath(); //  path = "/travel"
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/"; 
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>在线考试星修改课程</title>
	<!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->
	<base href="<%=basePath%>">
	<link href="css/menu.css" rel="stylesheet" type="text/css">
	<link href="css/add_lesson.css" rel="stylesheet" type="text/css">

	<script src="js/add_lesson.js" type="text/javascript"></script>
	<script src="js/jquery-3.3.1.js"></script>
	<script src="js/layer/layer.js"></script>
	
	<style type="text/css">
	a {
		text-decoration: none
	}
	</style>
</head>
<body >
<div class="content" style="background: url(img/create_exam.jpg); " >
	 
	<!-- 考试可选择的课程名集合 -->
	<c:set var="lesson_names" value="${lesson_names}"/>
	
	<div class="create-lesson-form">
		<div class="header">
			<p>
				修改课程
			</p>
		</div>
		<form id="submit_lesson" action="edit_lesson" method="post">
			<div class="text">
				<img src="img/添加课程.png"/>
				<input type="hidden" name="lesson.id" value="${lesson.id }"> 
				<input type="text" id="add_lesson"  name="lesson.name" value="${lesson.name}"  placeholder="课程名" onchange="lesson_name_change(this)" >
				<label id="lesson_error" ></label>
				<p style="color:red">${message}</p>
			</div>
		</form>
		<div class="submit">
			<input onclick="submit()" type="button" value="修改" >
			<label id="submit_error"></label>
		</div>
		<div class="return">
			<input onclick="location='manager_lesson_message.servlet?condition='" type="button" value="返回"/>
		</div>
	</div>
</div>
</body>
</html>