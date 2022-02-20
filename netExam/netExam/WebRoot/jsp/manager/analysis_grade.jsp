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
	<title>在线考试星</title>
	<!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->
	<base href="<%=basePath%>">
	<style type="text/css">
		.div-content {
			width:850px;
			height:300px;
			margin-top:0px;
			margin-bottom:0px;
			margin-left:0px;
			margin-right:0px;
		}
		
		.div-title {
			
		}
		 
		.div-table {
			margin: 0px 40px 0px 30px;
		}
		.title {
			text-align:center;
			font-size: 30px ;
		    color: #00BFFF;
			letter-spacing: 0;
			text-shadow: 0px 1px 0px #999, 0px 2px 0px #888, 0px 3px 0px #777, 0px 4px 0px #666, 0px 5px 0px #555, 0px 6px 0px #444, 0px 7px 0px #333, 0px 8px 7px #001135
		}
		table {
		    border-collapse: collapse;
		    border-spacing: 0;
		    border: 2px solid #c0c0c0;
		    width: 100%;
		}
		
		th,td {
		    border: 2px solid #d0d0d0;
		    color: #404060;
		    padding: 10px;
		    text-align: left;
		}
		
		th {
		    background-color: #1E90FF;
		    font-size: 15px ;
		    color: #fff;
		}
		
		td {
		    font-size: 13px;
		}
		
		tbody tr {
		    background-color: #f0f0f0;
		}
		
		tbody tr:hover {
		    cursor: pointer;
		    background-color: #fafafa;
		}
	</style>
</head>
<body>
	<div class="div-content" >
		<div class="div-title">
			<h2 class="title">
				课程：${exam.lesson.name}
			</h2>
		</div>
		<div class="div-table">
			<table>
				<thead>
					<tr>
						<th>考试人数</th>
						<th>通过率</th>
						<th>最高分</th>
						<th>最低分</th>
						<th>总分平均分</th>
						<th>单选题平均分</th>
						<th>多选题平均分</th>
						<th>判断题平均分</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${analysisGrade.examNum}</td>
						<td>${analysisGrade.passRate}</td>
						<td>${analysisGrade.maxScore}</td>
						<td>${analysisGrade.minScore}</td>
						<td>${analysisGrade.averageScore}</td>
						<td>${analysisGrade.averageSingle}</td>
						<td>${analysisGrade.averageMore}</td>
						<td>${analysisGrade.averageJudge}</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>