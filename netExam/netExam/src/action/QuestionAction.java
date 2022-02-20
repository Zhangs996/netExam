package action;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import model.Lesson;
import model.Optionalquestion;
import dao.QuestionDao;
public class QuestionAction{
	//跳转的jsp
	private String to_page;

	public String getTo_page() {
		return to_page;
	}

	public void setTo_page(String to_page) {
		this.to_page = to_page;
	}
	//question的dao对象
	private Optionalquestion question;
	
	public Optionalquestion getQuestion() {
		return question;
	}

	public void setQuestion(Optionalquestion question) {
		this.question = question;
	}
    File list_add_question;
    
	
	public File getList_add_question() {
		return list_add_question;
	}

	public void setList_add_question(File list_add_question) {
		this.list_add_question = list_add_question;
	}
	private QuestionDao questiondao;

	public QuestionDao getQuestiondao() {
		return questiondao;
	}

	public void setQuestiondao(QuestionDao questiondao) {
		this.questiondao = questiondao;
	}
	//删除id号数组
	String delete_arr;
		
	public String getDelete_arr() {
			return delete_arr;
		}

	public void setDelete_arr(String delete_arr) {
			this.delete_arr = delete_arr;
		}
	//查找单选题
    String single;

		public String getSingle() {
		return single;
	}

	public void setSingle(String single) {
		this.single = single;
	}
    ArrayList<String> lesson_names;
	
	public ArrayList<String> getLesson_names() {
		return lesson_names;
	}

	public void setLesson_names(ArrayList<String> lesson_names) {
		this.lesson_names = lesson_names;
	}
	//列出可以创建考试的课程
	public String list_select_course() {
			lesson_names =  questiondao.list_select_course_hibernate();
			return "success";
		}
		
	//添加试题
	public String create_question() {
		questiondao.create_question_hibernate(question);
			return "success";
		}
		
	//删除question
	public String delete_question() {
			//切分从前台传过来的字符串数据
			String[] sourceStrArray = delete_arr.split(",");
	        
	        //调用delete_question的dao方法
	        questiondao.delete_question_hibernate(sourceStrArray);
			return "success";
	}
	//编辑选择题（进入选择题编辑页面）
	public String edit_question_one() {
		    question = questiondao.edit_question_one_hibernate(question);
			lesson_names =  questiondao.list_select_course_hibernate();
			return "success";
		}
		
	//编辑选择题（修改数据库）
	public String edit_question() {
		    questiondao.edit_question_hibernate(question);
			return "success";
		}
	@SuppressWarnings("unused")
	public String list_add_question(){
		//得到表格中所有的数据
        List<Optionalquestion> listExcel=questiondao.getAllByExcel(list_add_question);
        //得到数据库表中所有的数据
        for (Optionalquestion question : listExcel) {
        	Lesson lesson = question.getLesson();
            String title=question.getQuestion();
            Long id = questiondao.isExist(title);
            if (id == -1) {
                //不存在就添加
            	questiondao.listAddQuestionHibernate(question);
            }else {
                //存在就更新
            	question.setId(id);
            	questiondao.listUpdateQuestionHibernate(question);}
        }
        return "success";
	}
	
	@SuppressWarnings("unused")
	private String singleArray;
	@SuppressWarnings("unused")
	private String moreArray;
	@SuppressWarnings("unused")
	private String judgeArray;
	
	public void setSingleArray(String singleArray) {
		this.singleArray = singleArray;
	}

	public void setMoreArray(String moreArray) {
		this.moreArray = moreArray;
	}

	public void setJudgeArray(String judgeArray) {
		this.judgeArray = judgeArray;
	}

	public String test() {
		return "success";
	}
	
}
