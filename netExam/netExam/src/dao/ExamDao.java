package dao;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import model.Exam;
import model.Lesson;
import model.Sturesult;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.regex.Pattern;

public class ExamDao {
	//
	ArrayList<Exam> exams;
	
	public ArrayList<Exam> getExams() {
		return exams;
	}

	public void setExams(ArrayList<Exam> exams) {
		this.exams = exams;
	}
	
	

	//hibernate 相关接口
	private Configuration configuration;
	private SessionFactory sessionFactory;
	private Session session;
	private Transaction transaction;
	
	//获得session对象
	@SuppressWarnings("deprecation")
	public Session getSession(){
		configuration = new Configuration().configure();
		sessionFactory = configuration.buildSessionFactory();
		session =  sessionFactory.openSession();
		return session;
	}
	
	public void close_interface(){
		
		session.close();
		sessionFactory.close();
	}
	
	//模糊查询显示所有的exam对象
	@SuppressWarnings("unchecked")
	public ArrayList<Exam> list_exam (String condition,String status,int totalUsers) {
		//获取hibernate的session对象
		session = this.getSession();
		
		//如果condition为null，令其为""
		if(condition == null) {
			condition = "";
		}
		
		if(status == null) {
			status = "";
		}
		
		String hql = "from Exam";
		
		Query query = session.createQuery(hql);
		 
		if(query.list().size() != totalUsers && totalUsers != -1) {
			return exams;
		}
		
		hql = "from Exam where (lesson.name like ? or status like ? or level like ?)";
		
		//验证condition是否为纯数字
		String pattern = "[0-9]{1,}";
		boolean isMatch = Pattern.matches(pattern, condition);
		
		//纯数字加上id及时长的模糊查询
		if(isMatch) {
			hql += " or (id = " + Integer.parseInt(condition) +" or duration = " + Integer.parseInt(condition)
				+ " or singleNum = " + Integer.parseInt(condition) +" or singleScore = " + Integer.parseInt(condition)
				+ " or moreNum = " + Integer.parseInt(condition) +" or moreScore = " + Integer.parseInt(condition)
				+ " or judgeNum = " + Integer.parseInt(condition) +" or judgeScore = " + Integer.parseInt(condition) + ")";
		}
		
		if(status.equals("考试已结束")) {
			hql += " and (status = '" + status + "')";
		}
		
		query = session.createQuery(hql);
		query.setParameter(0, "%"+condition+"%");
		query.setParameter(1, "%"+condition+"%");
		query.setParameter(2, "%"+condition+"%");
		exams = (ArrayList<Exam>)query.list();
		
		return exams;
	}
	
	//获得创建考试可选的课程名
	public ArrayList<String> list_select_course_hibernate() {
		//获取hibernate的session对象
		session = this.getSession();
		
		String hql = "from Lesson";
		
		Query query = session.createQuery(hql);
		
		//得到lessons集合
		@SuppressWarnings("unchecked")
		ArrayList<Lesson> lessons = (ArrayList<Lesson>)query.list();
		int len = query.list().size();
		ArrayList<String> lesson_names = new ArrayList<String>();
		
		//得到lesson_names数组
		for(int i = 0;i < len;i++) {
			lesson_names.add(lessons.get(i).getName());
		}
		
		return lesson_names;
	}
	
	//创建考试校验
	public String question_num_validation_hibernate(Exam exam) {
		//获取hibernate的session对象
		session = this.getSession();
		
		//校验单选题数目
		String hql = "from Optionalquestion where type = '单选题' and lesson.name = ?";
		
		Query query = session.createQuery(hql);
		query.setParameter(0, exam.getLesson().getName());
		int num = query.list().size();
		if(query.list().size() < exam.getSingleNum()) {
			return "单选题数目不足，请先添加题目！";
		}
		
		//校验多选题数目
		hql = "from Optionalquestion where type = '多选题' and lesson.name = ?";
		
		query = session.createQuery(hql);
		query.setParameter(0, exam.getLesson().getName());
		if(query.list().size() < exam.getMoreNum()) {
			return "多选题数目不足，请先添加题目！";
		}
		
		//校验判断题数目
		hql = "from Judgequestion where lesson.name = ?";
		
		query = session.createQuery(hql);
		query.setParameter(0, exam.getLesson().getName());
		if(query.list().size() < exam.getJudgeNum()) {
			return "判断题数目不足，请先添加题目！";
		}
		
		//都满足
		return "";
	}
	
	//创建考试
	public void create_exam_hibernate(Exam exam) {
		//获取hibernate的session对象
		session = this.getSession();
		
		String hql = "from Lesson where name = ?";
		
		Query query = session.createQuery(hql);
		query.setParameter(0, exam.getLesson().getName());
		
		Lesson lesson = (Lesson)query.list().get(0);
		
		exam.setLesson(lesson);
		exam.setJoinTime(new Timestamp(System.currentTimeMillis()));
		exam.setStatus("考试进行中");
		
		transaction = session.beginTransaction();
		session.save(exam);
		transaction.commit();
		
	}
	
