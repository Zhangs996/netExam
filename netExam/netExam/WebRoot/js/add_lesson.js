//判断是否为空
function lesson_name_change(V) {
	if(V.value == "") {
		document.getElementById("lesson_error").innerHTML = "课程名不能为空！";
		return false;
	}
	else {
		document.getElementById("lesson_error").innerHTML = "";
		return true;
	}
}

function submit() {
	//获取相关控件
	var lesson = document.getElementById("add_lesson");
	if(lesson_name_change(lesson)) {
		document.getElementById("submit_lesson").submit();
	}
}

function return_home() {
	var to_page = document.getElementById("to_page").value;
	if(to_page == "home") {
		location.href = "jsp/manager/manager_home_page.jsp";
	}
	else {
		location.href = "manager_lesson_message.servlet";
	}
}
