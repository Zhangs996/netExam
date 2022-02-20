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
    <title>在线考试星试题管理</title>
    <!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->    
    <base href="<%=basePath%>">
    <link href="css/menu.css" rel="stylesheet" type="text/css">
    <link href="css/table_optional.css" rel="stylesheet" type="text/css">
    <script src="js/manager_question.js" type="text/javascript"></script>
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
	</style>
</head>
<body>
    <div class="tool-wrap">
            <div class="tool-content-wrap">
                <div class="tool-content">
                <a href="list_select_course_for_question">
                        <button id="AddQuestion" style="cursor: pointer; color: #FFFFFF;width: 10%;height: 70%;background: #1a8cfe;border: #1A8CFE;">
                            添加试题
                        </button>
                    </a>
                    <a href="jsp/manager/list_add_question.jsp">
                        <button id="listadd" style="cursor: pointer; color: #FFFFFF;width: 15%;height: 70%;background: #1a8cfe;border: #1A8CFE;">
                            批量导入试题
                        </button>
                    </a>
                    <a>
                        <button id="SearchQuestion" style="cursor: pointer; color: #FFFFFF;width: 10%;height: 70%;background: #1a8cfe;border: #1A8CFE;"
                        onclick="search_single_question_js()">
                            单选题
                        </button>
                        <button id="SearchQuestion" style="cursor: pointer; color: #FFFFFF;width: 10%;height: 70%;background: #1a8cfe;border: #1A8CFE;"
                        onclick="search_multiple_question_js()">
                            多选题
                        </button>
                      </a>
                      <a>
                         <button id="DeleteQuestion"  class="delete-button" style="width: 10%;" disabled="disabled" onclick="delete_question_js()">
                 删除
                        </button>
                    </a>
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
								<c:set var="currentPageUsers" value="${requestScope.questions.subList(beginIndex,endIndex)}" />
								<thead>
                                <tr>
                                    <th style="width: 3%;padding:10px">
                                        <input type="checkbox" id="theadInp" class="checkbox"/>
                                        <label class="checkbox-label"></label>
                                    </th>
                                    <th class="id">试题ID</th>
                                    <th class="lesson_name">课程名称</th>
                                    <th class="type">试题类型</th>
                                    <th class="level">试题难度</th>
                                    <th class="question">试题名称</th>
                                    <th>选项A</th>
                                    <th>选项B</th>
                                    <th>选项C</th>
                                    <th>选项D</th>
                                    <th>答案</th>
                                    <th>创建时间</th>
                                    <th style="width:3%;colspan='1'">操作</th>
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
								<c:forEach var="questions" items="${currentPageUsers}">
                                    <tr>
                                    	<td style="width: 3%;padding:10px">
	                                        <input type="checkbox" class="checkbox"/>
	                                        <label class="checkbox-label"></label>
	                                    </td>
	                                    <td>${questions.id}</td>
                                        <td>${questions.lesson.name}</td>
                                        <td>${questions.type}</td>
                                        <td>${questions.level}</td>
                                        <td>${questions.question}</td>
                                        <td>${questions.optionA}</td>
                                        <td>${questions.optionB}</td>
                                        <td>${questions.optionC}</td>
                                        <td>${questions.optionD}</td>
                                        <td>${questions.answer}</td>
                                        <td>${questions.joinTime}</td>
                                        <td style="width: 30px">
                                            <a title="编辑" href="edit_question_one?question.id=${questions.id}">
                                                <img src="img/bianji.png">
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
											<a href="<c:url value="/manager_question.servlet?page=1&totalUsers=${totalUsers}"/>">首页</a>
										</li>
										<li>
											<a href="<c:url value="/manager_question.servlet?page=${page-1>1?page-1:1}&totalUsers=${totalUsers}"/>">&laquo;</a>
										</li>
										<c:if test="${page!=1}">
					                        <li class="">
					                            <a href="<c:url value="/manager_question.servlet?page=1&totalUsers=${totalUsers}"/>">1</a>
					                        </li>
					                    </c:if>
					                    <c:if test="${page>2}">
					                        <li class="disabled">
					                            <a class="page-link">...</a>
					                        </li>
					                    </c:if>
					                    <li class="active">
					                        <a class="page-link" href="<c:url value="/manager_question.servlet?page=${page}&totalUsers=${totalUsers}"/>">${page}</a>
					                    </li>
					                    <c:if test="${totalPages-page>1}">
					                        <li class="disabled">
					                            <a class="page-link">...</a>
					                        </li>
					                    </c:if>
					                    <c:if test="${page!=totalPages}">
					                        <li class="page-item">
					                            <a class="page-link" href="<c:url value="/manager_question.servlet?page=${totalPages}&totalUsers=${totalUsers}"/>">${totalPages}</a>
					                        </li>
					                    </c:if>
										<li>
											<a href="<c:url value="manager_question.servlet?page=${page+1<totalPages?page+1:totalPages}&totalUsers=${totalUsers}"/>">&raquo;</a>
										</li>
										<li>
											<a href="<c:url value="/manager_question.servlet?page=${totalPages}&totalUsers=${totalUsers}"/>">尾页</a>
										</li>
										&nbsp;&nbsp;&nbsp;&nbsp;
										<li class="jmp">
											<input type="hidden" id="totalPages" value="${totalPages}"/>
											<input type="hidden" id="totalUsers" value="${totalUsers}"/>
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