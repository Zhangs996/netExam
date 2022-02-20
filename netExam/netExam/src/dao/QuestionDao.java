package dao;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import jxl.Sheet;
import jxl.Workbook;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import model.Lesson;
import model.Optionalquestion;
import java.sql.Timestamp;
import java.util.regex.Pattern;
public class QuestionDao {
	private ArrayList<Optionalquestion> questions;
	
	public ArrayList<Optionalquestion> getQuestions() {
		return questions;
	}

	public void setQuestions(ArrayList<Optionalquestion> questions) {
		this.questions = questions;
	}
	
	private Optionalquestion question;
	
	public Optionalquestion getQuestion() {
		return question;
	}

	public void setQuestion(Optionalquestion question) {
		this.question = question;
	}
    private String list_add_question;

	public String getList_add_question() {
	return list_add_question;
    }

    public void setList_add_question(String list_add_question) {
	this.list_add_question = list_add_question;
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
		sessionFactory.close();
		session.close();
	}
	@SuppressWarnings({ "unused", "unchecked" })
	public ArrayList<Optionalquestion> getAllBySQL()
	{
		session = this.getSession();
		String hql="from Optionalquestion";
		Query query = session.createQuery(hql);
		ArrayList<Optionalquestion> questions = (ArrayList<Optionalquestion>)query.list();
		return (ArrayList<Optionalquestion>)query.list();
	}
	public List<Optionalquestion> getAllByExcel(File file){	
		List<Optionalquestion> list=new ArrayList<Optionalquestion>();
		try {
            Workbook rwb=Workbook.getWorkbook(file);
            Sheet rs=rwb.getSheet(0);//或者rwb.getSheet(0)
            int clos=rs.getColumns();//得到所有的列
            int rows=rs.getRows();//得到所有的行
            //System.out.println(clos+" rows:"+rows);
            for (int i = 1; i < rows; i++) {
                for (int j = 0; j < clos; j++) {
                    //第一个是列数，第二个是行数
                    //默认最左边编号也算一列 所以这里得j++
                	Lesson lesson=new Lesson();
                	lesson.setName(rs.getCell(j++, i).getContents());
                    String question=rs.getCell(j++, i).getContents();
                    String type=rs.getCell(j++, i).getContents();
                    String level=rs.getCell(j++, i).getContents();
                    String optionA=rs.getCell(j++, i).getContents();
                    String optionB=rs.getCell(j++, i).getContents();
                    String optionC=rs.getCell(j++, i).getContents();
                    String optionD=rs.getCell(j++, i).getContents();
                    String answer=rs.getCell(j++, i).getContents();
                    java.sql.Timestamp time = new java.sql.Timestamp(System.currentTimeMillis());
                    list.add(new Optionalquestion(lesson, question,type,level,optionA,optionB,optionC,optionD,answer,time));
                }
            }

    } catch (Exception e) {
        e.printStackTrace();
    } 
    return list;
}
    public Long isExist(String question){
    	session=this.getSession();
        String hql="from Optionalquestion where question= ?";
        Query query = session.createQuery(hql);
        query.setParameter(0, question);
        if (query.list().size()!=0) {
        	Optionalquestion optionalquestion = (Optionalquestion)query.list().get(0);
			return optionalquestion.getId();
        }
        return (long) -1;
    }

	public void listAddQuestionHibernate(Optionalquestion question) {
		//获取hibernate的session对象
		session = this.getSession();
		String hql = "from Lesson where name = ?";
		Query query = session.createQuery(hql);
		query.setParameter(0, question.getLesson().getName());
		int len = query.list().size();
		if(len != 0) {
			Lesson lesson = (Lesson)query.list().get(0);
			question.setLesson(lesson);
			question.setJoinTime(new Timestamp(System.currentTimeMillis()));
			transaction = session.beginTransaction();
			session.save(question);
			transaction.commit();
		}
    }
    public void listUpdateQuestionHibernate(Optionalquestion question) {
	//获取hibernate的session对象
			session = this.getSession();
			String hql = "from Lesson where name = ?";
			Query query = session.createQuery(hql);
			query.setParameter(0, question.getLesson().getName());
			int len = query.list().size();
			if(len != 0) {
				Lesson lesson = (Lesson)query.list().get(0);
				question.setLesson(lesson);
				question.setJoinTime(new Timestamp(System.currentTimeMillis()));
				transaction = session.beginTransaction();
				session.update(question);
				transaction.commit();
			}
    }
    
