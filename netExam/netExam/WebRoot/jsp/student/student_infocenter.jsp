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
    <title>在线考试星个人信息</title>
    <!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->    
    <base href="<%=basePath%>">
    <script src="js/student_info.js" type="text/javascript"></script>
    <script src="js/jquery-3.3.1.js"></script>
	<script src="js/layer/layer.js"></script>
    <style type="text/css">
    body{
    background-color:white;}
   .img{
	background:url("img/信息.png") no-repeat 300px -80px;
	background-color:white;
	} 
.content{
	margin-left:100px;
	margin-top:10px;}
	p{
		font-family:"Times New Roman", Times, serif;
		font-size:24px;}
	.info{
		margin-left:5px;}
	h1{
		font-size:36px;
		color: #0F0;
		letter-spacing: 0;
		text-shadow: 0px 1px 0px #999, 0px 2px 0px #888, 0px 3px 0px #777, 0px 4px 0px #666, 0px 5px 0px #555, 0px 6px 0px #444, 0px 7px 8px #333, 0px 8px 7px #001135
	}
	a{
	
	font-family: "Times New Roman", Times, serif;
	font-size: 24px;}
	#a{
	
	margin-left:400px}

</style>
</head>
<body >
   
   <div class="img" >
   <div class="content">
   <h1>学生信息</h1>
   <form id="submit_jump" action="student_jump" method="post">
   <p>
    姓名:
    <span class="info">${student.name}</span>
    </p>
   <p>
   性别:
    <span class="info"> ${student.sex}</span>
    </p>
   <p> 
   专业:
   <span class="info"> ${student.profession}</span>
   </p>
   <p>
   身份证: <span class="info">${student.cardNo}</span>
   </p>
  <p>电话: <span class="info">${student.tel}</span>
  </p>
    </form>
</div>
<div id="a"><a onclick="submit()"><img src="img/信息编辑.png" style="width=20px;height=20px;"/></a></div>
  </div> 
</body>
</html>