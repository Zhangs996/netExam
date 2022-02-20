function $(id){
    return document.getElementById(id);
}

function check_id() {
    var id = $("id").value;
    if (id == "") {
        $("message").innerHTML = "ID号不能为空";
    }
    else {
        $("message").innerHTML = "";
        return true;
        /*$("manager_login").removeAttribute("disabled");
        $("manager_login").setAttribute('style','cursor:pointer');*/
    }
}

function check_pwd() {
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
        /*$("manager_login").removeAttribute("disabled");
        $("manager_login").setAttribute('style','cursor:pointer');*/
    }
}

function submit_manager() {
	if(check_id() && check_pwd()) {
		document.getElementById("submit_manager").submit();
	}
}