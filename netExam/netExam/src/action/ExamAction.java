package action;

import java.util.ArrayList;

import dao.ExamDao;
import model.Exam;

public class ExamAction {
	//显示提示信息
	public String message;
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	//exam对象
	private Exam exam;
	
	public Exam getExam() {
		return exam;
	}

	public void setExam(Exam exam) {
		this.exam = exam;
	}

	//exam的dao对象
	private ExamDao examdao;

	public ExamDao getExamdao() {
		return examdao;
	}

	public void setExamdao(ExamDao examdao) {
		this.examdao = examdao;
	}
	
	//要删除id号的数组
	String delete_arr;
	
	public String getDelete_arr() {
		return delete_arr;
	}

	public void setDelete_arr(String delete_arr) {
		this.delete_arr = delete_arr;
	}
	
	//课程名数组
	ArrayList<String> lesson_names;
	
	public ArrayList<String> getLesson_names() {
		return lesson_names;
	}

	public void setLesson_names(ArrayList<String> lesson_names) {
		this.lesson_names = lesson_names;
	}
	
	//要删除的考试状态
	private String status;
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	//删除考试后跳转的jsp
	private String to_page;

	public String getTo_page() {
		return to_page;
	}

	public void setTo_page(String to_page) {
		this.to_page = to_page;
	}

	//列出可以创建考试的课程
	public String list_select_course() {
		lesson_names =  examdao.list_select_course_hibernate();
		return "success";
	}
	
	//创建考试校验
	public String question_num_validation() {
		return examdao.question_num_validation_hibernate(exam);
	}

	//创建考试
	public String create_exam() {
		examdao.create_exam_hibernate(exam);
		return "success";
	}
	
	//删除考试
	public String delete_exam() {
		//切分从前台传过来的字符串数据
		String[] sourceStrArray = delete_arr.split(",");
        
        //调用delete_exam的dao方法
        examdao.delete_exam_hibernate(sourceStrArray);
		return "success";
	}
	
	//编辑考试（进入考试编辑页面）
	public String edit_exam_one() {
		exam = examdao.edit_exam_one_hibernate(exam);
		lesson_names =  examdao.list_select_course_hibernate();
		return "success";
	}
	
	//编辑考试（修改数据库）
	public String edit_exam() {
		examdao.edit_exam_hibernate(exam);
		return "success";
	}
	
	//终止考试
	public String end_exam() {
		examdao.end_exam_hibernate(exam);
		return "success";
	}
	
	//批量终止考试
	public String ends_exam() {
		//切分从前台传过来的字符串数据
		String[] sourceStrArray = delete_arr.split(",");
        
        //调用delete_exam的dao方法
        examdao.ends_exam_hibernate(sourceStrArray);
		return "success";
	}
	
	//重启考试
	public String restart_exam() {
		examdao.restart_exam_hibernate(exam);
		return "success";
	}
	
	//批量终止考试
	public String restarts_exam() {
		//切分从前台传过来的字符串数据
		String[] sourceStrArray = delete_arr.split(",");
        
        //调用delete_exam的dao方法
        examdao.restarts_exam_hibernate(sourceStrArray);
		return "success";
	}
}
