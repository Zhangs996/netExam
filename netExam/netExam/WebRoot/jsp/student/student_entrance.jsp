<%@page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- 获取服务器url -->
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; // basePath="http://localhost:8080/travel/"
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>线上考试星学生首页</title>
    <link href="css/menu.css" rel="stylesheet" type="text/css">
    <script src="js/jquery-3.3.1.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js?v=87d37353ad57" type="text/javascript"></script>
    <script src="js/admin-base.js?v=127797ede057" type="text/javascript"></script>
    <style type="text/css">
    a {text-decoration: none}
    .iframe {
    	width:100%;
    	height:100%;
    	scrolling:no;
    	border-width:0px;
    	margin:0px;
    }
    body{OVERFLOW:SCROLL;overflow:hidden;}
    </style>
</head>
<body>
<div class="viewFrameWork sidebar-full" id="viewFrameWork">
    <div class="viewFrameWork-statusbar"><font size="4" color="#4682B4">线上考试星学生页面</font>
        <a title="logo" class="status-left company-logo" id="companyLogo" href="list_student_message">
            <!--对有没有logo进行判断-->
            <img class="icon-logo logo-ksx" src="img/kaoshi.png">
        </a>
    </div>
    <div class="viewFrameWork-main">
        <div class="viewFrameWork-sidebar">
            <div class="sidebar-inner">
                <div class="sidebar-nav">
                    <ul class="sidebar-trans" id="ksxAdminSidebar">
                        <li class="nav-item nav-item-index" id="navItemIndex">
                            <a title="" href="list_student_message1" target="iframe" data-original-title="" data-toggle="tooltip" data-container="body" data-placement="right">
                                <div class="nav-icon">
                                    <i class="icon icon-a_nav_home icon-index">
                                    	<img src="img/首页-选中.png" style="position:absolute;top:10px;left:5px;">
                                    </i>
                                </div>
                                <span class="nav-title">首页</span>
                            </a>
                        </li>
                        <li class="nav-item nav-item-index" id="navItemIndex">
                            <a title="" href="student_exam_list.servlet" target="iframe" data-original-title="" data-toggle="tooltip" data-container="body" data-placement="right">
                                <div class="nav-icon">
                                    <i class="icon icon-a_nav_home icon-index">
                                    	<img src="img/考试.png" style="position:absolute;top:10px;left:5px;">
                                    </i>
                                </div>
                                <span class="nav-title">进行考试</span>
                            </a>
                        </li>
                        <li class="nav-item nav-item-index" id="navItemIndex">
                            <a title="" href="list_student_grades.servlet" target="iframe" data-original-title="" data-toggle="tooltip" data-container="body" data-placement="right">
                                <div class="nav-icon">
                                    <i class="icon icon-a_nav_home icon-index">
                                    	<img src="img/成绩.png" style="position:absolute;top:10px;left:5px;">
                                    </i>
                                </div>
                                <span class="nav-title">查询成绩</span>
                            </a>
                        </li>
                        <li class="nav-item nav-item-index" id="navItemIndex">
                            <a title="" href="student_info" target="iframe" data-original-title="" data-toggle="tooltip" data-container="body" data-placement="right">
                                <div class="nav-icon">
                                    <i class="icon icon-a_nav_home icon-index">
                                    	<img src="img/个人信息.png" style="position:absolute;top:10px;left:5px;">
                                    </i>
                                </div>
                                <span class="nav-title">修改个人资料</span>
                            </a>
                        </li>
                        <li class="nav-item nav-item-index" id="navItemIndex">
                            <a title="" href="jsp/student/student_feedback.jsp" target="iframe" data-original-title="" data-toggle="tooltip" data-container="body" data-placement="right">
                                <div class="nav-icon">
                                    <i class="icon icon-a_nav_home icon-index">
                                    	<img src="img/意见反馈.png" style="position:absolute;top:10px;left:5px;">
                                    </i>
                                </div>
                                <span class="nav-title">用户反馈</span>
                            </a>
                        </li>
                        <li class="nav-item nav-item-index" id="navItemIndex">
                            <a title="" href="student_logout" data-original-title="" data-toggle="tooltip" data-container="body" data-placement="right">
                                <div class="nav-icon">
                                    <i class="icon icon-a_nav_home icon-index">
                                    	<img src="img/退出登录.png" style="position:absolute;top:10px;left:5px;">
                                    </i>
                                </div>
                                <span class="nav-title">退出登录</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        
		<div class="viewFrameWork-body" style="scrolling:no">
            <div class="body-wrapper" style="width:100%;height:100%">
			    <div class="body-content" style="width:100%;height:100%;margin:0px;">
			        <div class="page_wrapper" style="width:1760px;height:100%;margin:0px;">
			 			<div class="quick-start-wrapper clearfix" style="height:100%">
			                <iframe class="iframe" name="iframe" src="jsp/student/student_home_page.jsp">
			                </iframe>
			            </div>
			        </div>
			    </div>
			</div>
        </div>		        
    </div>
</div>
</body>
</html>
