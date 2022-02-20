$(function () {
    // initial tooltip
    $('[data-toggle="tooltip"]').tooltip();
    // initial popover
    $('[data-toggle="popover"]').popover();

    // ajaxstart with loading shown
    $( document ).ajaxStart(function() {
        $("#spinnerLoading").removeClass("hidden");
    });
    // ajaxstop with loading hidden
    $( document ).ajaxStop(function() {
        $("#spinnerLoading").addClass("hidden");
    });
    //创建导航逻辑
    $(function () {
        //读取导航（根据模块权限动态生成）
        if($("#ksxAdminSidebar").length>0){
            $.ajax({
                type: "POST",
                cache : false,
                dataType: "json",
                url: "/admin/getAllRights",
                success: function (msg) {
                    if(msg.success){
                        //生成导航
                        createSidebar(msg.bizContent);
                        //标记当前导航项
                        getActiveNav();
                    }
                }
            })
        }
        //生成导航
        function createSidebar(data) {
            var menuList = [
                {
                    title: '考试管理',
                    icon: 'icon-a_nav_exam',
                    id: 'Exam',
                    subMenu: [
                        {
                            title: '考试信息管理',
                            id: 'ExamMgr',
                            url: getAdminUrlPrefix + '/admin/exam_mgr_new',
                            show: data.allowExamMgr
                        },
                        {
                            title: '试题库',
                            id: 'QuestionMgr',
                            url: getAdminUrlPrefix + '/admin/showtestqm_new',
                            show: data.allowShowtestqm
                        },
                        {
                            title: '试卷库',
                            id: 'PaperMgr',
                            url: getAdminUrlPrefix + '/admin/paper_mgr_new',
                            show: data.allowPaperMgr
                        },
                        {
                            title: '成绩查询批改',
                            id: 'ResultMgr',
                            url: getAdminUrlPrefix + '/admin/result/mgr_new',
                            show: data.allowResultMgr
                        },
                        {
                            title: '统计分析',
                            id: 'ResultAnalysis',
                            url: getAnalysisUrlPrefix + '/admin/results/analysis/exam',
                            show: data.allowAnalysisExam
                        }
                    ]
                },
                {
                    title: '人员管理',
                    icon: 'icon-a_nav_personnel',
                    id: 'User',
                    subMenu: [
                        {
                            title: '考生信息',
                            id: 'UserMgr',
                            url: getStaticUrlPrefix + "/admin/user/#/list",
                            show: data.allowUserMgr
                        },
                        {
                            title: '注册设置',
                            id: 'UserReg',
                            url: getAdminUrlPrefix + '/admin/user_reg',
                            show: data.allowUserReg
                        }
                    ]
                },
                {
                    title: '学习',
                    icon: 'icon-a_nav_study',
                    id: 'Course',
                    subMenu: [
                        {
                            title: '知识库',
                            id: 'FileMgr',
                            url: getAdminUrlPrefix + '/admin/file/manager',
                            show: data.allowFileManager
                        },
                        {
                            title: '课程管理',
                            id: 'CourseMgr',
                            url: getAdminUrlPrefix + '/course/course_mgr',
                            show: data.allowCourseManager
                        },
                        {
                            title: '学习记录',
                            id: 'CourseRecord',
                            url: getAdminUrlPrefix + '/course/study_record_mgr/course',
                            show: data.allowStudyRecord
                        }
                    ]
                },
                {
                    title: '系统管理',
                    icon: 'icon-a_nav_system',
                    id: 'System',
                    subMenu: [
                        {
                            title: '子管理员设置',
                            id: 'SubAdminMgr',
                            url: getAdminUrlPrefix + '/admin/sub_admin_mgr',
                            show: data.allowSubAdminMgr
                        },
                       
                        {
                            title: '管理员操作记录',
                            id: 'OpRecord',
                            url: getAdminUrlPrefix + '/account/admin_op_record',
                            show: data.allowAdminOpRecord
                        }
                    ]
                },
            ];


            for(var i=0; i< menuList.length; i++){
                createNav(menuList[i]);
            }

        }
        //创建一级导航dom
        function createNav(data) {
            var menuDom = $('<li class="nav-item '+(data.subMenu ? 'has-sub-menu' : '')+'"  id="navItem'+data.id+'"></li>');
            var menuHtml =
                '<a href="'+(data.subMenu ? '#' : data.url)+'" class="menu-title" data-toggle="tooltip" data-placement="right" data-container="body" title="'+data.title+'">' +
                '<div class="nav-icon"><i class="icon '+data.icon+'"></i></div>'+
                '<span class="nav-title">'+data.title+'</span>'+
                (data.beta ? '<img class="mark-beta" src="https://cdnoss.kaoshixing.com/ksxing_static/vue/images/icon/a_nav_beta.svg" />' : '') +
                '</a>';


            if(data.subMenu){
                //有二级导航

                var subMenuShowList = data.subMenu;

                //管理员和超管不做过滤，所有二级导航都显示，子管理员限制权限
                if(USER_ROLE=='sub_admin'){
                    subMenuShowList = data.subMenu.filter(function (t) {
                        return t.show;
                    });
                }

                var subMenuDom = $('<ul class="sub-menu animate"></ul>');

                for(var i=0; i< data.subMenu.length; i++){
                    if(data.subMenu[i].show){
                        $(subMenuDom).append(createSubNav(data.subMenu[i]));
                    }
                }

                //若二级导航至少有一个
                if(subMenuShowList.length!=0){
                    $(menuDom).append(menuHtml, subMenuDom);

                    $("#ksxAdminSidebar").append(menuDom);
                }
            }else {
                if(data.id=='Application'){
                    if( data.show ){
                        $(menuDom).append(menuHtml);
                        $("#ksxAdminSidebar").append(menuDom);
                    }
                }else {
                    //无二级导航
                    //beta模块子管理员不可见
                    if(USER_ROLE=='sub_admin'){
                        if(data.show){
                            $(menuDom).append(menuHtml);
                            $("#ksxAdminSidebar").append(menuDom);
                        }
                    }else {
                        $(menuDom).append(menuHtml);
                        $("#ksxAdminSidebar").append(menuDom);
                    }
                }
            }
        }

        //创建二级导航dom
        function createSubNav(data) {
            var subMenuDom = $('<li class="nav-item sub-nav-item" id="subNavItem'+data.id+'"></li>');
            var subMenuHtml =
                '<a href="'+data.url+'">' +
                '<span class="nav-title">'+data.title+'</span>'+
                '</a>';

            $(subMenuDom).append(subMenuHtml);

            return subMenuDom;
        }


        //展开关闭二级导航
        $(".sidebar-trans").on('click', '.nav-item.has-sub-menu .menu-title', function (e) {
            var _this = $(this).parent('.nav-item');
            var subNav = $(_this).find(".sub-menu");
            var subNavLength = $(subNav).find(".sub-nav-item").length;

            //若导航为收起状态，先展开
            if($("#viewFrameWork").hasClass('sidebar-min')){
                $("#sidebar-fold").click();
            }


            if($(_this).hasClass('open')){
                //不做处理
                // $(_this).removeClass('open');
                // $(subNav).css('height', "0px");
            }else {
                $(".sidebar-trans .nav-item.has-sub-menu.open .sub-menu").css('height', "0px");
                $(".sidebar-trans .nav-item.has-sub-menu.open").removeClass('open');

                $(_this).addClass('open');
                $(subNav).css('height', (38*subNavLength + 10) + "px");
            }
        });


        //标记激活导航
        function getActiveNav() {
            var activeDom = $('#'+activeNavItem);

            if(activeDom.length != 0){
                if($(activeDom).hasClass('has-sub-menu')){
                    //有二级导航的一级导航，什么也不做

                }else if($(activeDom).hasClass('sub-nav-item')){
                    //二级导航
                    $(activeDom).parents('.has-sub-menu').find('.menu-title').click();
                    $(activeDom).addClass('nav-item-active');
                }else {
                    //孤独的一级导航
                    $(activeDom).addClass('nav-item-active');
                }

            }
        }
    });
    if($(".sidebar-fold").hasClass("icon-unfold")){
        $('.sidebar-nav [data-toggle="tooltip"]').tooltip('destroy');
    }

    // fold sidebar
    $("#sidebar-fold").click(function(e) {
        e.stopPropagation();
        e.preventDefault();
        if($(this).hasClass("icon-unfold")){
            // fold sidebar
            $(this).removeClass("icon-unfold").addClass("icon-fold").attr("title","展开导航").attr("data-original-title","展开导航");
            $(this).find(".icons8").removeClass("icons8-icon").addClass("icons8-icon-3");
            $(".viewFrameWork").removeClass("sidebar-full").addClass("sidebar-min");
            document.cookie = "ksxFoldState=fold; path =; domain=;";
            $('.sidebar-inner [data-toggle="tooltip"]').tooltip();

            //收起二级导航
            $(".sidebar-trans .nav-item.has-sub-menu").removeClass('open');
            $(".sidebar-trans .nav-item.has-sub-menu .sub-menu").css('height', "0px");
        }else if ($(this).hasClass("icon-fold")) {
            // unfold sidebar
            $(this).removeClass("icon-fold").addClass("icon-unfold").attr("title","收起导航").attr("data-original-title","收起导航");
            $(this).find(".icons8").removeClass("icons8-icon-3").addClass("icons8-icon");
            $(".viewFrameWork").removeClass("sidebar-min").addClass("sidebar-full");
            document.cookie = "ksxFoldState=unfold; path =; domain=;";
            /*$('.sidebar-inner [data-toggle="tooltip"]').tooltip();*/
            $('.sidebar-nav [data-toggle="tooltip"]').tooltip('destroy');
        }
    });
    //初始化系统消息
    var POPOVER_HTML = '';
    $.ajax({
        type:'POST',
        cache : false,
        headers: { "cache-control": "no-cache" },
        dataType: "json",
        url: '/account/notification/',
        success:function (msg) {
            var tool_count=msg.bizContent.unreadCount;
            //样式调整，先注释
            /*var tool_html = '';

            if(tool_count==0){
                tool_html = '<span>暂无消息</span>'
            }*/

            // 未读标志
            if(tool_count>9){
                $('#stateMessage .message-count').text('9+').removeClass('hidden');
            }else if (tool_count>0) {
                $('#stateMessage .message-count').text(tool_count).removeClass('hidden');
            }else {
                $('#stateMessage .message-count').addClass('hidden');
            }
            // notifications是最新的消息，最多为5条，添加支消息框
            for (var i = 0; i <msg.bizContent.notifications.length; i++) {
                var content=msg.bizContent.notifications[i].content;
                if(msg.bizContent.notifications[i].isRead==0){//若状态为未读添加未读类
                    tool_html+='<div class="message unread" id="'+msg.bizContent.notifications[i].id+'">'+
                        '<span class="glyphicon glyphicon-volume-up" aria-hidden="true"></span>'
                        +content+'</div>';
                }else {
                    tool_html+='<span class="message read" id="'+msg.bizContent.notifications[i].id+'">'+content+'</span><br>';
                }
            }

            // 如果所有消息中未读消息的数目不为0，则显示有未读消息的标志
            if (tool_count != 0) {
                $(".hasUnread").css("display","inline-block");
            }else {
                $(".hasUnread").hide();
            }

            POPOVER_HTML = tool_html;

        }
    });
    // 若点击消息内部链接，则认为消息已读
    $("body").on('click', "#stateMessageSection .unread a", function () {
        var notification_id = $(this).parent(".unread").attr("id");
        $.ajax({
            type:'POST',
            cache : false,
            headers: { "cache-control": "no-cache" },
            dataType: "json",
            url: '/account/read_notification/',
            data: 'ids='+notification_id,
            success:function (msg) {}
        })
    });


    $("#stateMessage").click(function(){
        window.location.href="/account/notification/";
    });
});
// set cookie
function setCookie(c_name,value){
    document.cookie=c_name+ "=" +escape(value);
}

