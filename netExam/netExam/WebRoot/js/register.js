function $(id){
    return document.getElementById(id);
}

function check_username() {
    var username = $("username").value;
    if (username == "") {
        $("message").innerHTML = "姓名不能为空";
    }
    else {
    	$("message").innerHTML = "";
    	return true;
    }
}

function check_cardid() {
	var cardid = $("cardid").value;
	var iscardid = /^[1-9]\d{5}(18|19|20)\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
	if (cardid == "") {
        $("message").innerHTML = "身份证号不能为空";
    }
    else if (!iscardid.test(cardid)) {
        $("message").innerHTML = "身份证号不合法";
    }
    else {
    	$("message").innerHTML = "";
    	return true;
    }
}

function check_password() {
	var password = $("password").value;
	if (password == "") {
        $("message").innerHTML = "密码不能为空";
    }
    else if (password.length < 6) {
        $("message").innerHTML = "密码不能少于6位";
    }
    else {
    	$("message").innerHTML = "";
    	return true;
    }
}

function check_password1() {
	var password = $("password").value;
	var password1 = $("password1").value;
	if (password1 == "") {
        $("message").innerHTML = "确认密码不能为空";
    }
    else if (password1.length < 6) {
        $("message").innerHTML = "确认密码不能少于6位";
    }
    else if (password != password1) {
        $("message").innerHTML = "两次密码不一致";
    }
    else {
    	$("message").innerHTML = "";
    	return true;
    }
}

function submit_register() {
	if(check_username() && check_cardid() && check_password() && check_password1()) {
		document.getElementById("submit_register").submit();
	}
}
