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
	<title>在线考试星修改考试</title>
	<!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->
	<base href="<%=basePath%>">
	<link href="css/menu.css" rel="stylesheet" type="text/css">
	<link href="css/create_exam.css" rel="stylesheet" type="text/css">

	<script src="js/edit_exam.js" type="text/javascript"></script>
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
		
	<div class="create-exam-form">
		
		<div class="header">
			<p>
			修改考试
			</p>
		</div>
		<div class="message">
			<p>
			注：考试总分必须为100分
			</p>
		</div>
		<form id="submit_exam" action="edit_exam" method="post">
			<input type="hidden" name="exam.id" value="${exam.id }">
			<input type="hidden" name="exam.joinTime" value="${exam.joinTime }">
			<input type="hidden" name="exam.status" value="${exam.status }">
			
			<input type="hidden" id="lesson_name" value="${exam.lesson.name }" >
			<input type="hidden" id="level_name" value="${exam.level }" >
			
			<div class="lesson-select">
				<img src="img/选择课程.png"/>
				<select onchange="lesson_change(this)" onblur="lesson_select(this)" id="lesson" name="exam.lesson.name">
					<option value="" disabled selected hidden>请选择课程</option>
					<c:forEach var="lesson_name" items="${lesson_names }">
						<option style="color:#000000" value="${lesson_name }">${lesson_name }</option>
					</c:forEach>
				</select>
				<label id="lesson_error"></label>
			</div>
			<div class="level-select">
				<img src="img/难度指数.png"/>
				<select onchange="level_change(this)" onblur="level_select(this)" id="level" name="exam.level">
					<option value="" disabled selected hidden>请选择考试难度</option>
					<option value="简单">简单</option>
					<option value="中等">中等</option>
					<option value="困难">困难</option>
				</select>
				<label id="level_error" ></label>
			</div>
			
			<script type="text/javascript">
				function display_lesson(option){
					document.getElementById("lesson").style.color="#000000";
					var all_options_lesson = document.getElementById("lesson").options;
					for (i=0; i<all_options_lesson.length; i++) {
						if (all_options_lesson[i].value == option) {  
						
							all_options_lesson[i].selected = true;
						}
					}
					
				};
				function display_level(option){
					document.getElementById("level").style.color="#000000";
					var all_options_level = document.getElementById("level").options;
					for (i=0; i<all_options_level.length; i++) {
						if (all_options_level[i].value == option) {  
							all_options_level[i].selected = true;
						}
					}
					
				};
				
				display_lesson(document.getElementById("lesson_name").value);
				
				display_level(document.getElementById("level_name").value);
			</script>
			<div class="text">
				<img src="img/单选题.png"/>
                <input onchange="singleNum_change(this)" type="text" id="singleNum" name="exam.singleNum" value="${exam.singleNum}" placeholder="单选题道数" maxlength="4"/>
                <label id="singleNum_error"></label>
			</div>
			<div class="text">
				<img src="img/分数.png"/>
                <input onchange="singleScore_change(this)" type="text" id="singleScore" name="exam.singleScore" value="${exam.singleScore}" placeholder="每道单选题分数" maxlength="4"/>
                <label id="singleScore_error"></label>
			</div>
			<div class="text">
				<img src="img/多选题.png"/>
                <input onchange="moreNum_change(this)" type="text" id="moreNum" name="exam.moreNum" value="${exam.moreNum}" placeholder="多选题道数" maxlength="4"/>
                <label id="moreNum_error"></label>
			</div>
			<div class="text">
				<img src="img/分数.png"/>
                <input onchange="moreScore_change(this)" type="text" id="moreScore" name="exam.moreScore" value="${exam.moreScore}" placeholder="每道多选题分数" maxlength="4"/>
                <label id="moreScore_error"></label>
			</div>
			<div class="text">
				<img src="img/判断题.png"/>
                <input onchange="judgeNum_change(this)" type="text" id="judgeNum" name="exam.judgeNum" value="${exam.judgeNum}" placeholder="判断题道数" maxlength="4"/>
                <label id="judgeNum_error"></label>
			</div>
			<div class="text">
				<img src="img/分数.png"/>
                <input onchange="judgeScore_change(this)" type="text" id="judgeScore" name="exam.judgeScore" value="${exam.judgeScore}" placeholder="每道判断题分数" maxlength="4"/>
                <label id="judgeScore_error"></label>
			</div>
			<div class="text">
				<img src="img/时长.png"/>
                <input onchange="duration_change(this)" type="text" id="duration" name="exam.duration" value="${exam.duration}" placeholder="考试时长(min)" maxlength="4"/>
                <label id="duration_error"></label>
			</div>
		</form>
		<div class="submit">
			<input onclick="submit()" type="button" value="修改" >
			<label id="submit_error">${message }</label>
		</div>
		<div class="return">
			<input type="button" onclick="location='manager_exam_message.servlet?condition='" value="返回">
		</div>
	</div>
</div>
</body>
</html>