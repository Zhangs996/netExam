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
	<title>在线考试星添加试题</title>
	<!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->
	<base href="<%=basePath%>">
	<link href="css/menu.css" rel="stylesheet" type="text/css">
	<link href="css/create_judge.css" rel="stylesheet" type="text/css">
	<script src="js/create_judge.js" type="text/javascript"></script>
	<script src="js/jquery-3.3.1.js"></script>
	<script src="js/layer/layer.js"></script>
	<style type="text/css">
	a {
		text-decoration: none
	}
	</style>
</head>
<body>
<div class="content">
	 
	<!-- 考试可选择的课程名集合 -->
	<c:set var="lesson_names" value="${lesson_names}"/>
	
	<input type="hidden" id="to_page" value="<%=request.getParameter("to_page")%>">
	<div class="create-judge-form">
		<div class="header">
			<p>
			添加判断题
			</p>
		</div>
		<div class="message">
			<p>
			</p>
		</div>
		<form id="submit_judge" action="create_judge" method="post">
			<div class="lesson-select">
				<img src="img/选择课程.png"/>
				<select onchange="lesson_change(this)" onblur="lesson_select(this)" id="lesson" name="judge.lesson.name" >
					<option value="" disabled selected hidden>请选择课程</option>
					<c:forEach var="lesson_name" items="${lesson_names }">
						<option style="color:#000000">${lesson_name }</option>
					</c:forEach>
				</select>
				<label id="lesson_error"></label>
			</div>
			<div class="level-select">
				<img src="img/难度指数.png"/>
				<select onchange="level_change(this)" onblur="level_select(this)" id="level" name="judge.level" >
					<option value="" disabled selected hidden>请选择试题难度</option>
					<option>简单</option>
					<option>中等</option>
					<option>困难</option>
				</select>
				<label id="level_error" ></label>
			</div>
			<div class="text">
				<img src="img/neirong.png"/>
                <input onchange="question_change(this)" type="text" id="question" name="judge.question" placeholder="题目内容" maxlength="40"/>
                <label id="question_error"></label>
			</div>
			<div class="level-select">
				<img src="img/xuanxiang.png"/>
				<select onchange="answer_change(this)" onblur="answer_select(this)" id="answer" name="judge.answer" >
					<option value="" disabled selected hidden>请选择答案</option>
					<option>正确</option>
					<option>错误</option>
				</select>
				<label id="answer_error" ></label>
			</div>
		</form>
		<div class="submit">
			<input onclick="submit()" type="button" value="添加" >
			<label id="submit_error"></label>
		</div>
		<div class="return">
			<input onclick="return_home()" type="button" value="返回"/>
		</div>
	</div>
</div>
</body>
</html>