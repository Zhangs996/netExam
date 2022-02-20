//删除反馈
function delete_feedback_js() {
	layer.confirm('确认删除吗？', {
		  btn: ['确认', '取消'] //可以无限个按钮
		  
		},function(index, layero){
			//获取tbody元素
			var tbody = document.getElementById("tbody");
			
			//通过tbody获取里面的所有input元素
			var botInpArr = tbody.getElementsByTagName("input");
			
			//获取tbody的rows
			var rows = tbody.rows;
			
			var arr = [];
			
			//遍历所有chechbox,看其是否选中
			for(var i=0;i<botInpArr.length;i++) {
				if(botInpArr[i].checked == true) {
					arr.push(rows[i].cells[1].innerHTML);
				}
			}
			
			location.href = "delete_feedback?delete_arr=" + arr;
		}, function(index){
			  
		});
}

//跳转至指定的分页
function jmp_page() {
	var jmp_page = parseInt(document.getElementById("jmp_page").value);
	var totalPages = parseInt(document.getElementById("totalPages").value);
	if(jmp_page <= totalPages && jmp_page > 0) {
		location.href = "manager_view_suggest.servlet?page=" + jmp_page;
	}
	else {
		document.getElementById("jmp_page").value = "";
		layer.open({
			  title: ''
			  ,content: '页面不存在！'
			});
	}
}

window.onload = function () {
    var topInp = document.getElementById("theadInp");
    var tbody = document.getElementById("tbody");
    var botInpArr = tbody.getElementsByTagName("input");
    var DeleteExam = document.getElementById("DeleteLesson");

    //绑定事件
    topInp.onclick = function () {
        //优化版（被点击的input按钮的checked属性值，直接作为下面的所有的input按钮的checked属性值）
        for(var i=0;i<botInpArr.length;i++){
            botInpArr[i].checked = this.checked;
        }
        if(this.checked == true && botInpArr.length != 0) {
            DeleteExam.className = "delete-button-active";
            DeleteExam.disabled = false;
        }
        else {
            DeleteExam.className = "delete-button";
            DeleteExam.disabled = true;
        }
    }
    for(var i=0;i<botInpArr.length;i++){
        if(botInpArr[i].checked == true) {
            DeleteExam.className = "delete-button-active";
            DeleteExam.disabled = false;
        }
        botInpArr[i].onclick = function () {
            //定义一个标识是true还是false的变量
            //默认它为true
            var bool = true;
            //检测每一个input的checked属性值。
            for(var j=0;j<botInpArr.length;j++){
                if(botInpArr[j].checked == false){
                    bool = false;
                }
            }
            topInp.checked = bool;

            var bool_deletebut = false;
            for(var j=0;j<botInpArr.length;j++){
                if(botInpArr[j].checked == true){
                    bool_deletebut = true;
                }
            }
            DeleteExam.disabled = !bool_deletebut;
            if(bool_deletebut == false) {
                DeleteExam.className = "delete-button";
            }
            else {
                DeleteExam.className = "delete-button-active";
            }
        }
    }
}