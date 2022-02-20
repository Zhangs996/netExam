<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@page language="java" pageEncoding="utf-8"%>
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
	<title>在线考试星进行考试</title>
	<!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->
	<base href="<%=basePath%>">
	<link href="css/menu.css" rel="stylesheet" type="text/css">
	<link href="css/student_list_exam.css" rel="stylesheet" type="text/css">
	
    <script type="text/javascript" src="js/jquery-3.3.1.js"></script>
	<script src="js/student_list_exam.js" type="text/javascript"></script>
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
<div class="tool-wrap">
	<div class="tool-content-wrap">
		<div class="tool-content">
    	<p class="tool-content-p">
        	进行中考试
       	</p>
		</div>
		<div class="message">
			<p>
				${message}
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
<table>
	<c:set var="totalUsers" value="${requestScope.totalUsers}" />
	<c:set var="usersPerPage" value="${requestScope.usersPerPage}" />
	<c:set var="totalPages" value="${requestScope.totalPages}" />
	<c:set var="beginIndex" value="${requestScope.beginIndex}" />
	<c:set var="endIndex" value="${requestScope.endIndex}" />
	<c:set var="page" value="${requestScope.page}" />
	
		<thead>
        <tr>
           <th>课程名</th>
           <th>时长(min)</th>
           <th>创建时间</th>
           <th colspan="1">操作</th>
        </tr>
        </thead>
        <c:if test="${totalUsers == 0}">
       	<tbody id="tbody">
       		<tr>
				<td  style="text-align:center;font-size:18px;" colspan="13">还没有可进行的考试</td>
			</tr>
		</tbody>
		</c:if>
		<tbody id="tbody">
		<c:if test="${totalUsers != 0}">
			<c:set var="currentPageUsers" value="${requestScope.exams.subList(beginIndex,endIndex)}" />
			<c:forEach var="exam" items="${currentPageUsers}">
	                <tr>
	                    <td>${exam.lesson.name}</td>
	                    <td>${exam.duration}</td>
	                    <td>${exam.joinTime}</td>
	                    <td style="width: 30px">
	                        <a onclick="start_exam(${exam.id})">
	                           进入考试
	                        </a>
	                    </td>
	                </tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<c:if test="${totalUsers != 0}">
	<div class="text-center">
		<nav>
			<ul class="pagination">
				<li>
					<a href="<c:url value="/student_exam_list.servlet?page=1&totalUsers=${totalUsers}"/>">首页</a>
				</li>
				<li>
					<a href="<c:url value="/student_exam_list.servlet?page=${page-1>1?page-1:1}&totalUsers=${totalUsers}"/>">&laquo;</a>
				</li>
				<c:forEach begin="1" end="${totalPages}" varStatus="loop">
					<c:set var="active" value="${loop.index==page?'active':''}" />
					<li class="${active}">
						<a href="<c:url value="/student_exam_list.servlet?page=${loop.index}&totalUsers=${totalUsers}"/>">${loop.index}</a>
					</li>
				</c:forEach>
				<li>
					<a href="<c:url value="/student_exam_list.servlet?page=${page+1<totalPages?page+1:totalPages}&totalUsers=${totalUsers}"/>">&raquo;</a>
				</li>
				<li>
					<a href="<c:url value="/student_exam_list.servlet?page=${totalPages}&totalUsers=${totalUsers}"/>">尾页&nbsp;&nbsp;&nbsp;&nbsp;</a>
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
	</div>
	</c:if>
</div>
</body>
</html>