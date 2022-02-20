function load(){
	var timeout_num = 0;         //超过timefly/1000秒未操作此界面次数
    var timefly =1000*10;         //超时时间
    document.onmousemove = retime;        //当鼠标移动时的时间
    document.onmousewheel=retime;			 //当鼠标滚轮时的时间	
    if(document.addEventListener){
        document.addEventListener('DOMMouseScroll',retime,false);
    }//W3C
    document.onkeypress = retime;        //当鼠标点击重新获取当前时间放入变量作为初始时间
    var jum = setTimeout(jump,timefly);  //间隔指定时间后执行jump函数
    function retime(){
		clearTimeout(jum);
		jum=setTimeout(jump,timefly); 
    }
    function jump(){
    	if(window.parent.document.getElementById("submit_status").value != "已提交") {
    		if(timeout_num > 1) {
		    	window.parent.document.getElementById("submit_status").value = "已提交";
		    	layer.open({
					  title: ''
					  ,content: '你已超过两次'+timefly/1000+'秒未操作此界面,已强制提交！！'
					});
		//    	alert("你已超过"+timefly/1000+"秒未操作此界面,将对你的试卷进行强制提交！！！");
		    	//单选题答案
		    	var singleAnswers = new Array();
		    	//单选题的tbody
		    	var singleTbody = document.getElementById('singleTbody');
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
		    	var moreTbody = document.getElementById('moreTbody');
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
		    	var judgeTbody = document.getElementById('judgeTbody');
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
		    	
		    	var exam_id = document.getElementById("exam_id").value;
		    	hand(exam_id,singleAnswers,moreAnswers,judgeAnswers); 
    		}
    		else {
    			timeout_num++;
    			layer.open({
					  title: ''
					  ,content: '你已' +timeout_num+ '次'+timefly/1000+'秒未操作此界面,超过两次将强制提交！！'
					});
    		}
    	}
    }
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
			window.parent.document.getElementById('td1').textContent="总得分：";
			window.parent.document.getElementById('td2').textContent=temp.totalScore;
			
			window.parent.document.getElementById('submit').textContent="返回";
			window.parent.document.getElementById('submit-a').removeAttribute('onclick');
			window.parent.document.getElementById('submit-a').href = "student_login";
			
			//document.getElementById('submit').textContent="返回";
			//document.getElementById('submit').onclick='javascript:history.go(-1);';
			show_answer(temp.singleAnswers,temp.moreAnswers,temp.judgeAnswers);
		}
	});
}
function show_answer(singleAnswers,moreAnswers,judgeAnswers){
	//单选题的tbody
	var singleTbody = document.getElementById('singleTbody');
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
	var moreTbody = document.getElementById('moreTbody');
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
	var judgeTbody = document.getElementById('judgeTbody');
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