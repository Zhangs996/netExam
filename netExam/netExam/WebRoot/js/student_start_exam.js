window.onload = function() {
	var duration = document.getElementById("duration").value;
	var seconds = duration * 60;
	var hour_td = document.getElementById("hour");
	var minute_td = document.getElementById("minute");
	var second_td = document.getElementById("second");
	//让倒计时始终保持两位
	function tow(n) {
        return n >= 0 && n < 10 ? '0' + n : '' + n;
    }
	function getDate() {
		var second = seconds;
        var hour = Math.floor(second / 3600);
        //余数代表 剩下的秒数；
        second %= 3600; 
        var minute = Math.floor(second / 60);
        second %= 60;
        hour_td.innerHTML = tow(hour);
        minute_td.innerHTML = tow(minute);
        second_td.innerHTML = tow(second);
        if(document.getElementById("submit_status").value == "已提交") {
        	clearInterval(timeout);
        }
        else if(hour == 0 && minute == 0 && second == 0) {
        	document.getElementById("submit_status").value = "已提交";
        	clearInterval(timeout);
          	var exam_id = document.getElementById("exam_id").value;
          	
          	layer.open({
  			  title: ''
  			  ,content: '考试时间已到！'
  			});
          	submit(exam_id);
        }
    	seconds--;
    }
    getDate();
    var timeout = setInterval(getDate, 1000);
}

function c_submit(exam_id){
	layer.confirm('确认交卷吗？', {
		  btn: ['确认', '取消'] //可以无限个按钮
		
		},function(index, layero){
			document.getElementById("submit_status").value = "已提交";
			submit(exam_id);
			layer.closeAll('dialog');
		}, function(index){
			  
		});
	/*var tf=confirm("确认交卷吗？");
	if(tf==true){
		submit(exam_id);
	}*/
}
function submit(exam_id) {
	//单选题答案
	var singleAnswers = new Array();
	//单选题的tbody
	var singleTbody = document.getElementById('iframe').contentWindow.document.getElementById('singleTbody');
	//单选题的tr
	var singleTr = singleTbody.getElementsByTagName("tr");
	//被选中的radio
	var singleAnswer = '';
	for(var i = 0;i < singleTr.length;i++) {
		var singleTd = singleTr[i].getElementsByTagName("td");
		var singleInputs = singleTd[0].getElementsByTagName("input");
		var singleInput = singleInputs[0];
		var remainder = (i+1) % 7;
		if(remainder == 1 || remainder == 0) {
			continue;
		}
		else if(remainder == 6) {
			singleAnswer += "-" + singleInput.value;
			singleAnswers.push(singleAnswer);
			singleAnswer = '';
		}
		else {
			if(singleInput.checked == true) {
				singleAnswer += singleInput.id;
			}
		}
	}
	
	//多选题答案
	var moreAnswers = new Array();
	//多选题的tbody
	var moreTbody = document.getElementById('iframe').contentWindow.document.getElementById('moreTbody');
	//单选题的tr
	var moreTr = moreTbody.getElementsByTagName("tr");
	//被选中的checkbox
	var moreAnswer = '';
	for(var i = 0;i < moreTr.length;i++) {
		var moreTd = moreTr[i].getElementsByTagName("td");
		var moreInputs = moreTd[0].getElementsByTagName("input");
		var moreInput = moreInputs[0];
		var remainder = (i+1) % 7;
		if(remainder == 1 || remainder == 0) {
			continue;
		}
		else if(remainder == 6) {
			moreAnswer += "-" + moreInput.value;
			moreAnswers.push(moreAnswer);
			moreAnswer = '';
		}
		else {
			if(moreInput.checked == true) {
				moreAnswer += moreInput.id;
			}
		}
	}
	
	//判断题答案
	var judgeAnswers = new Array();
	//判断题的tbody
	var judgeTbody = document.getElementById('iframe').contentWindow.document.getElementById('judgeTbody');
	//判断题的tr
	var judgeTr = judgeTbody.getElementsByTagName("tr");
	//被选中的radio
	var judgeAnswer = '';
	for(var i = 0;i < judgeTr.length;i++) {
		var judgeTd = judgeTr[i].getElementsByTagName("td");
		var judgeInputs = judgeTd[0].getElementsByTagName("input");
		var judgeInput = judgeInputs[0];
		var remainder = (i+1) % 5;
		if(remainder == 1 || remainder == 0) {
			continue;
		}
		else if(remainder == 4) {
			judgeAnswer += "-" + judgeInput.value;
			judgeAnswers.push(judgeAnswer);
			judgeAnswer = '';
		}
		else {
			if(judgeInput.checked == true) {
				judgeAnswer += judgeInput.id;
			}
		}
	}
	
	hand(exam_id,singleAnswers,moreAnswers,judgeAnswers);
}

