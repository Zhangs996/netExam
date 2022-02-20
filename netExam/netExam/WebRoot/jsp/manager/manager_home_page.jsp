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
    <title>在线考试星管理员首页</title>
    <!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->    
    <base href="<%=basePath%>">
    <link href="css/menu.css" rel="stylesheet" type="text/css">
    <script src="js/jquery-3.3.1.js"></script>
	<script src="js/layer/layer.js"></script>
    <style type="text/css">a {text-decoration: none}</style>
</head>
<body>
<!-- loading -->
<div class="viewFrameWork-body" width=100%>
	<div class="body-wrapper">
	    <div class="body-content">
	        <div class="page_wrapper">
	 			<div class="quick-start-wrapper clearfix">
					<a class="item-wrapper" href="list_select_course?to_page=home" data-growing-title="item-add-exam">
					    <div class="item item-add-exam animate">
					        <div class="icon">
					            <img src="img/a_create_tests.png">
					        </div>
					        <div class="title">创建考试</div>
					        <div class="intro">可创建新考试</div>
					    </div>
					</a>
					<a class="item-wrapper" href="list_select_course_for_question?to_page=home" data-growing-title="item-add-question">
					    <div class="item item-add-question animate">
					        <div class="icon">
					            <img src="img/a_add_test_questions.png">
					        </div>
					        <div class="title">添加选择题</div>
					        <div class="intro">完善您的选择题库</div>
					    </div>
					</a>
					
					<a class="item-wrapper" href="list_select_course_for_judge?to_page=home" data-growing-title="item-add-user">
					    <div class="item item-add-user animate">
					        <div class="icon">
					            <img src="img/a_add_people.png">
					        </div>
					        <div class="title">添加判断题</div>
					        <div class="intro">完善您的判断题库</div>
					    </div>
					</a>
					
					<a class="item-wrapper" href="jsp/manager/manager_add_lesson.jsp?to_page=home" data-growing-title="item-add-course">
					    <div class="item item-add-course animate">
					        <div class="icon">
					            <img src="img/a_createz_courses.png">
					        </div>
					        <div class="title">创建课程</div>
					        <div class="intro">填写课程相关信息</div>
					    </div>
					</a>
				</div>
	        </div>
	    </div>
	</div>
</div>
</body>
</html>