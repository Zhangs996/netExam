/*function $(id) {
	return document.getElementById(id);
}*/

//手机框失去焦点后验证value值
function oBlur_1() {
	var phone = document.getElementsByTagName("input")[0].value; //手机号
	if (phone == "" || phone == null) { //手机号框value值为空
		document.getElementById("errorInfo").innerHTML = "请输入手机号！";
	} else if (!(/^1[34578]\d{9}$/.test(phone))) {
		document.getElementById("errorInfo").innerHTML = "手机号有误，请重填！";
	} else {
		document.getElementById("errorInfo").innerHTML = "";
		return true;
	}
}
function oBlur_2() {
	var vcode = document.getElementsByTagName("input")[1].value;
	if (vcode == "") {
		document.getElementById("errorInfo").innerHTML = "请输入验证码！";
	}else{
		return true;
	}
}
function oBlur_3() {
	var reg = new RegExp(/[A-Za-z].*[0-9]|[0-9].*[A-Za-z]/);
	var newPassword = document.getElementById("password").value; //新密码
	if (newPassword == "" || newPassword == null) {
		document.getElementById("errorInfo").innerHTML = "新密码不能为空！";
	} else if (newPassword.length < 8) {
		document.getElementById("errorInfo").innerHTML = "密码长度不能小于8位！";
	} else if (!reg.test(newPassword)) {
		document.getElementById("errorInfo").innerHTML = "密码必须由数字和字母组成";
	} else {
		document.getElementById("errorInfo").innerHTML = "";
		return true;
	}
}
function oBlur_4() {
	var verify = document.getElementById("verifyPassword").value; //确认密码
	var newPassword =document.getElementById("password").value;
	if (verify == "" || verify == null) {
		document.getElementById("errorInfo").innerHTML = "请确认密码！";
	} else if (verify != newPassword) {
		document.getElementById("errorInfo").innerHTML = "两次密码不相同";

	} else {
		document.getElementById("errorInfo").innerHTML = "";
		return true;
	}
}
function oBlur_5() {
	var newPassword = document.getElementsByTagName("input")[2].value; //验证码
	if (newPassword == "" || newPassword == null) { //框value值为空
		document.getElementById("errorInfo").innerHTML = "请输入验证码！";
	} else {
		document.getElementById("errorInfo").innerHTML = "";
		return true;
	}
}



window.onload = function() { //页面刷新仍继续计时
	countdown();
}
function sendVCode() {
	$.ajax({
		type : "post",
		url : "sendVCode",
		datatype : "JSON",
		data : {
			"tel" : document.getElementById("tel").value
		},
		success : function(data) {
			var temp = JSON.parse(data);
			if (temp.flag) {
				alert("验证码已发送");
				$.cookie("count", 60); //添加cookie,(期限至浏览器关闭)
				countdown();
			} else {
				alert("此手机号不存在");
			}
		}
	});
}
function countdown() { //倒计时60s后可再次发送验证码
	var count = $.cookie("count");
	if (count == 0 || isNaN(count)) {
		$("#getVCode").attr("onclick", "sendVCode();");
		$("#getVCode").html("获取验证码");
	} else {
		$("#getVCode").attr("onclick", "");
		$("#getVCode").html(count-- + "秒后可重新获取");
		$.cookie("count", count);
		setTimeout(function() {
			countdown();
		}, 1000);
	}
}


//若输入框为空，阻止表单的提交
function getPassword(queryForm) {
	if (oBlur_5() && oBlur_4() && oBlur_3() && oBlur_2() && oBlur_1()) { //框value值都为空
		//document.getElementById("errorInfo").innerHTML = "提交成功！";
		return true; //只有返回true表单才会提交
	} else {
		document.getElementById("errorInfo").innerHTML = "信息输入有误！";
		return false;
	}
}