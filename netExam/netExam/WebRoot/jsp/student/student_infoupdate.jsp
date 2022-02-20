<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- 获取服务器url -->
<%
	String path = request.getContextPath(); //  path = "/travel"
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<html lang="en">
<head>
<meta charset="UTF-8">
	<title>在线考试星修改信息</title> <!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->
	<base href="<%=basePath%>">
	<script src="js/student_update.js" type="text/javascript"></script>
    <script src="js/jquery-3.3.1.js"></script>
	<script src="js/layer/layer.js"></script>
    <style type="text/css">
body{
	background-color: white;
}
.img{
background:url("img/信息.png") no-repeat 300px -80px;
}
h1{
margin-left:150px;
font-size:36px;
		color: #0F0;
		letter-spacing: 0;
		text-shadow: 0px 1px 0px #999, 0px 2px 0px #888, 0px 3px 0px #777, 0px 4px 0px #666, 0px 5px 0px #555, 0px 6px 0px #444, 0px 7px 8px #333, 0px 8px 7px #001135
	}


.body {
	margin-left: 100px;
	margin-top: 10px;
}

.title {
	margin-top: 20px;
	margin-left: 10px;
}

.classfiy {
	font-family: "Times New Roman", Times, serif;
	font-size: 24px;
	margin-top: 10px;
}

label {
	width:100px;
	display:inline-block;
}
input {
	width:200px;
    height: 40px;
    margin-left: 5px;
    font-size: 16px;
    display: inline-block;
    /* 这里是去除掉input的默认样式然后修改为自己的 */
    background:none;
    outline:none;
    border:0px;
    /* 这里是修改为自己的样式 */
    border-bottom: 2px solid #dcdcdc;
    border-bottom-left-radius: 1px;
    border-bottom-right-radius: 1px;
}

input:focus {
	border-bottom: 2px solid #00FF7F;
    border-bottom-left-radius: 1px;
    border-bottom-right-radius: 1px;
}


/* input {
	height: 28px;
	border-bottom: 1px solid #cccccc;
	border-top-width: 0;
	border-left-width: 0;
	border-right-width: 0;
	padding: 5px;
} */

select {
	width:200px;
    height: 40px;
    margin-left: 5px;
    font-size: 16px;
    display: inline-block;
    /* 这里是去除掉input的默认样式然后修改为自己的 */
    background:none;
    outline:none;
    border:0px;
    /* 这里是修改为自己的样式 */
    border-bottom: 2px solid #dcdcdc;
    border-bottom-left-radius: 1px;
    border-bottom-right-radius: 1px;
    width:200px;
    height:30px;
    appearance:none;
    -moz-appearance:none;
    -webkit-appearance:none;
    background: url("img/sex-xiala.png") no-repeat 170px center;
    background-size:10%;
    font-size:16px;
    font-family:Microsoft YaHei;
    color:#666;
    outline:none;
}

/* select {
	width: 100px;
	height: 40px;
	border-radius: 0px;
	display: inline;
	box-shadow: 0 0 5px #ccc;
}

select:after {
	content: "";
	width: 14px;
	height: 8px;
	background: url(img/下拉.png) no-repeat left;
	position: absolute;
	left: 380px;
	top: 30%;
	pointer-events: none;
} */

/* #profession {
	border: none;
	outline: none;
	width: 200px;
	height: 40px;
	line-height: 40px;
	appearance: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	padding-left: 60px;
} */


a{
	font-family: "Times New Roman", Times, serif;
	font-size: 24px;
	
}

#a{
	margin-top:30px;
	margin-left:250px;
}
</style>
</head>
<body>
	
	<h1>修改学生信息</h1>
	<div class="img">
		<div class="body">
			<form id="submit_student" action="student_update" method="post">
				<input type="hidden" name="student.id" value="${student.id }">
				<input type="hidden" name="student.status"value="${student.status }"> 
				<input type="hidden"name="student.joinTime" value="${student.joinTime }">
				<input type="hidden" id="student_sex" value="${student.sex}"> 
				<input type="hidden" id="student_profession" value="${student.profession}">
				<div class="classfiy">
					<label>姓&nbsp;&nbsp;&nbsp;&nbsp;名:</label>
					<input id="name" onchange="check_username(this)" name="student.name" value="${student.name}"> 
					<label id="name_error"></label>
				</div>
				<div class="classfiy">
					<label>性&nbsp;&nbsp;&nbsp;&nbsp;别:</label>
					<select onchange="sex_change(this)" onblur="sex_select(this)"id="sex" name="student.sex">
						<option value="男">男</option>
						<option value="女">女</option>
					</select> 
					<label id="sex_error"></label>
				</div>
				<div class="classfiy">
					<label>专&nbsp;&nbsp;&nbsp;&nbsp;业:</label>
					<select onchange="profession_change(this)" onblur="profession_select(this)" id="profession"	name="student.profession">
						<option value="电子信息工程">电子信息工程</option>
						<option value="通信工程">通信工程</option>
						<option value="电子信息科学与技术">电子信息科学与技术</option>
						<option value="自动化">自动化</option>
						<option value="计算机科学与技术">计算机科学与技术</option>
						<option value="网络工程">网络工程</option>
						<option value="教育技术学">教育技术学</option>
						<option value="电子工程及其自动化">电子工程及其自动化</option>
					</select> 
					<label id="profession_error"></label>
				</div>
					<script type="text/javascript">
						function display_sex(option) {
							var all_options_sex = document.getElementById("sex").options;
							for (i = 0; i < all_options_sex.length; i++) {
								if (all_options_sex[i].value == option) {
									all_options_sex[i].selected = true;
								}
							}
						}
						function dispaly_profession(option) {
							var all_options_profession = document.getElementById("profession").options;
							for (i = 0; i < all_options_profession.length; i++) {
								if (all_options_profession[i].value == option) {
									all_options_profession[i].selected = true;
								}
							}
					
						}
						dispaly_profession(document.getElementById("student_profession").value);
						display_sex(document.getElementById("student_sex").value);
					</script>
				<div class="classfiy">
					<label>身份证:</label>
					<input id="id" onchange="check_cardid(this)" name="student.cardNo" value="${student.cardNo}"> 
					<label id="id_error"></label>
				</div>
				<div class="classfiy">
					<label>电&nbsp;&nbsp;&nbsp;&nbsp;话: </label>
					<input id="tel" onchange="check_tel(this)" name="student.tel" value="${student.tel}">
					<label id="tel_error"></label>
				</div>
				<div id="a">
		        	<a href="jsp/student/student_infocenter.jsp"><img src="img/信息取消.png" style="width=20px;height=20px;"/></a>
		        	<a onclick="submit()"><img src="img/学生信息完成.png" style="width=20px;height=20px;"/></a>
	       		</div>
			</form>
		</div>
	</div>
</body>
</html>