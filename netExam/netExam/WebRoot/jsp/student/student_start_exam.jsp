<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <title>在线考试星</title>
    <!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->    
    <base href="<%=basePath%>">
    <style type="text/css">a {text-decoration: none}</style>
    <link href="css/student_start_exam.css" rel="stylesheet" type="text/css">
    
    <script src="js/student_start_exam.js" type="text/javascript"></script>
    <script src="js/jquery-3.3.1.js"></script>
	<script src="js/layer/layer.js"></script>
</head>
<body style="">
<div class="div-header">
	<input type="hidden" id="submit_status" value="未提交">
	<div class="div-exam-name">
		<input type="hidden" id="exam_id" value=${exam_id }>
		<p>
			考试科目：${exam.lesson.name }
		</p>
	</div>
	<div class="div-exam-durtion">
		<input type="hidden" id="duration" value="${exam.duration }">
		<table>
			<tr>
				<td class="durtion-title-td">考试时长：</td>
				<td class="duration-td" style="color:#00FF00">${exam.duration }mins</td>
				<td id="td1" class="surplus-title-td">考试剩余：</td>
				<td id="td2" class="surplus-title" style="color:#FF4500">
					<label id="hour"></label>:<label id="minute"></label>:<label id="second"></label>
				</td>
				<td class="submit-td">
					<a id="submit-a" onclick="c_submit(${exam.id})">
						<button id="submit" class="button-submit" >提交</button>
					</a>
				</td>
			</tr> 
		</table>
	</div>
</div>
<c:set var="exam_id" value="${exam.id }" scope="session"/>
<c:set var="singles" value="${single }" scope="session"/>
<c:set var="singlesNum" value="${exam.singleNum }" scope="session"/>
<c:set var="singlesScore" value="${score[0] }" scope="session"/>

<c:set var="mores" value="${multi }" scope="session"/>
<c:set var="moresNum" value="${exam.moreNum }" scope="session"/>
<c:set var="moresScore" value="${score[1] }" scope="session"/>

<c:set var="judges" value="${judge }" scope="session"/>
<c:set var="judgesNum" value="${exam.judgeNum }" scope="session"/>
<c:set var="judgesScore" value="${score[2] }" scope="session"/>

<div class="div-content-iframe"> 
	<iframe class="iframe" id="iframe" name="iframe" frameborder="0" src="jsp/student/iframe_show_question.jsp" ></iframe>
</div>

</body>
</html>