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
    <title>线上考试星管理员首页</title>
    <!-- base需要放到head中,这里我们就可以直接使用相对路径(即: 相对于base标签) -->    
    <base href="<%=basePath%>">
    <link href="css/menu.css" rel="stylesheet" type="text/css">
    <script src="js/jquery.min.js?v=8101d596b257" type="text/javascript"></script>
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
    <div class="viewFrameWork-statusbar"><font size="4" color="#4682B4">线上考试星管理页面</font>
        <a title="logo" class="status-left company-logo" id="companyLogo" href="">
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
                            <a title="" href="jsp/manager/manager_home_page.jsp" target="iframe" data-original-title="" data-toggle="tooltip" data-container="body" data-placement="right">
	                        	<div class="nav-icon">
                                    <i class="icon icon-a_nav_home icon-index">
                                    	<img src="img/首页-选中.png" style="position:absolute;top:10px;left:5px;">
                                    </i>
                                </div>
                                <span class="nav-title">首页</span>
                            </a>
                        </li>
                        <li class="nav-item has-sub-menu" id="navItemExam">
                            <a title="" class="menu-title" href="javascript:void(0)" data-toggle="tooltip" data-container="body" data-placement="right">
                                <div class="nav-icon">
                                    <i class="icon icon-a_nav_home icon-index">
                                    	<img src="img/考试管理.png" style="position:absolute;top:10px;left:5px;">
                                    </i>
                                </div>
                                <span class="nav-title">考试管理</span>
                            </a>
                            <ul class="sub-menu animate" style="height:0px;">
                                <li class="nav-item sub-nav-item" id="subNavItemExamMgr">
                                    <a href="manager_exam_message.servlet" target="iframe" >
                                        <span class="nav-title">进行中考试管理</span>
                                    </a>
                                </li>
                                <li class="nav-item sub-nav-item" id="subNavItemExamMgr">
                                    <a href="manager_exam_message.servlet?status=考试已结束&to_page=end_exam_manager.jsp" target="iframe" >
                                        <span class="nav-title">已结束考试管理</span>
                                    </a>
                                </li>
                                <li class="nav-item sub-nav-item" id="subNavItemPaperMgr">
                                    <a href="manager_question.servlet" target="iframe" >
                                        <span class="nav-title">选择题管理</span>
                                    </a>
                                </li>
                                <li class="nav-item sub-nav-item" id="subNavItemPaperMgr">
                                    <a href="manager_judge.servlet" target="iframe" >
                                        <span class="nav-title">判断题管理</span>
                                    </a>
                                </li>
                                <li class="nav-item sub-nav-item" id="subNavItemResultMgr">
                                    <a href="manager_lesson_message.servlet" target="iframe" >
                                        <span class="nav-title">课程管理</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <%-- <li class="nav-item has-sub-menu" id="navItemUser">
                            <a title="" class="menu-title" href="javascript:void(0)" data-toggle="tooltip" data-container="body" data-placement="right">
                                <div class="nav-icon">
                                    <i class="icon icon-a_nav_home icon-index">
                                    	<img src="img/人员管理.png" style="position:absolute;top:10px;left:5px;">
                                    </i>
                                </div>
                                <span class="nav-title">人员管理</span>
                            </a>
                            <ul class="sub-menu animate" style="height: 0px;">
                                <li class="nav-item sub-nav-item" id="subNavItemUserMgr">
                                    <a href="" target="iframe" >
                                        <span class="nav-title">考生信息管理</span>
                                    </a>
                                </li>
                            </ul>
                        </li> --%>
                        <li class="nav-item has-sub-menu" id="navItemCourse">
                            <a title="" class="menu-title" href="javascript:void(0)" data-toggle="tooltip" data-container="body" data-placement="right">
                                <div class="nav-icon">
                                    <i class="icon icon-a_nav_home icon-index">
                                    	<img src="img/成绩管理.png" style="position:absolute;top:10px;left:5px;">
                                    </i>
                                </div>
                                <span class="nav-title">成绩管理</span>
                            </a>
                            <ul class="sub-menu animate" style="height: 0px;">
                                <li class="nav-item sub-nav-item" id="subNavItemFileMgr">
                                    <a href="manager_exam_message.servlet?status=考试已结束" target="iframe">
                                        <span class="nav-title">成绩查询与分析</span>
                                    </a>
                                </li>
                                <li class="nav-item sub-nav-item" id="subNavItemCourseMgr">
                                    <a href="manager_sturesult_exam_message.servlet" target="iframe">
                                        <span class="nav-title">考试成绩统计</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item" id="navItemSystem">
                            <a title="" class="menu-title" target="iframe" href="manager_view_suggest.servlet" data-toggle="tooltip" data-container="body" data-placement="right">
                                <div class="nav-icon">
                                    <i class="icon icon-a_nav_home icon-index">
                                    	<img src="img/用户反馈.png" style="position:absolute;top:10px;left:5px;">
                                    </i>
                                </div>
                                <span class="nav-title">用户反馈</span>
                            </a>
                        </li>
                        <li class="nav-item" id="navItemSystem">
                            <a title="" class="menu-title" href="manager_logout" data-toggle="tooltip" data-container="body" data-placement="right">
                                <div class="nav-icon">
                                    <i class="icon icon-a_nav_home icon-index">
                                    	<img src="img/退出登录.png" style="position:absolute;top:10px;left:5px;">
                                    </i>
                                </div>
                                <span class="nav-title">退出系统</span>
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
			                <iframe class="iframe" name="iframe" src="jsp/manager/manager_home_page.jsp">
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

