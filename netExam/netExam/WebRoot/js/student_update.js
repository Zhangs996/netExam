function submit() {
	//获取相关控件
	           var name=document.getElementById("name");
	           var id=document.getElementById("id");
	           var tel=document.getElementById("tel");
	           if(check_username(name)&&check_cardid(id)&&check_tel(tel)){
				document.getElementById("submit_student").submit();
	           }
               
}
function check_username(V) {
     var name_error=document.getElementById("name_error");
    if (V.value == "") {
       name_error.innerHTML = "姓名不能为空";
       return false;
    }
    else {
    	name_error.innerHTML = "";
    	return true;
    }
}

function check_cardid(V) {
	var cardid = V.value;
	var iscardid = /^[1-9]\d{5}(18|19|20)\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
	var id_error=document.getElementById("id_error");
	if (cardid == "") {
		id_error.innerHTML = "身份证号不能为空";
		return false;
    }
    else if (!iscardid.test(cardid)) {
    	id_error.innerHTML = "身份证号不合法";
    	return false;
    }
    else {
    	id_error.innerHTML = "";
    	return true;
    }
}
function check_tel(V){
	var tel = V.value;
	var istel = /^1([38]\d|5[0-35-9]|7[3678])\d{8}$/;
	var tel_error=document.getElementById("tel_error");
	if (tel == "") {
		tel_error.innerHTML = "电话不能为空";
		return false;
    }
    else if (!istel.test(tel)) {
    	tel_error.innerHTML = "请输入正确的电话号码";
    	return false;
    }
    else {
    	tel_error.innerHTML = "";
    	return true;
    }
}
