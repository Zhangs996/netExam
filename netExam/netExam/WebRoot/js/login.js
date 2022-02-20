function $(id){
    return document.getElementById(id);
}

function check_id() {
    var id = $("id").value;
    if (id == "") {
        $("message").innerHTML = "考生号或身份证号不能为空";
    }
    else {
        $("message").innerHTML = "";
        return true;
        /*
        $("login").removeAttribute("disabled");
        $("login").setAttribute('style','cursor:pointer');
        */
    }
}

function check_pwd() {
    var password = $("password").value;
    if (password == "") {
        $("message").innerHTML = "密码不能为空";
    }
    else {
        $("message").innerHTML = "";
        return true;
        /*
        $("login").removeAttribute("disabled");
        $("login").setAttribute('style','cursor:pointer');
        */
    }
}

function submit_student() {
	if(check_id() && check_pwd()) {
		document.getElementById("submit_student").submit();
	}
}