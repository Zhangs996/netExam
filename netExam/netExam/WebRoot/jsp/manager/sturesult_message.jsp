<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- 获取服务器url -->
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/"; 
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>在线考试星成绩信息</title>
	<!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->
	<base href="<%=basePath%>">
	<link href="css/menu.css" rel="stylesheet" type="text/css">
	<link href="css/table_sturesult.css" rel="stylesheet" type="text/css">
	
	<script src="js/manager_sturesult_message.js" type="text/javascript"></script>
	<script src="js/jquery-3.3.1.js"></script>
	<script src="js/layer/layer.js"></script>
	
	<style type="text/css">
	a {
		text-decoration: none
	}
	/*i标记的伪样式*/
	.icon-p_top_search::before {
	    content: url("img/搜索框.png");
	}
	input[type="checkbox"]:checked {
	
	    background: url("img/选中.png");
	
	}
	.jmp input {
	    width:40px;
	    height: 20px;
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
	</style>
</head>
<body>
<!-- 隐藏域存储exam_lesson_name -->
<input type="hidden" id="exam_lesson_name" name="exam_lesson_name" value="${exam_lesson_name}">
<div class="tool-wrap">
	<div class="tool-content-wrap">
    	<div class="tool-content">
    	<p class="tool-content-p">
    		${exam_lesson_name } 所有学生成绩
    	</p>
		</div>

		<div class="tool-search">
    		<i id="search" class="search-section-icon icon-p_top_search" onclick="search()"></i>
			<input name="condition" id="condition" class="tool-search-input" type="text" onkeydown='if(event.keyCode==13){search();}' onfocus="search_onfcus()" onblur="search_onblur()" placeholder="请输入搜索条件">
        </div>
    </div>
</div>
<div class="body-content">
<hr style="background:black;">
<br>

<!-- 隐藏域存储exam_id -->
<input type="hidden" id="exam_id" name="exam_id" value="${exam_id}">
<table>
	<c:set var="totalUsers" value="${requestScope.totalUsers}" />
	<c:set var="usersPerPage" value="${requestScope.usersPerPage}" />
	<c:set var="totalPages" value="${requestScope.totalPages}" />
	<c:set var="beginIndex" value="${requestScope.beginIndex}" />
	<c:set var="endIndex" value="${requestScope.endIndex}" />
	<c:set var="page" value="${requestScope.page}" />
	<c:set var="currentPageUsers" value="${requestScope.sturesults.subList(beginIndex,endIndex)}" />
	
	<thead>
       <tr>
           <th style="width:5%">编号</th>
           <th>课程</th>
           <th>学号</th>
           <th>姓名</th>
           <th>单选题总分</th>
           <th>多选题总分</th>
           <th>判断题总分</th>
           <th>总分</th>
           <th>考试结果</th>
           <th>交卷时间</th>
       </tr>
       </thead>
       <c:if test="${totalUsers == 0}">
       	<tbody id="tbody">
       		<tr>
				<td  style="text-align:center;font-size:18px;" colspan="10">没有找到相关结果</td>
			</tr>
		</tbody>
		</c:if>
		<tbody id="tbody">
		<c:if test="${totalUsers != 0}">
			<c:forEach var="sturesult" items="${currentPageUsers}">
	                <tr>
	                    <td style="width:5%">${sturesult.id}</td>
	                    <td>${sturesult.exam.lesson.name}</td>
	                    <td>${sturesult.student.id}</td>
	                    <td>${sturesult.student.name}</td>
	                    <td>${sturesult.resSingle}</td>
	                    <td>${sturesult.resMore}</td>
	                    <td>${sturesult.resJudge}</td>
	                    <td>${sturesult.resTotal}</td>
	                    <c:if test="${sturesult.resTotal < 60}">
	                    	<td>未通过</td>
	                    </c:if>
	                    <c:if test="${sturesult.resTotal >= 60}">
	                    	<td>通过</td>
	                    </c:if>
	                    <td>${sturesult.joinTime}</td>
	                </tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	
	<div class="text-center">
		<c:if test="${totalUsers != 0}">
		<nav>
			<ul class="pagination">
				<li>
					<a href="<c:url value="/manager_sturesult_message.servlet?exam_id=${exam_id}&exam_lesson_name=${exam_lesson_name}&page=1&totalUsers=${totalUsers}"/>">首页</a>
				</li>
				<li>
					<a href="<c:url value="/manager_sturesult_message.servlet?exam_id=${exam_id}&exam_lesson_name=${exam_lesson_name}&page=${page-1>1?page-1:1}&totalUsers=${totalUsers}"/>">&laquo;</a>
				</li>
				<c:forEach begin="1" end="${totalPages}" varStatus="loop">
					<c:set var="active" value="${loop.index==page?'active':''}" />
					<li class="${active}">
						<a href="<c:url value="/manager_sturesult_message.servlet?exam_id=${exam_id}&exam_lesson_name=${exam_lesson_name}&page=${loop.index}&totalUsers=${totalUsers}"/>">${loop.index}</a>
					</li>
				</c:forEach>
				<li>
					<a href="<c:url value="/manager_sturesult_message.servlet?exam_id=${exam_id}&exam_lesson_name=${exam_lesson_name}&page=${page+1<totalPages?page+1:totalPages}&totalUsers=${totalUsers}"/>">&raquo;</a>
				</li>
				<li>
					<a href="<c:url value="/manager_sturesult_message.servlet?exam_id=${exam_id}&exam_lesson_name=${exam_lesson_name}&page=${totalPages}&totalUsers=${totalUsers}"/>">尾页&nbsp;&nbsp;&nbsp;&nbsp;</a>
				</li>
				<li class="jmp">
					<input type="hidden" id="totalPages" value="${totalPages}"/>
					<input type="hidden" id="totalUsers" value="${totalUsers}"/>
					<input type="hidden" id="page" value="${page}"/>
					<sapn style="font:13px;color:#1E90FF;">跳转至:</sapn>
					<input type="text" id="jmp_page" onkeydown='if(event.keyCode==13){jmp_page();}'/>
					<a onclick="jmp_page()"><img src="img/跳转页面.png" style="width=20px;height=20px;"/></a>
				</li>
			</ul>
		</nav>
		</c:if>
	</div>
	
</div>
</body>
</html>