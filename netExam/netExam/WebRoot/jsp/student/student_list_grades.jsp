<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <title>在线考试星成绩查询</title>
    <!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->    
    <base href="<%=basePath%>">
    <link href="css/menu.css" rel="stylesheet" type="text/css">
    <link href="css/student_list_grade.css" rel="stylesheet" type="text/css">
    <script src="js/list_grades.js" type="text/javascript"></script>
    <script src="js/jquery-3.3.1.js"></script>
	<script src="js/layer/layer.js"></script>
    <style type="text/css">a {text-decoration: none}</style>
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
	    width:35px;
	    height: 30px;
	    margin-left: 5px;
	    font-size: 15px;
	    color: #0000FF;
	    display: inline-block;
	    /* 这里是去除掉input的默认样式然后修改为自己的 */
	    background:none;
	    outline:none;
	    border:0px;
	    /* 这里是修改为自己的样式 */
	    border-bottom: 2px solid #00BFFF;
	    border-bottom-left-radius: 1px;
	    border-bottom-right-radius: 1px;
	}
	.tool-content-p {
		font-size: 30px ;
	    color: #00BFFF;
		letter-spacing: 0;
		text-shadow: 0px 1px 0px #999, 0px 2px 0px #888, 0px 3px 0px #777, 0px 4px 0px #666, 0px 5px 0px #555, 0px 6px 0px #444, 0px 7px 0px #333, 0px 8px 7px #001135
	}
	</style>
</head>
<body>
    <div class="tool-wrap">
            <div class="tool-content-wrap">
                <div class="tool-content">
                <p class="tool-content-p">
                	查询成绩
                </p>
                </div>

                <div class="tool-search">
                    <i id="search" class="search-section-icon icon-p_top_search" style="position: absolute;top: 18%;" onclick="search()"></i>
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
								<c:set var="currentPageUsers" value="${requestScope.grades.subList(beginIndex,endIndex)}" />
								<thead>
                                <tr>
                                    <th>学生ID</th>
                                    <th>考试科目</th>
                                    <th>单选题分数</th>
                                    <th>多选题分数</th>
                                    <th>判断题分数</th>
                                    <th>总分</th>
                                    <th>考试完成时间</th>
                                </tr>
                                </thead>
                                <c:if test="${totalUsers == 0}">
                                	<tbody id="tbody">
                                		<tr>
											<td  style="text-align:center;font-size:18px;" colspan="13">没有找到相关结果</td>
										</tr>
									</tbody>
								</c:if>
								<tbody id="tbody">
								<c:if test="${totalUsers != 0}">
								<c:forEach var="grades" items="${currentPageUsers}">
                                    <tr>
	                                    <td>${grades.student.id}</td>
                                        <td>${grades.exam.lesson.name}</td>
                                        <td>${grades.resSingle}</td>
                                        <td>${grades.resMore}</td>
                                        <td>${grades.resJudge}</td>
                                        <td>${grades.resTotal}</td>
                                        <td>${grades.joinTime}</td>
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
											<a href="<c:url value="list_student_grades.servlet?page=1"/>">首页</a>
										</li>
										<li>
											<a href="<c:url value="/list_student_grades.servlet?page=${page-1>1?page-1:1}"/>">&laquo;</a>
										</li>
										<c:forEach begin="1" end="${totalPages}" varStatus="loop">
											<c:set var="active" value="${loop.index==page?'active':''}" />
											<li class="${active}">
												<a href="<c:url value="/list_student_grades.servlet?page=${loop.index}"/>">${loop.index}</a>
											</li>
										</c:forEach>
										<li>
											<a href="<c:url value="list_student_grades.servlet?page=${page+1<totalPages?page+1:totalPages}"/>">&raquo;</a>
										</li>
										<li>
											<a href="<c:url value="/list_student_grades.servlet?page=${totalPages}"/>">尾页</a>
										</li>
										&nbsp;&nbsp;&nbsp;&nbsp;
										<li class="jmp">
											<input type="hidden" id="totalPages" value="${totalPages}"/>
											<input type="hidden" id="page" value="${page}"/>
											<sapn style="font:13px;color:#1E90FF;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;跳转至:</sapn>
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