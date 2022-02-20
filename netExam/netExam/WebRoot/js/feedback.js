//标题框检查
function title_check() {
	var v = document.getElementById("title");
	if (v.value == "") {
		document.getElementById("errorInfo").innerHTML = "标题不能为空！";
		return false;
	}else{
		return true;
	}
}

//内容检查
function oBlur_2() {
	var v = document.getElementById("message");
	if (v.value == "") {
		document.getElementById("errorInfo").innerHTML = "请输入内容！";
		return false;
	}else{
		return true;
	}
}

//若输入框为空，阻止表单的提交
function feedback(submit_feedback) {
	if (oBlur_2() && oBlur_1()) { 
		return true; //只有返回true表单才会提交
	} else {
		document.getElementById("errorInfo").innerHTML = "信息输入有误！";
		return false;
	}
}