	//模糊查询显示所有的question对象
	@SuppressWarnings("unchecked")
	public ArrayList<Optionalquestion> list_questions (String condition,int totalUsers) {
		//获取hibernate的session对象
		session = this.getSession();
		
		//如果condition为null，令其为""
		if(condition == null) {
			condition = "";
		}
		
		String hql = "from Optionalquestion";
		
		Query query = session.createQuery(hql);
		 
		if(query.list().size() != totalUsers && totalUsers != -1) {
			return questions;
		}
		
		hql = "from Optionalquestion where lesson.name like? or type like ? or Level like ? or question like ? or optionA like ? or optionB like ? or optionC like ? or optionD like ? or Answer like ?";
		
		//验证condition是否为纯数字
		String pattern = "[0-9]{1,}";
		boolean isMatch = Pattern.matches(pattern, condition);
				
		if(isMatch) {
			hql += " or id = " + Integer.parseInt(condition) +" or joinTime = " + Integer.parseInt(condition) + " ";
		}
		
		query = session.createQuery(hql);
		query.setParameter(0, "%"+condition+"%");
		query.setParameter(1, "%"+condition+"%");
		query.setParameter(2, "%"+condition+"%");
		query.setParameter(3, "%"+condition+"%");
		query.setParameter(4, "%"+condition+"%");
		query.setParameter(5, "%"+condition+"%");
		query.setParameter(6, "%"+condition+"%");
		query.setParameter(7, "%"+condition+"%");
		query.setParameter(8, "%"+condition+"%");
		questions = (ArrayList<Optionalquestion>)query.list();
		return questions;
	 }
	public void delete_question_hibernate(String[] sourceStrArray){
			//获取hibernate的session对象
		session = this.getSession();
			
		question = new Optionalquestion();
		for(int i = 0;i < sourceStrArray.length;i++) {
				//获取事务对象
		transaction = session.beginTransaction();
		question.setId(Long.parseLong(sourceStrArray[i]));
		session.delete(question);
				//提交事务
		transaction.commit();
	        }	
	}
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

	//创建考试
	public void create_question_hibernate(Optionalquestion question) {
		//获取hibernate的session对象
		session = this.getSession();
		String hql = "from Lesson where name = ?";
		Query query = session.createQuery(hql);
		query.setParameter(0, question.getLesson().getName());
		Lesson lesson = (Lesson)query.list().get(0);
		question.setLesson(lesson);
		question.setJoinTime(new Timestamp(System.currentTimeMillis()));
		transaction = session.beginTransaction();
		session.save(question);
		transaction.commit();
		
	}
	//编辑考试（进入考试页面）
	public Optionalquestion edit_question_one_hibernate(Optionalquestion question) {
		//获取hibernate的session对象
		session = this.getSession();
		
		Optionalquestion question1 = (Optionalquestion)session.get(Optionalquestion.class, question.getId());
		
		return question1;
	}
	
	//编辑考试（修改数据库）
	public void edit_question_hibernate(Optionalquestion question) {
		//获取hibernate的session对象
		session = this.getSession();
		
		String hql = "from Lesson where name = ?";
		
		Query query = session.createQuery(hql);
		query.setParameter(0, question.getLesson().getName());
		
		Lesson lesson = (Lesson)query.list().get(0);
		
		question.setLesson(lesson);
		
		//获取事务对象
		transaction = session.beginTransaction();
		
		session.update(question);
		
		//提交事务
		transaction.commit();
		
	}

	
	
}
