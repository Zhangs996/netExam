package action;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

import model.Judgequestion;
import dao.JudgeDao;
public class JudgeAction{
	//跳转的jsp
	private String to_page;

	public String getTo_page() {
		return to_page;
	}

	public void setTo_page(String to_page) {
		this.to_page = to_page;
	}
	//question的dao对象
	private Judgequestion judge;
	
	public Judgequestion getJudge() {
		return judge;
	}
	
	File list_add_judge;

	public File getList_add_judge() {
		return list_add_judge;
	}

	public void setList_add_judge(File list_add_judge) {
		this.list_add_judge = list_add_judge;
	}

	public void setJudge(Judgequestion judge) {
		this.judge = judge;
	}

	private JudgeDao judgedao;
	
	public JudgeDao getJudgedao() {
		return judgedao;
	}

	public void setJudgedao(JudgeDao judgedao) {
		this.judgedao = judgedao;
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
    String easy;

    public String getEasy() {
		return easy;
	}

	public void setEasy(String easy) {
		this.easy = easy;
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
			lesson_names =  judgedao.list_select_course_hibernate();
			return "success";
		}
		
	//添加试题
	public String create_judge() {
		judgedao.create_judge_hibernate(judge);
			return "success";
		}
		
	//删除question
	public String delete_judge() {
			//切分从前台传过来的字符串数据
			String[] sourceStrArray = delete_arr.split(",");
	        
	        //调用delete_question的dao方法
			judgedao.delete_judge_hibernate(sourceStrArray);
			return "success";
	}
	//编辑选择题（进入选择题编辑页面）
	public String edit_judge_one() {
		    judge = judgedao.edit_judge_one_hibernate(judge);
			lesson_names =  judgedao.list_select_course_hibernate();
			return "success";
		}
		
	//编辑选择题（修改数据库）
	public String edit_judge() {
		    judgedao.edit_judge_hibernate(judge);
			return "success";
		}
	public String list_add_judge(){
		//得到表格中所有的数据
        List<Judgequestion> listExcel=judgedao.getAllByExcel(list_add_judge);
        //得到数据库表中所有的数据
        for (Judgequestion judge : listExcel) {
            String title=judge.getQuestion();
            Long id = judgedao.isExist(title);
            if (id == -1) {
                //不存在就添加
            	judgedao.listAddJudgeHibernate(judge);
            }else {
                //存在就更新
            	judge.setId(id);
            	judgedao.listUpdateJudgeHibernate(judge);}
        }
        return "success";
	}
}
