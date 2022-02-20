package action;

import java.util.ArrayList;
import java.util.Map;
import java.util.Random;

import org.apache.struts2.json.annotations.JSON;

import com.opensymphony.xwork2.ActionContext;

import dao.EnterExamDao;
import model.Exam;
import model.Judgequestion;
import model.Optionalquestion;
import model.Student;
import model.Sturesult;

public class StartExamAction {
	private String message;

	private Exam exam;
	private double[] score;//用于存放各题型的分数
	private ArrayList<Optionalquestion> single=new ArrayList<Optionalquestion>();//用于存放单选题
	private ArrayList<Optionalquestion> multi=new ArrayList<Optionalquestion>();//用于存放多选题
	private ArrayList<Judgequestion> judge=new ArrayList<Judgequestion>();//用于存放判断题
	private EnterExamDao enterExamDao;
	
	private String exam_id;
	private String singleArray;
	private String moreArray;
	private String judgeArray;
	private Sturesult sturesult;
	private double totalScore;
	
	private String[] singleAnswers;
	private String[] moreAnswers;
	private String[] judgeAnswers;
	
	public String[] getSingleAnswers() {
		return singleAnswers;
	}

	public String[] getMoreAnswers() {
		return moreAnswers;
	}

	public String[] getJudgeAnswers() {
		return judgeAnswers;
	}

