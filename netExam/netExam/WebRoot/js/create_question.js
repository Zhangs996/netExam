//课程选择下拉框单击事件
function lesson_select(V) {
	//判断是否选择了课程
	if(V.options[0].value == V.options[V.selectedIndex].value) {
		document.getElementById("lesson_error").innerHTML = "请选择课程";
		return false;
	}
	else {
		document.getElementById("lesson_error").innerHTML = "";
		return true;
	}
}

//课程选择下拉框change事件
function lesson_change(V) {
	//选择课程后改变字体颜色
	V.style.color="#000000";
	document.getElementById("lesson_error").innerHTML = "";
}

//难度选择下拉框单击事件
function level_select(V) {
	//判断是否选择了难度
	if(V.options[0].value == V.options[V.selectedIndex].value) {
		document.getElementById("level_error").innerHTML = "请选择难度";
		return false;
    }
    else {
    	document.getElementById("level_error").innerHTML = "";
    	return true;
    }
}

//难度选择下拉框change事件
function level_change(V) {
	//选择难度后改变字体颜色
	V.style.color="#000000";
	document.getElementById("level_error").innerHTML = "";
}
//题目类型选择下拉框单击事件
function type_select(V) {
	//判断是否选择了题目类型
	if(V.options[0].value == V.options[V.selectedIndex].value) {
		document.getElementById("type_error").innerHTML = "请选择题目类型";
		return false;
  }
  else {
  	document.getElementById("type_error").innerHTML = "";
  	return true;
  }
}

//题目类型选择下拉框change事件
function type_change(V) {
	//选择难度后改变字体颜色
	V.style.color="#000000";
	document.getElementById("type_error").innerHTML = "";
}

//题目内容change事件
function question_change(V) {
	if(V.value == "") {
		document.getElementById("question_error").innerHTML = "题目不能为空";
		return false;
	}
	document.getElementById("question_error").innerHTML = "";
	return true;
}

//optionA的change事件
function optionA_change(V) {
	if(V.value == "") {
		document.getElementById("optionA_error").innerHTML = "选项A不能为空";
		return false;
	}
	document.getElementById("optionA_error").innerHTML = "";
	return true;
}

//optionB的change事件
function optionB_change(V) {
	if(V.value == "") {
		document.getElementById("optionB_error").innerHTML = "选项B不能为空";
		return false;
	}
	document.getElementById("optionB_error").innerHTML = "";
	return true;
}


//optionC的change事件
function optionC_change(V) {
	if(V.value == "") {
		document.getElementById("optionC_error").innerHTML = "选项C不能为空";
		return false;
	}
	document.getElementById("optionC_error").innerHTML = "";
	return true;
}

//optionD的change事件
function optionD_change(V) {
	if(V.value == "") {
		document.getElementById("optionD_error").innerHTML = "选项D不能为空";
		return false;
	}
	document.getElementById("optionD_error").innerHTML = "";
	return true;
}

//answer的change事件
function answer_change(V) {
	var type = document.getElementById("type");
	
	var pure_num1 = /^[A-D]{1}$/;
	var pure_num2 = /^[A-D]{2,4}$/;
	var pure_num;
	if(type.value == "") {
		document.getElementById("type_error").innerHTML = "请选择题目类型";
		return false;
	}
	else if(type.value == "单选题") {
		pure_num = pure_num1;
	}
	else {
		pure_num = pure_num2;
	}
	
	if(V.value == "") {
		document.getElementById("answer_error").innerHTML = "答案不能为空";
		return false;
	}
    if(pure_num.test(V.value)) {
    	document.getElementById("answer_error").innerHTML = "";
    	return true;
	}
	else {
		document.getElementById("answer_error").innerHTML = "请满足输入要求";
		return false;
	}
}
function submit() {
	//获取相关控件
	var lesson = document.getElementById("lesson");
	var level = document.getElementById("level");
	var type = document.getElementById("type");
	var question = document.getElementById("question");
	var optionA = document.getElementById("optionA");
	var optionB = document.getElementById("optionB");
	var optionC = document.getElementById("optionC");
	var optionD = document.getElementById("optionD");
	var answer = document.getElementById("answer");
	//
	if(lesson_select(lesson) && level_select(level) && type_select(type)
			&& question_change(question) && optionA_change(optionA)
			&& optionB_change(optionB) && optionC_change(optionC)
			&& optionD_change(optionD) && answer_change(answer)){
        	document.getElementById("submit_question").submit();
	}
}

function return_home() {
	var to_page = document.getElementById("to_page").value;
	if(to_page == "home") {
		location.href = "jsp/manager/manager_home_page.jsp";
	}
	else {
		location.href = "manager_question.servlet";
	}
}