	//删除考试
	@SuppressWarnings("unchecked")
	public void delete_exam_hibernate(String[] sourceStrArray) {
		//获取hibernate的session对象
		session = this.getSession();
		String hql;
		Query query;
		ArrayList<Sturesult> sturesults;
		Sturesult sturesult;
		Exam exam = new Exam();
		for(int i = 0;i < sourceStrArray.length;i++) {
			//获取事务对象
			transaction = session.beginTransaction();
			exam.setId(Long.parseLong(sourceStrArray[i]));
			session.delete(exam);
			//提交事务
			transaction.commit();
			
			//查询要删除的考试所有成绩
			hql = "from Sturesult where exam.id = " + Long.parseLong(sourceStrArray[i]);
			query = session.createQuery(hql);
			sturesults = (ArrayList<Sturesult>)query.list();
			
			//删除该考试所有成绩
			for(int j = 0;j < sturesults.size();j++) {
				sturesult = sturesults.get(j);
				//获取事务对象
				transaction = session.beginTransaction();
				session.delete(sturesult);
				//提交事务
				transaction.commit();
			}
		}	
		
	}
	
	//编辑考试（进入考试页面）
	public Exam edit_exam_one_hibernate(Exam exam) {
		//获取hibernate的session对象
		session = this.getSession();
		
		Exam exam1 = (Exam)session.get(Exam.class, exam.getId());
		
		return exam1;
	}
	
	//编辑考试（修改数据库）
	public void edit_exam_hibernate(Exam exam) {
		//获取hibernate的session对象
		session = this.getSession();
		
		String hql = "from Lesson where name = ?";
		
		Query query = session.createQuery(hql);
		query.setParameter(0, exam.getLesson().getName());
		
		Lesson lesson = (Lesson)query.list().get(0);
		
		exam.setLesson(lesson);
		
		//获取事务对象
		transaction = session.beginTransaction();
		
		session.update(exam);
		
		//提交事务
		transaction.commit();
		
	}

	
	//终止考试
	public void end_exam_hibernate(Exam exam) {
		//获取hibernate的session对象
		session = this.getSession();
		
		exam = (Exam)session.get(Exam.class, exam.getId());
		
		exam.setStatus("考试已结束");
		
		//获取事务对象
		transaction = session.beginTransaction();
		
		session.update(exam);
		
		//提交事务
		transaction.commit();
		
	}
	//批量终止考试
	public void ends_exam_hibernate(String[] sourceStrArray) {
		session = this.getSession();
		Exam exam;
		for(int i = 0;i < sourceStrArray.length;i++) {
			//获取事务对象
			transaction = session.beginTransaction();
			
			exam = (Exam)session.get(Exam.class, Long.parseLong(sourceStrArray[i]));
			exam.setStatus("考试已结束");
			
			session.update(exam);
			
			//提交事务
			transaction.commit();
		}
		
	}
	
	//重启考试
	public void restart_exam_hibernate(Exam exam) {
		//获取hibernate的session对象
		session = this.getSession();
		
		exam = (Exam)session.get(Exam.class, exam.getId());
		
		exam.setStatus("考试进行中");
		
		//获取事务对象
		transaction = session.beginTransaction();
		
		session.update(exam);
		
		//提交事务
		transaction.commit();
	}
	
	//批量重启考试
	public void restarts_exam_hibernate(String[] sourceStrArray) {
		session = this.getSession();
		Exam exam;
		for(int i = 0;i < sourceStrArray.length;i++) {
			//获取事务对象
			transaction = session.beginTransaction();
			
			exam = (Exam)session.get(Exam.class, Long.parseLong(sourceStrArray[i]));
			exam.setStatus("考试进行中");
			
			session.update(exam);
			
			//提交事务
			transaction.commit();
		}
		
	}
	
	private ArrayList<Exam> stuExams;
	
	public ArrayList<Exam> getStuExams() {
		return stuExams;
	}

	public void setStuExams(ArrayList<Exam> stuExams) {
		this.stuExams = stuExams;
	}

	//查找学生
	@SuppressWarnings("unchecked")
	public ArrayList<Exam> list_student_exam(String condition, int totalUsers) {
		//获取hibernate的session对象
		session = this.getSession();
		
		String hql = "from Exam where status='考试进行中'";
		
		Query query = session.createQuery(hql);
		 
		if(query.list().size() != totalUsers && totalUsers != -1) {
			return stuExams;
		}
		
		hql = "from Exam where status='考试进行中' and (lesson.name like ? ";
		
		//验证condition是否为纯数字
		String pattern = "[0-9]{1,}";
		boolean isMatch = Pattern.matches(pattern, condition);
		
		//纯数字加上id及时长的模糊查询
		if(isMatch) {
			hql += " or id = " + Integer.parseInt(condition) +" or duration = " + Integer.parseInt(condition);
		}
		
		hql += ")";
		
		query = session.createQuery(hql);
		query.setParameter(0, "%"+condition+"%");
		
		stuExams = (ArrayList<Exam>)query.list();
		
		return stuExams;
	}

}