// get cookie
function getCookie(c_name){
    if(document.cookie.length>0){
        c_start=document.cookie.indexOf(c_name + "=")
        if(c_start!=-1){
            c_start=c_start + c_name.length+1;
            c_end=document.cookie.indexOf(";",c_start);
            if (c_end==-1){
                c_end=document.cookie.length
            }
            return unescape(document.cookie.substring(c_start,c_end));
        }
    }
    return "";
}

//保存 search 条件
function setSearchCookie(cName, obj){
    var expiresTime = new Date();
    expiresTime.setTime(expiresTime.getTime() + (24 * 60 * 60 * 1000));
    var cookieStr = "";
    for(var itemName in obj){//用javascript的for/in循环遍历对象的属性
        if(obj[itemName] != ""){
            cookieStr += itemName + "=" + obj[itemName] + "&&";
        }
    }
    cookieStr = cName + "=" + escape(cookieStr) + ";" + "expires=" + expiresTime.toUTCString();
    document.cookie = cookieStr;
}

//删除 cookie
function delCookie(cName) {
    document.cookie=cName+"='';"
}
//获取 search 条件
function getSearchCookie(cName, itemName){
    if(document.cookie.length>0){
        var itemValue = "";
        var cStart=document.cookie.indexOf(cName + "=");
        if(cStart!=-1){
            cStart=cStart + cName.length+1;
            c_end=document.cookie.indexOf(";",cStart);
            if (c_end==-1){
                c_end=document.cookie.length
            }
            itemValue = unescape(document.cookie.substring(cStart,c_end));
            var itemStart = itemValue.indexOf(itemName + "=");
            if(itemStart > -1){
                var itemEnd = itemValue.indexOf("&&",itemStart);
                itemValue = itemValue.substring(itemStart+itemName.length+1, itemEnd);
                return itemValue;
            }else {
                return "";
            }
        }
    }
    return "";
}
// 退出登录(清空cookie,session&&sessionId)
$("#logoutBtn").click(function (e) {
    e.stopPropagation();
    e.preventDefault();

    $.ajax({
        type: "POST",
        cache : false,
        dataType: "json",
        url: "/account/logout",
        success: function(msg){
            var jump_url = msg.bizContent.url;
            window.location.href = jump_url;
        }
    });

})