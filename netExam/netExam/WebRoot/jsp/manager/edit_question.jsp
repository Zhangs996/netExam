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
	<link href="css/create_question.css" rel="stylesheet" type="text/css">

	<script src="js/edit_question.js" type="text/javascript"></script>
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
		
	<div class="create-question-form">
		
		<div class="header">
			<p>
			修改选择题
			</p>
		</div>
		<div class="message">
			<p>
			输入的答案为大写字母如A/ABC/BC等
			</p>
		</div>
		<form id="submit_question" action="edit_question" method="post">
			<input type="hidden" name="question.id" value="${question.id }">
			<input type="hidden" name="question.joinTime" value="${question.joinTime }">
			
			<input type="hidden" id="lesson_name" value="${question.lesson.name }" >
			<input type="hidden" id="level_name" value="${question.level }" >
			<input type="hidden" id="type_name" value="${question.type }" >
			<div class="lesson-select">
				<img src="img/选择课程.png"/>
				<select onchange="lesson_change(this)" onblur="lesson_select(this)" id="lesson" name="question.lesson.name">
					<option value="" disabled selected hidden>请选择课程</option>
					<c:forEach var="lesson_name" items="${lesson_names }">
						<option style="color:#000000" value="${lesson_name }">${lesson_name }</option>
					</c:forEach>
				</select>
				<label id="lesson_error"></label>
			</div>
			<div class="level-select">
				<img src="img/难度指数.png"/>
				<select onchange="level_change(this)" onblur="level_select(this)" id="level" name="question.level">
					<option value="" disabled selected hidden>请选择考试难度</option>
					<option value="简单">简单</option>
					<option value="中等">中等</option>
					<option value="困难">困难</option>
				</select>
				<label id="level_error" ></label>
			</div>
			<div class="level-select">
				<img src="img/xuanxiang.png"/>
				<select onchange="type_change(this)" onblur="type_select(this)" id="type" name="question.type" >
					<option value="" disabled selected hidden>请选试题类型</option>
					<option>单选题</option>
					<option>多选题</option>
				</select>
				<label id="type_error" ></label>
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
				function display_type(option){
					document.getElementById("type").style.color="#000000";
					var all_options_type = document.getElementById("type").options;
					for (i=0; i<all_options_type.length; i++) {
						if (all_options_type[i].value == option) {  
							all_options_type[i].selected = true;
						}
					}
					
				};
				
				display_lesson(document.getElementById("lesson_name").value);
				display_level(document.getElementById("level_name").value);
				display_type(document.getElementById("type_name").value);
			</script>
			<div class="text">
				<img src="img/neirong.png"/>
                <input onchange="question_change(this)" type="text" id="question" name="question.question"  value="${question.question}"placeholder="题目内容" maxlength="40"/>
                <label id="question_error"></label>
			</div>
			<div class="text">
				<img src="img/A.png"/>
                <input onchange="optionA_change(this)" type="text" id="optionA" name="question.optionA"  value="${question.optionA}"placeholder="选项A" maxlength="40"/>
                <label id="optionA_error"></label>
			</div>
			<div class="text">
				<img src="img/B.png"/>
                <input onchange="optionB_change(this)" type="text" id="optionB" name="question.optionB"  value="${question.optionB}"placeholder="选项B" maxlength="40"/>
                <label id="optionB_error"></label>
			</div>
			<div class="text">
				<img src="img/C.png"/>
                <input onchange="optionC_change(this)" type="text" id="optionC" name="question.optionC"  value="${question.optionC}"placeholder="选项C" maxlength="40"/>
                <label id="optionC_error"></label>
			</div>
			<div class="text">
				<img src="img/D.png"/>
                <input onchange="optionD_change(this)" type="text" id="optionD" name="question.optionD"  value="${question.optionD}"placeholder="选项D" maxlength="40"/>
                <label id="optionD_error"></label>
			</div>
			<div class="text">
				<img src="img/answer.png"/>
                <input onchange="answer_change(this)" type="text" id="answer" name="question.answer"  value="${question.answer}"placeholder="答案" maxlength="4"/>
                <label id="answer_error"></label>
			</div>
		</form>
		<div class="submit">
			<input onclick="submit()" type="button" value="修改" >
			<label id="submit_error"></label>
		</div>
		<div class="return">
			<input onclick="location='manager_question.servlet?condition='" type="button" value="返回"/>
		</div>
	</div>
</div>
</body>
</html>