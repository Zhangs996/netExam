<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" pageEncoding="utf-8"%>
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
    <link href="css/iframe_show_question.css" rel="stylesheet" type="text/css">
    <script src="js/jquery-3.3.1.js"></script>
	<script src="js/layer/layer.js"></script>
    <script src="js/iframe.js" type="text/javascript"></script>
</head>
<body onload="load()">
<div class="div-content">
	<input type="hidden" id="exam_id" value=${exam_id }>
	<c:if test="${singlesNum != 0 }">
		<div class="div-single">
			<div class="div-single-title">
				&nbsp;&nbsp;&nbsp;&nbsp;单选题(共<label>${singlesNum }</label>题,总计<label>${singlesScore }</label>分)
			 	<hr>
			</div>
			<div class="div-single-question">
			<table>
				<tbody id="singleTbody">
					<c:forEach var="single" items="${singles}" varStatus="loop">
						<tr>
							<td>
								<br>
								<label style="color:#00BFFF"><c:out value="${loop.index+1 }"/></label>.${single.question }
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio" name="single${loop.index+1 }" id="A">&nbsp;A.${single.optionA }
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio" name="single${loop.index+1 }" id="B">&nbsp;B.${single.optionB }
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio" name="single${loop.index+1 }" id="C">&nbsp;C.${single.optionC }
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio" name="single${loop.index+1 }" id="D">&nbsp;D.${single.optionD }
							</td>
						</tr>
						<tr>
							<td>
								<input type="hidden" id="${loop.index+1 }" value="${single.id }">
							</td>
						</tr>
						<tr>
							<td>
								<br>
								<hr>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>
		</div>
	</c:if>
	
	<c:if test="${moresNum != 0 }">
	<div class="div-more">
		<div class="div-more-title">
			<hr>
			&nbsp;&nbsp;&nbsp;&nbsp;多选题(共<label>${moresNum }</label>题,总计<label>${moresScore }</label>分)
			<hr>
		</div>
		<div class="div-more-question">
			<table>
				<tbody id="moreTbody">
					<c:forEach var="more" items="${mores}" varStatus="loop">
						<tr>
							<td>
								<br>
								<label style="color:#00BFFF"><c:out value="${loop.index+1 }"/></label>.${more.question }
							</td>
						</tr>
						<tr>
							<td>
								<input type="checkbox" name="more${loop.index+1 }" id="A">&nbsp;A.${more.optionA }
							</td>
						</tr>
						<tr>
							<td>
								<input type="checkbox" name="more${loop.index+1 }" id="B">&nbsp;B.${more.optionB }
							</td>
						</tr>
						<tr>
							<td>
								<input type="checkbox" name="more${loop.index+1 }" id="C">&nbsp;C.${more.optionC }
							</td>
						</tr>
						<tr>
							<td>
								<input type="checkbox" name="more${loop.index+1 }" id="D">&nbsp;D.${more.optionD }
							</td>
						</tr>
						<tr>
							<td>
								<input type="hidden" id="${loop.index+1 }" value="${more.id }">
							</td>
						</tr>
						<tr>
							<td>
								<br>
								<hr>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	</c:if>
	
	<c:if test="${judgesNum != 0 }">
	<div class="div-judge">
		<div class="div-judge-title">
			<hr>
			&nbsp;&nbsp;&nbsp;&nbsp;判断题(共<label>${judgesNum }</label>题,总计<label>${judgesScore }</label>分)
			<hr>
		</div>
		<div class="div-judge-question">
			<table>
				<tbody id="judgeTbody">
					<c:forEach var="judge" items="${judges}" varStatus="loop">
						<tr>
							<td>
								<br>
								<label style="color:#00BFFF"><c:out value="${loop.index+1 }"/></label>.${judge.question }
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio" name="judge${loop.index+1 }" id="正确">&nbsp;正确
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio" name="judge${loop.index+1 }" id="错误">&nbsp;错误
							</td>
						</tr>
						<tr>
							<td>
								<input type="hidden" id="${loop.index+1 }" value="${judge.id }">
							</td>
						</tr>
						<tr>
							<td>
								<br>
								<hr>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	</c:if>
	
	
</div>
</body>
</html>