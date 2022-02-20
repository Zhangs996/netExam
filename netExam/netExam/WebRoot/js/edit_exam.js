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

//单选题道数change事件
function singleNum_change(V) {
	//正则校验是否为纯数字
	if(V.value == "") {
		document.getElementById("singleNum_error").innerHTML = "请输入单选题道数";
		return false;
	}
	var pure_num =  /^[0-9]*$/;
	if(!pure_num.test(V.value)) {
		document.getElementById("singleNum_error").innerHTML = "单选题道数需为数字";
		return false;
	}
	else {
		document.getElementById("singleNum_error").innerHTML = "";
		return true;
	}
}

//单选题分数change事件
function singleScore_change(V) {
	var pure_num =  /^[0-9]+(.[0-9]{1,2})?$/;
	if(!pure_num.test(V.value)) {
		document.getElementById("singleScore_error").innerHTML = "单选题分数需为数字";
		return false;
	}
	else {
		document.getElementById("singleScore_error").innerHTML = "";
		return true;
	}
}

//多选题道数change事件
function moreNum_change(V) {
	//正则校验是否为纯数字
	if(V.value == "") {
		document.getElementById("moreNum_error").innerHTML = "请输入多选题道数";
		return false;
	}
	var pure_num =  /^[0-9]*$/;
	if(!pure_num.test(V.value)) {
		document.getElementById("moreNum_error").innerHTML = "多选题道数需为数字";
		return false;
	}
	else {
		document.getElementById("moreNum_error").innerHTML = "";
		return true;
	}
}

//多选题分数change事件
function moreScore_change(V) {
	var pure_num =  /^[0-9]+(.[0-9]{1,2})?$/;
	if(!pure_num.test(V.value)) {
		document.getElementById("moreScore_error").innerHTML = "多选题分数需为数字";
		return false;
	}
	else {
		document.getElementById("moreScore_error").innerHTML = "";
		return true;
	}
}

//判断题道数change事件
function judgeNum_change(V) {
	//正则校验是否为纯数字
	if(V.value == "") {
		document.getElementById("judgeNum_error").innerHTML = "请输入判断题道数";
		return false;
	}
	var pure_num =  /^[0-9]*$/;
	if(!pure_num.test(V.value)) {
		document.getElementById("judgeNum_error").innerHTML = "判断题道数需为数字";
		return false;
	}
	else {
		document.getElementById("judgeNum_error").innerHTML = "";
		return true;
	}
}

//判断题分数change事件
function judgeScore_change(V) {
	var pure_num =  /^[0-9]+(.[0-9]{1,2})?$/;
	if(!pure_num.test(V.value)) {
		document.getElementById("judgeScore_error").innerHTML = "判断题分数需为数字";
		return false;
	}
	else {
		document.getElementById("judgeScore_error").innerHTML = "";
		return true;
	}
}

//考试时长change事件
function duration_change(V) {
	//正则校验是否为纯数字
	if(V.value == "") {
		document.getElementById("duration_error").innerHTML = "请输入考试时长";
		return false;
	}
	var pure_num =  /^[0-9]*$/;
	if(!pure_num.test(V.value)) {
		document.getElementById("duration_error").innerHTML = "考试时长需为整数";
		return false;
	}
	else {
		document.getElementById("duration_error").innerHTML = "";
		return true;
	}
}

function submit() {
	//获取相关控件
	var lesson = document.getElementById("lesson");
	var level = document.getElementById("level");
	var singleNum = document.getElementById("singleNum");
	var singleScore = document.getElementById("singleScore");
	var moreNum = document.getElementById("moreNum");
	var moreScore = document.getElementById("moreScore");
	var judgeNum = document.getElementById("judgeNum");
	var judgeScore = document.getElementById("judgeScore");
	var duration = document.getElementById("duration");
	
	//
	if(lesson_select(lesson) && level_select(level)
			&& singleNum_change(singleNum) && singleScore_change(singleScore)
			&& moreNum_change(moreNum) && moreScore_change(moreScore)
			&& judgeNum_change(judgeNum) && judgeScore_change(judgeScore)
			&& duration_change(duration)) {
		if((singleNum.value * singleScore.value) + (moreNum.value * moreScore.value)
				+ (judgeNum.value * judgeScore.value) == 100) {
			document.getElementById("submit_exam").submit();
		}
		else {
			document.getElementById("submit_error").innerHTML = "请满足总分为100分";
		}
	}
}

