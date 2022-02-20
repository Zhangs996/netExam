package action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Map;
import java.util.regex.Pattern;

import com.opensymphony.xwork2.ActionContext;

import dao.StudentDao;
import model.Sturesult;
import model.Suggest;
import model.Student;

import util.RandomSixNumber;
import util.SendMessage;

public class StudentAction {
	private static final long serialVersionUID = 1L;

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	//接收反馈页面的标题和内容
	private Suggest suggest;
	private String title;         //标题
	private String content;  //内容
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	public Suggest getSuggest() {
		return suggest;
	}

	public void setSuggest(Suggest suggest) {
		this.suggest = suggest;
	}
	
	//显示提示信息
	private String message = "";
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	//接收login页面的身份证号或考生号
	private String id;
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	//
	private String cardNo;
	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	
	//
	private String pwd;
	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	//
	private String tel;
	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}


	//图片验证码
	private String captchaText;
	public String getCaptchaText() {
		return captchaText;
	}

	public void setCaptchaText(String captchaText) {
		this.captchaText = captchaText;
	}
	
	//手机验证码
	private String vCode;
	
	public String getvCode() {
		return vCode;
	}

	public void setvCode(String vCode) {
		this.vCode = vCode;
	}
	
	//学生对象
	private Student student;
	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}
	
	//学生Dao对象
	private StudentDao studentdao;
	/*
	public StudentDao getStudentdao() {
		return studentdao;
	}
	*/
	public void setStudentdao(StudentDao studentdao) {
		this.studentdao = studentdao;
	}
	
	//学生成绩
	private Sturesult studentresult;
	
	public Sturesult getStudentresult() {
		return studentresult;
	}

	public void setStudentresult(Sturesult studentresult) {
		this.studentresult = studentresult;
	}
	
	//学生成绩数组
	private ArrayList<Sturesult> studentresults;
	
	public ArrayList<Sturesult> getStudentresults() {
		return studentresults;
	}

	public void setStudentresults(ArrayList<Sturesult> studentresults) {
		this.studentresults = studentresults;
	}

	//学生登录
	public String student_login() {
		ActionContext context = ActionContext.getContext();
		Map<String,Object> session = context.getSession();
		
		Student student1 = (Student)session.get("student");
		if(student1 != null) {
			return "success";
		}
		//验证身份证号的正则表达式
		String pattern = "^[1-9]\\d{5}(18|19|20)\\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
		boolean isMatch = Pattern.matches(pattern, id);
		//flag 表示 id 是考生号 还是身份证号
		int flag;
		if(!isMatch) {
			student.setId(id);
			//flag = 1 表示id是考生号
			flag = 1;
		}
		else {
			student.setCardNo(id);
			//flag = 2 表示id是身份证号
			flag = 2;
		}
		message = studentdao.student_login_hibernate(flag,id,student);
		if(message.equals("")) {
			return "success";
		}
		return "error";
	}
	
	//学生退出登录
	public String student_logout() {
		ActionContext context = ActionContext.getContext();
		Map<String,Object> session = context.getSession();
		Student studentone = (Student)session.get("student");
		student =(Student)studentdao.studentInfo(studentone);
		studentdao.student_logout_hibernate(student);
		session.remove("student");
		return "success";
	}
	
	//学生注册
	public String student_register() {
		message = studentdao.student_register_hibernate(student);
		if(!message.equals("")) {
			return "success";
		}
		message = "您的身份证号码已注册，请直接登录";
		return "error";
	}
	
	//注册成功，显示生成的考生号。
	public String register_success() {
		return "success";
	}
	
	//找回密码
	public String findPassword(){
		ActionContext context = ActionContext.getContext();
		Map<String, Object> session = context.getSession();
		String str = (String) session.get("vCode"); 
		if(str.equals(vCode)){
			studentdao.findPassword(student);
			message = student.getPwd();
			return "success";
		}else{
			message = "手机验证码不正确";
			return "error";
		}
		
	}
	
	//发送手机验证码
	public String sendVCode(){
		if (tel != null)
			System.out.println(tel);
		if (studentdao != null) {
			if(studentdao.validateTel(tel)){
				String vCode = RandomSixNumber.randomSixNumber();
				System.out.println(vCode);
				ActionContext context = ActionContext.getContext();
				Map<String, Object> session = context.getSession();
				session.put("vCode", vCode);
				flag = true;
				SendMessage.sendAMessage(tel, vCode);
			}
		}else{
			System.out.println("dao is null");
			flag = false;
		}
		return "success";
	}
	
	private boolean flag;
	//判断是否发送手机验证码
	public boolean isFlag() {
		return flag;
	}
	
	
	//显示学生主页
	public String list_student_message() {
		ActionContext context = ActionContext.getContext();
		Map<String,Object> session = context.getSession();
		Student studentone = (Student)session.get("student");
		student =(Student)studentdao.studentInfo(studentone);
		return "success";
	}
	
	//查询成绩
	public String studentresult() throws Exception{
		ActionContext context = ActionContext.getContext();
		Map<String, Object> session = context.getSession();
		student = (Student)session.get("student");
		studentresults = new ArrayList<Sturesult>();
		studentresults = studentdao.studentresult_hibernate(student);
		return "success";
	}
	
	//保存反馈信息
	public String save_feedback(){
		ActionContext context = ActionContext.getContext();
		Map<String,Object> session = context.getSession();
		Suggest suggest = new Suggest();
		student = (Student)session.get("student");
		suggest.setStudent(student);
		suggest.setTime(new Timestamp(System.currentTimeMillis()));
		suggest.setContent(content);
		suggest.setTitle(title);
		studentdao.feedback(suggest);
		message="感谢您的宝贵意见！";
		return "success";
	}
	
	
	public String studentInfo(){
		ActionContext context = ActionContext.getContext();
		Map<String,Object> session = context.getSession();
		Student studentone = (Student)session.get("student");
		student =(Student)studentdao.studentInfo(studentone);
		return "success";
	}
	public String studentJump(){
		ActionContext context = ActionContext.getContext();
		Map<String,Object> session = context.getSession();
		Student studentone = (Student)session.get("student");
		student =(Student)studentdao.studentInfo(studentone);
		return "success";
	}
	public String studentupdate(){
		
		studentdao.update_student(student);
		return "success";
	}
	
}
