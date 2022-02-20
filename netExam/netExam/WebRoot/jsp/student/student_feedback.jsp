<%@page language="java" pageEncoding="utf-8" import="action.*"%>
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
    <title>在线考试星反馈</title>
    <!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->
	<base href="<%=basePath%>">
    <link href="css/menu.css" rel="stylesheet" type="text/css">
    
    <script src="js/feedback.js" type="text/javascript"></script>
    
    <style type="text/css">
    body{
    	background:#F1F1F1;
    }
    a {text-decoration: none}
    .Content-Main{
            max-width: 800px;
            margin-top: 50px;
            margin-left: 0px;
            font: 12px "Helvetica Neue", Helvetica, Arial, sans-serif;
            text-shadow: 1px 1px 1px #FFF;
            border-radius: 5px;
            color: #888;
      
        }
     
        .Content-Main label{
            display: block;
            margin: 0px 0px 5px;
        }
        .Content-Main label>span{
            float: left;
            width: 20%;
            padding-right: 10px;
            margin-top: 10px;
            font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
            font-weight: bold;
            text-align: right;
            color: #333;
        }
        .Content-Main input[type="text"],.Content-Main textarea{
            width: 70%;
            height: 20px;
            padding: 5px 0px 5px 5px;
            margin-bottom: 16px;
            margin-right: 6px;
            margin-top: 2px;
            line-height: 15px;
            border-radius: 4px;
            border: 1px solid #CCC;
            color: #888;
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
                  }
  
        .Content-Main textarea{
            width: 70%;
            height: 200px;
            padding: 5px 0px 0px 5px;
        }
        .button{
            padding: 10px 25px 10px 25px;
            margin-left: 170px;
            border-radius: 4px;
            border:1px solid #CCC;
            background: #FFF;
            color: #333;
        }
        .button:hover{
            color: #333;
            background-color: #EBEBEB;
            border-color: #ADADAD;
        }
        #title{
            width: 70%;
            height: 35px;
            margin-bottom: 12px;
            margin-right: 6px;
            margin-top: 10px;
            line-height: 15px;
            padding: 5px 0px 5px 5px;
            border-radius: 4px;
            border: 1px solid #CCC;
            color: #888;
            }
            #info{
            margin-left: 300px;
            color:#FF5663;
            }
    </style>
    
</head>
<body>
	<div class="Content-Main">
    <form action="feedback" id="submit_feedback" onSubmit="return feedback()" method="post" >
     	<label>
            <span>标题:</span>
            <input  type="text" id="title" name="title" onchange="title_check()">
        </label>
        <label>
            <span>意见:</span>
            <textarea id="message" name="content" placeholder="请输入遇到的问题或建议..." onchange="content_check()"></textarea>
        </label>
        
        <input type="submit" name="button" class="button" value="发送">
       
        <p class="info" id="errorInfo" style="color:red;margin-left:20%;">
						${message }
		</p>
    </form>
</div>
</body>
</html>