	public double getTotalScore() {
		return totalScore;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	public void setExam_id(String exam_id) {
		this.exam_id = exam_id;
	}
	
	@JSON(serialize=false)
	public Sturesult getSturesult() {
		return sturesult;
	}

	public void setSturesult(Sturesult sturesult) {
		this.sturesult = sturesult;
	}

	public void setSingleArray(String singleArray) {
		this.singleArray = singleArray;
	}

	public void setMoreArray(String moreArray) {
		this.moreArray = moreArray;
	}

	public void setJudgeArray(String judgeArray) {
		this.judgeArray = judgeArray;
	}

	@JSON(serialize=false)
	public EnterExamDao getEnterExamDao() {
		return enterExamDao;
	}

	public void setEnterExamDao(EnterExamDao enterExamDao) {
		this.enterExamDao = enterExamDao;
	}

	@JSON(serialize=false)
	public ArrayList<Optionalquestion> getSingle() {
		return single;
	}

	public void setSingle(ArrayList<Optionalquestion> single) {
		this.single = single;
	}

	@JSON(serialize=false)
	public ArrayList<Optionalquestion> getMulti() {
		return multi;
	}

	public void setMulti(ArrayList<Optionalquestion> multi) {
		this.multi = multi;
	}

	@JSON(serialize=false)
	public ArrayList<Judgequestion> getJudge() {
		return judge;
	}

	public void setJudge(ArrayList<Judgequestion> judge) {
		this.judge = judge;
	}
	
	@JSON(serialize=false)
	public Exam getExam() {
		return exam;
	}

	public void setExam(Exam exam) {
		this.exam = exam;
	}

	@JSON(serialize=false)
	public double[] getScore() {
		return score;
	}

	public void setScore(double[] score) {
		this.score = score;
	}

	//暂存各类题型
	ArrayList<Judgequestion> judgesimple;
	ArrayList<Judgequestion> judgemiddle;
	ArrayList<Judgequestion> judgehard;
	ArrayList<Optionalquestion> optionsinglesimple;
	ArrayList<Optionalquestion> optionsinglemiddle;
	ArrayList<Optionalquestion> optionsinglehard;
	ArrayList<Optionalquestion> optionmultisimple;
	ArrayList<Optionalquestion> optionmultimiddle;
	ArrayList<Optionalquestion> optionmultihard;
	//每种题的个数
	int jsnum,jmnum,jhnum,ossnum,osmnum,oshnum,omsnum,ommnum,omhnum;
	
	protected void setNum(double d1,double d2){
		jsnum=(int)(exam.getJudgeNum()*d1);
		jhnum=(int)(exam.getJudgeNum()*d2);
		jmnum=exam.getJudgeNum()-jsnum-jhnum;
		ossnum=(int)(exam.getSingleNum()*d1);
		oshnum=(int)(exam.getSingleNum()*d2);
		osmnum=exam.getSingleNum()-ossnum-oshnum;
		omsnum=(int)(exam.getMoreNum()*d1);
		omhnum=(int)(exam.getMoreNum()*d2);
		ommnum=exam.getMoreNum()-omsnum-omhnum;
	}
	protected void getList(){
		judgesimple=enterExamDao.judge(exam.getLesson().getId(), "简单");
		judgemiddle=enterExamDao.judge(exam.getLesson().getId(), "中等");
		judgehard=enterExamDao.judge(exam.getLesson().getId(), "困难");
		optionsinglesimple=enterExamDao.option(exam.getLesson().getId(), "单选题", "简单");
		optionsinglemiddle=enterExamDao.option(exam.getLesson().getId(), "单选题", "中等");
		optionsinglehard=enterExamDao.option(exam.getLesson().getId(), "单选题", "困难");
		optionmultisimple=enterExamDao.option(exam.getLesson().getId(), "多选题", "简单");
		optionmultimiddle=enterExamDao.option(exam.getLesson().getId(), "多选题", "中等");
		optionmultihard=enterExamDao.option(exam.getLesson().getId(), "多选题", "困难");
	}
	//随机从题库选择试题生成试卷
	@SuppressWarnings("null")
	protected void generate(){
		Random random=new Random();
		
		//随机生成判断题
		int indexs[] = new int[100];
		for(int i=0;i<jsnum;){
			int index=random.nextInt(judgesimple.size());
			int j=0;
			for(;j<i;j++) {
				if(indexs[j] == index) {
					break;
				}
			}
			if(j>=i) {
				indexs[i++]=index;
				judge.add(judgesimple.get(index));
			}
		}
		indexs = new int[100];
		for(int i=0;i<jmnum;){
			int index=random.nextInt(judgemiddle.size());
			int j=0;
			for(;j<i;j++) {
				if(indexs[j] == index) {
					break;
				}
			}
			if(j>=i) {
				indexs[i++]=index;
				judge.add(judgemiddle.get(index));
			}
		}
		indexs = new int[100];
		for(int i=0;i<jhnum;){
			int index=random.nextInt(judgehard.size());
			int j=0;
			for(;j<i;j++) {
				if(indexs[j] == index) {
					break;
				}
			}
			if(j>=i) {
				indexs[i++]=index;
				judge.add(judgehard.get(index));
			}
		}
		//随机生成单选题
		indexs = new int[100];
		for(int i=0;i<ossnum;){
			int index=random.nextInt(optionsinglesimple.size());
			int j=0;
			for(;j<i;j++) {
				if(indexs[j] == index) {
					break;
				}
			}
			if(j>=i) {
				indexs[i++]=index;
				single.add(optionsinglesimple.get(index));
			}
		}
		indexs = new int[100];
		for(int i=0;i<osmnum;){
			int index=random.nextInt(optionsinglemiddle.size());
			int j=0;
			for(;j<i;j++) {
				if(indexs[j] == index) {
					break;
				}
			}
			if(j>=i) {
				indexs[i++]=index;
				single.add(optionsinglemiddle.get(index));
			}
		}
		indexs = new int[100];
		for(int i=0;i<oshnum;){
			int index=random.nextInt(optionsinglehard.size());
			int j=0;
			for(;j<i;j++) {
				if(indexs[j] == index) {
					break;
				}
			}
			if(j>=i) {
				indexs[i++]=index;
				single.add(optionsinglehard.get(index));
			}
		}
		//随机生成多选题
		indexs = new int[100];
		for(int i=0;i<omsnum;){
			int index=random.nextInt(optionmultisimple.size());
			int j=0;
			for(;j<i;j++) {
				if(indexs[j] == index) {
					break;
				}
			}
			if(j>=i) {
				indexs[i++]=index;
				multi.add(optionmultisimple.get(index));
			}
		}
		indexs = new int[100];
		for(int i=0;i<ommnum;){
			int index=random.nextInt(optionmultimiddle.size());
			int j=0;
			for(;j<i;j++) {
				if(indexs[j] == index) {
					break;
				}
			}
			if(j>=i) {
				indexs[i++]=index;
				multi.add(optionmultimiddle.get(index));
			}
		}
		indexs = new int[100];
		for(int i=0;i<omhnum;){
			int index=random.nextInt(optionmultihard.size());
			int j=0;
			for(;j<i;j++) {
				if(indexs[j] == index) {
					break;
				}
			}
			if(j>=i) {
				indexs[i++]=index;
				multi.add(optionmultihard.get(index));
			}
		}
	}
	public String startExam(){
		setExam(enterExamDao.findExam(getExam()));
		double[] s=new double[3];
		s[0]=exam.getSingleScore()*exam.getSingleNum();
		s[1]=exam.getMoreScore()*exam.getMoreNum();
		s[2]=exam.getJudgeScore()*exam.getJudgeNum();
		setScore(s);
		
		getList();
		if(exam.getLevel().equals("简单")){
			setNum(0.7,0.1);
			generate();
		}
		if(exam.getLevel().equals("中等")){
			setNum(0.6,0.2);
			generate();
		}
		if(exam.getLevel().equals("困难")){
			setNum(0.5,0.3);
			generate();
		}
		return "success";
	}
	
	//校验考生是否已经进行过该考试
	public String sturesult_validation() {
		
		//根据exam_id查出exam对象
		setExam(enterExamDao.findExam(getExam()));
		
		//得到session
		ActionContext context = ActionContext.getContext();
		Map<String,Object> session = context.getSession();
		//获取session的student
		Student student = (Student)session.get("student");
		
		message = enterExamDao.sturesult_validation(student,exam);
		
		return "success";
	}
	
	//提交试题答案
	public String submit_exam() {
		//切分各题型的答案
		String[] singleStrArray = singleArray.split(",");
		String[] moreStrArray = moreArray.split(",");
		String[] judgeStrArray = judgeArray.split(",");
		
		//初始化exam
		exam = new Exam();
		//根据exam_id查出exam对象
		exam.setId(Long.parseLong(exam_id));
		setExam(enterExamDao.findExam(getExam()));
		
		//得到session
		ActionContext context = ActionContext.getContext();
		Map<String,Object> session = context.getSession();
		//获取session的student
		Student student = (Student)session.get("student");
		
		//获取当前时间
		java.sql.Timestamp time = new java.sql.Timestamp(System.currentTimeMillis());
		
		//查询数据库得到分数
		double singleScore,moreScore,jusgeScore;
		singleScore = exam.getSingleScore() * enterExamDao.single_score(singleStrArray);
		moreScore = exam.getMoreScore() * enterExamDao.more_score(moreStrArray);
		jusgeScore = exam.getJudgeScore() * enterExamDao.judge_score(judgeStrArray);
		
		singleAnswers = enterExamDao.single_answer(singleStrArray);
		moreAnswers = enterExamDao.more_answer(moreStrArray);
		judgeAnswers = enterExamDao.judge_answer(judgeStrArray);
		
		totalScore = singleScore + moreScore + jusgeScore;
		//初始化sturesult
		sturesult = new Sturesult();
		
		sturesult.setExam(exam);
		sturesult.setStudent(student);
		sturesult.setJoinTime(time);
		sturesult.setResSingle(singleScore);
		sturesult.setResMore(moreScore);
		sturesult.setResJudge(jusgeScore);
		sturesult.setResTotal(totalScore);
		
		enterExamDao.insert_sturesult(sturesult);
		
		return "success";
	}

	

}
