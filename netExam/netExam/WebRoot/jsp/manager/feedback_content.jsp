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
<title>在线考试星</title>
<!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->
<base href="<%=basePath%>">
    <style type="text/css">
        .class1{
            background: #a0ffff;
            text-align: center;
            width: 100%;
            height:382px;
            border: 1px #d7edff solid;
            border-radius: 5px;
            margin: 0px 0px 7px 0px;
            box-shadow:5px 5px 10px gray;
            background: -webkit-linear-gradient(left,#d7edff, #a7d6ff);
            background: -o-linear-gradient(right,#d7edff, #a7d6ff);
            background: -moz-linear-gradient(right,#d7edff, #a7d6ff);
            background: linear-gradient(to right,#d7edff, #a7d6ff);
            }
        h{
            font-size: 24px;
            font-weight: bold;
            color: #0000cc;
        }
        p{
            font-size: 20px;
            color: #0000b6;
        }

    </style>
</head>
<body>
<div class="class1">
    <h>${suggest.title}</h>
    <p>${suggest.content}</p>
</div>
</body>
</html>