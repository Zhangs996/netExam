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
	<title>在线考试星修改试题</title>
	<!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->
	<base href="<%=basePath%>">
	<link href="css/menu.css" rel="stylesheet" type="text/css">
	<link href="css/create_judge.css" rel="stylesheet" type="text/css">

	<script src="js/edit_judge.js" type="text/javascript"></script>
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
		
	<div class="create-judge-form">
		
		<div class="header">
			<p>
			修改判断题
			</p>
		</div>
		<div class="message">
			<p>
			</p>
		</div>
		<form id="submit_judge" action="edit_judge" method="post">
			<input type="hidden" name="judge.id" value="${judge.id }">
			<input type="hidden" name="judge.joinTime" value="${judge.joinTime }">
			
			<input type="hidden" id="lesson_name" value="${judge.lesson.name }" >
			<input type="hidden" id="level_name" value="${judge.level }" >
			<input type="hidden" id="answer_name" value="${judge.answer }" >
			<div class="lesson-select">
				<img src="img/选择课程.png"/>
				<select onchange="lesson_change(this)" onblur="lesson_select(this)" id="lesson" name="judge.lesson.name">
					<option value="" disabled selected hidden>请选择课程</option>
					<c:forEach var="lesson_name" items="${lesson_names }">
						<option style="color:#000000" value="${lesson_name }">${lesson_name }</option>
					</c:forEach>
				</select>
				<label id="lesson_error"></label>
			</div>
			<div class="level-select">
				<img src="img/难度指数.png"/>
				<select onchange="level_change(this)" onblur="level_select(this)" id="level" name="judge.level">
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
				<img src="img/neirong.png"/>
                <input onchange="question_change(this)" type="text" id="question" name="judge.question"  value="${judge.question}"placeholder="题目内容" maxlength="40"/>
                <label id="question_error"></label>
			</div>
            <div class="level-select">
				<img src="img/xuanxiang.png"/>
				<select onchange="answer_change(this)" onblur="answer_select(this)" id="answer" name="judge.answer" >
					<option value="" disabled selected hidden>请选择答案</option>
					<option>正确</option>
					<option>错误</option>
				</select>
				<script type="text/javascript">
					function display_answer(option){
					document.getElementById("answer").style.color="#000000";
					var all_options_answer = document.getElementById("answer").options;
					for (i=0; i<all_options_answer.length; i++) {
						if (all_options_answer[i].value == option) {  
							all_options_answer[i].selected = true;
						}
					}
					
				};
				display_answer(document.getElementById("answer_name").value);
				</script>
				<label id="answer_error" ></label>
			</div>
		</form>
		<div class="submit">
			<input onclick="submit()" type="button" value="修改" >
			<label id="submit_error"></label>
		</div>
		<div class="return">
			<input onclick="location='manager_judge.servlet?condition='" type="button" value="返回"/>
		</div>
	</div>
</div>
</body>
</html>