function hand(exam_id,singleAnswers,moreAnswers,judgeAnswers) {
	$.ajax({
		type : "post",
		url : "submit_exam",
		datatype : "JSON",
		data : {
			"exam_id" : exam_id,
			"singleArray" : singleAnswers,
			"moreArray" : moreAnswers,
			"judgeArray" : judgeAnswers
		},
		traditional : true,
		success : function(data) {
			var temp = JSON.parse(data);
			document.getElementById('td1').textContent="总得分：";
			document.getElementById('td2').textContent=temp.totalScore;
			
			document.getElementById('submit').textContent="返回";
			document.getElementById('submit-a').removeAttribute('onclick');
			document.getElementById('submit-a').href = "student_login";
			
			//document.getElementById('submit').textContent="返回";
			//document.getElementById('submit').onclick='javascript:history.go(-1);';
			show_answer(temp.singleAnswers,temp.moreAnswers,temp.judgeAnswers);
		}
	});
}

function show_answer(singleAnswers,moreAnswers,judgeAnswers){
	//单选题的tbody
	var singleTbody = document.getElementById('iframe').contentWindow.document.getElementById('singleTbody');
	//单选题的tr
	var singleTr = singleTbody.getElementsByTagName("tr");
	var a=0;
	for(var i = 0;i < singleTr.length;i++) {
		var singleTd = singleTr[i].getElementsByTagName("td");
		var singleInputs = singleTd[0].getElementsByTagName("input");
		var singleInput = singleInputs[0];
		var remainder = (i+1) % 7;
		if(remainder == 1 || remainder == 0) {
			continue;
		}
		else if(remainder == 6) {
			singleInput.type="text";
			singleInput.value="正确答案："+singleAnswers[a++];
			singleInput.disabled="true";
		}
		else {
			singleInput.disabled="true";
		}
	}
	//多选题的tbody
	var moreTbody = document.getElementById('iframe').contentWindow.document.getElementById('moreTbody');
	//单选题的tr
	var moreTr = moreTbody.getElementsByTagName("tr");
	var b=0;
	for(var i = 0;i < moreTr.length;i++) {
		var moreTd = moreTr[i].getElementsByTagName("td");
		var moreInputs = moreTd[0].getElementsByTagName("input");
		var moreInput = moreInputs[0];
		var remainder = (i+1) % 7;
		if(remainder == 1 || remainder == 0) {
			continue;
		}
		else if(remainder == 6) {
			moreInput.type="text";
			moreInput.value="正确答案："+moreAnswers[b++];
			moreInput.disabled="true";
		}
		else {
			moreInput.disabled="true";
		}
	}
	//判断题的tbody
	var judgeTbody = document.getElementById('iframe').contentWindow.document.getElementById('judgeTbody');
	//判断题的tr
	var judgeTr = judgeTbody.getElementsByTagName("tr");
	var c=0;
	for(var i = 0;i < judgeTr.length;i++) {
		var judgeTd = judgeTr[i].getElementsByTagName("td");
		var judgeInputs = judgeTd[0].getElementsByTagName("input");
		var judgeInput = judgeInputs[0];
		var remainder = (i+1) % 5;
		if(remainder == 1 || remainder == 0) {
			continue;
		}
		else if(remainder == 4) {
			judgeInput.type="text";
			judgeInput.value="正确答案："+judgeAnswers[c++];
			judgeInput.disabled="true";
		}
		else {
			judgeInput.disabled="true";
		}
	}
}
