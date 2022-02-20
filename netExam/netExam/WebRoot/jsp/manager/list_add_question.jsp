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
	<title>在线考试星批量导入试题</title>
	<!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->
	<base href="<%=basePath%>">
	<script src="js/create_question.js" type="text/javascript"></script>
	<link href="css/list_add_question.css" rel="stylesheet" type="text/css">
	<script src="js/jquery-3.3.1.js"></script>
	<script src="js/layer/layer.js"></script>
	<style type="text/css">
	a {
		text-decoration: none
	}
	</style>
	<script>
	function returnhome(){
	    location.href = "manager_question.servlet";
	  }
	function LimitAttach() {  
	    var file=document.getElementById("files").value;  
	    var form1=document.getElementById("exl_submit");  
	    var ext = file.slice(file.lastIndexOf(".")+1).toLowerCase();  
	    if ("xls" != ext) {
	    	layer.open({
			  title: ''
			  ,content: '只能上传.xls文件'
			});
	        return false;  
	    }  
	    else {  
	        form1.submit();  
	    }  
	}  

	</script>
</head>
<body>
	<div style="background: url(img/create_exam.jpg);height:800px;width:100% " >
	<s:form id="exl_submit" action="list_add_question" method="post" enctype="multipart/form-data">
	<br><br>
	<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	选择题批量导入<br></h3>
	<br>
		<div class="text">
			<input type="file" id="files" name="list_add_question" value="路径"/>
		</div>
	</s:form>
	<br><br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="jsp/manager/example_question.jsp">
	<button style="cursor: pointer; color: #000000;width: 5%;height: 5%;background: #00BFFF;border: #00BFFF;">查看模板</button>
	</a>
	&nbsp;&nbsp;&nbsp;
	<button onclick="LimitAttach()"style="cursor: pointer; color: #000000;width: 5%;height: 5%;background: #00BFFF;border: #00BFFF;">确认导入</button>
	&nbsp;&nbsp;&nbsp;

	<button onclick="returnhome()" style="cursor: pointer; color: #000000;width: 5%;height: 5%;background: #00BFFF;border: #00BFFF;">返回</button>

	</div>
</body>
</html>