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
//答案选择下拉框单击事件
function answer_select(V) {
	//判断是否选择了课程
	if(V.options[0].value == V.options[V.selectedIndex].value) {
		document.getElementById("answer_error").innerHTML = "请选择答案";
		return false;
	}
	else {
		document.getElementById("answer_error").innerHTML = "";
		return true;
	}
}

//答案选择下拉框change事件
function answer_change(V) {
	//选择课程后改变字体颜色
	V.style.color="#000000";
	document.getElementById("answer_error").innerHTML = "";
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

//题目内容change事件
function question_change(V) {
	if(V.value == "") {
		document.getElementById("question_error").innerHTML = "题目不能为空";
		return false;
	}
	document.getElementById("question_error").innerHTML = "";
	return true;
}

function submit() {
	//获取相关控件
	var lesson = document.getElementById("lesson");
	var level = document.getElementById("level");
	var answer=document.getElementById("answer");
	var question = document.getElementById("question");
	//
	if(lesson_select(lesson) && level_select(level) && question_change(question) && answer_select(answer)){

          document.getElementById("submit_judge").submit();
		
	}
}