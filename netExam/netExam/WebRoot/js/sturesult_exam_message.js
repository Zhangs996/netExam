//搜索框得到焦点，改变其样式
function search_onfcus() {
	document.getElementById("condition").className = "tool-search-active";
}

//搜索框失去焦点，改变其样式
function search_onblur() {
	document.getElementById("condition").className = "tool-search-input";
}

//点击查询图片，实现查询
function search() {
	location.href = "manager_sturesult_exam_message.servlet?condition=" + document.getElementById("condition").value;
}

//跳转至指定的分页
function jmp_page() {
	var jmp_page = parseInt(document.getElementById("jmp_page").value);
	var totalUsers = parseInt(document.getElementById("totalUsers").value);
	var totalPages = parseInt(document.getElementById("totalPages").value);
	if(jmp_page <= totalPages && jmp_page > 0) {
		location.href = "manager_sturesult_exam_message.servlet?page=" + jmp_page + "&totalUsers=" + totalUsers;;
	}
	else {
		document.getElementById("jmp_page").value = "";
		layer.open({
			  title: ''
			  ,content: '页面不存在！'
			});
	}
}
