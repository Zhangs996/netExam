package dao;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.regex.Pattern;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import model.Exam;
import model.Lesson;
import model.Sturesult;

public class LessonDao {
	private Configuration configuration;
	private SessionFactory sessionFactory;
	private Session session;
	private Transaction transaction;
	
	private ArrayList<Lesson> lessons;
	
    public ArrayList<Lesson> getLessons() {
		return lessons;
	}

	public void setLessons(ArrayList<Lesson> lessons) {
		this.lessons = lessons;
	}

	private Lesson lesson;
    
	public Lesson getLesson() {
		return lesson;
	}

	public void setLesson(Lesson lesson) {
		this.lesson = lesson;
	}

	@SuppressWarnings("deprecation")
	public Session getSession() {
		configuration = new Configuration().configure();
		sessionFactory = configuration.buildSessionFactory();
		session = sessionFactory.openSession();
		return session;
	}

	public void add_hibernate(Lesson lesson) {
		session = this.getSession();
		transaction = session.beginTransaction();
		lesson.setJoinTime(new Timestamp(System.currentTimeMillis()));
		session.save(lesson);
		transaction.commit();
		
	}

	public String add_validate(String name) {
		session = this.getSession();
		// transaction = session.beginTransaction();
		Query query = session.createQuery("from Lesson where name=?");
		query.setString(0, name);
		Lesson lesson = (Lesson) query.uniqueResult();
		if (lesson == null) {
			return "";
		} else {
			return "该课程已经存在！";
		}
	}

	// 模糊查询显示所有的Lesson对象
	@SuppressWarnings("unchecked")
	public ArrayList<Lesson> list_lesson(String condition,int totalUsers) {
		// 获取hibernate的session对象
		session = this.getSession();
		
		// 如果condition为null，令其为""
		if (condition == null) {
			condition = "";
		}
		
		String hql = "from Lesson";
		
		Query query = session.createQuery(hql);
		 
		if(query.list().size() != totalUsers && totalUsers != -1) {
			return lessons;
		}

		hql = "from Lesson where name like  ? ";

		// 验证condition是否为纯数字
		String pattern = "[0-9]{1,}";
		boolean isMatch = Pattern.matches(pattern, condition);

		// 纯数字加上id及时长的模糊查询(
		if (isMatch) {
			hql += " or  id = " + Integer.parseInt(condition) + " ";
		}

		query = session.createQuery(hql);
		query.setParameter(0, "%" + condition + "%");
		lessons = (ArrayList<Lesson>)query.list();
		return lessons;
	}
//修改课程
	public void edit_lesson(Lesson lesson) {
		//获取hibernate的session对象
		session = this.getSession();
		
		String hql = "from Lesson where id = ?";
		
		Query query = session.createQuery(hql);
		query.setParameter(0, lesson.getId());
		
		Lesson lesson1 = (Lesson)query.list().get(0);
		
		lesson1.setName(lesson.getName());
		//获取事务对象
		transaction = session.beginTransaction();
		
		session.update(lesson1);
		
		//提交事务
		transaction.commit();
	}

	@SuppressWarnings("unchecked")
	public void delete_lesson_hibernate(String[] sourceStrArray) {
		//获取hibernate的session对象
		session = this.getSession();
		String hql;
		Query query;
		ArrayList<Exam> exams;
		ArrayList<Sturesult> sturesults;
		Sturesult sturesult;
		Exam exam;
		Lesson lesson = new Lesson();
		for(int i = 0;i < sourceStrArray.length;i++) {
			//获取事务对象
			transaction = session.beginTransaction();
			lesson.setId(Long.parseLong(sourceStrArray[i]));
			session.delete(lesson);
			//提交事务
			transaction.commit();
			
			//查询要删除的所有考试
			hql = "from Exam where lesson.id = " + Long.parseLong(sourceStrArray[i]);
			query = session.createQuery(hql);
			exams = (ArrayList<Exam>)query.list();
			
			//删除该所有考试
			for(int j = 0;j < exams.size();j++) {
				exam = exams.get(j);
				//获取事务对象
				transaction = session.beginTransaction();
				session.delete(exam);
				//提交事务
				transaction.commit();
				
				//查询要删除的考试所有成绩
				hql = "from Sturesult where exam.id = " + exam.getId();
				query = session.createQuery(hql);
				sturesults = (ArrayList<Sturesult>)query.list();
				
				//删除该考试所有成绩
				for(int z = 0;z < sturesults.size();z++) {
					sturesult = sturesults.get(z);
					//获取事务对象
					transaction = session.beginTransaction();
					session.delete(sturesult);
					//提交事务
					transaction.commit();
				}
			}
		}
	}
}
