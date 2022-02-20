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
import model.Judgequestion;
import model.Lesson;
import java.sql.Timestamp;
import java.util.regex.Pattern;
public class JudgeDao {
	private ArrayList<Judgequestion> judges;
	
	public ArrayList<Judgequestion> getJudges() {
		return judges;
	}

	public void setJudges(ArrayList<Judgequestion> judges) {
		this.judges = judges;
	}

	private Judgequestion judge;
	
	public Judgequestion getJudge() {
		return judge;
	}

	public void setJudge(Judgequestion judge) {
		this.judge = judge;
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
	public ArrayList<Judgequestion> getAllBySQL()
	{
		session = this.getSession();
		String hql="from Judgequestion";
		Query query = session.createQuery(hql);
		ArrayList<Judgequestion> questions = (ArrayList<Judgequestion>)query.list();
		return (ArrayList<Judgequestion>)query.list();
	}
	public List<Judgequestion> getAllByExcel(File file){	
		List<Judgequestion> list=new ArrayList<Judgequestion>();
		try {
            Workbook rwb=Workbook.getWorkbook(file);
            Sheet rs=rwb.getSheet(0);//或者rwb.getSheet(0)
            int clos=rs.getColumns();//得到所有的列
            int rows=rs.getRows();//得到所有的行
            for (int i = 1; i < rows; i++) {
                for (int j = 0; j < clos; j++) {
                    //第一个是列数，第二个是行数
                    //默认最左边编号也算一列 所以这里得j++
                	Lesson lesson=new Lesson();
                	lesson.setName(rs.getCell(j++, i).getContents());
                    String question=rs.getCell(j++, i).getContents();
                    String level=rs.getCell(j++, i).getContents();
                    String answer=rs.getCell(j++, i).getContents();
                    java.sql.Timestamp time = new java.sql.Timestamp(System.currentTimeMillis());
                    list.add(new Judgequestion(lesson, question,level,answer,time));
                }
            }

    } catch (Exception e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    } 
    return list;
}
    public Long isExist(String question){
    	session=this.getSession();
        String hql="from Judgequestion where question= ?";
        Query query = session.createQuery(hql);
        query.setParameter(0, question);
        if (query.list().size()!=0) {
        	Judgequestion judgequestion = (Judgequestion)query.list().get(0);
			return judgequestion.getId();
        }
        return (long) -1;
    }

	public void listAddJudgeHibernate(Judgequestion question) {
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
    public void listUpdateJudgeHibernate(Judgequestion question) {
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
	public ArrayList<Judgequestion> list_judges (String condition,int totalUsers) {
		//获取hibernate的session对象
		session = this.getSession();
		
		//如果condition为null，令其为""
		if(condition == null) {
			condition = "";
		}
		
		String hql = "from Judgequestion";
		
		Query query = session.createQuery(hql);
		 
		if(query.list().size() != totalUsers && totalUsers != -1) {
			return judges;
		}
		
		hql = "from Judgequestion where lesson.name like? or Level like ? or answer like ? or Answer like ?";
		
		//验证condition是否为纯数字
		String pattern = "[0-9]{1,}";
		boolean isMatch = Pattern.matches(pattern, condition);
				
		if(isMatch) {
			hql += " or id = " + Integer.parseInt(condition) +" or joinTime = " + Integer.parseInt(condition) +" or LessonId = " + Integer.parseInt(condition) +" ";
		}
		
		query = session.createQuery(hql);
		query.setParameter(0, "%"+condition+"%");
		query.setParameter(1, "%"+condition+"%");
		query.setParameter(2, "%"+condition+"%");
		query.setParameter(3, "%"+condition+"%");
		judges = (ArrayList<Judgequestion>)query.list();
		return judges;
	 }
	public void delete_judge_hibernate(String[] sourceStrArray){
			//获取hibernate的session对象
		session = this.getSession();
			
		judge = new Judgequestion();
		for(int i = 0;i < sourceStrArray.length;i++) {
				//获取事务对象
		transaction = session.beginTransaction();
		judge.setId(Long.parseLong(sourceStrArray[i]));
		session.delete(judge);
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
	public void create_judge_hibernate(Judgequestion judge) {
		//获取hibernate的session对象
		session = this.getSession();
		String hql = "from Lesson where name = ?";
		Query query = session.createQuery(hql);
		query.setParameter(0, judge.getLesson().getName());
		Lesson lesson = (Lesson)query.list().get(0);
		judge.setLesson(lesson);
		judge.setJoinTime(new Timestamp(System.currentTimeMillis()));
		transaction = session.beginTransaction();
		session.save(judge);
		transaction.commit();
		
	}
	//编辑考试（进入考试页面）
	public Judgequestion edit_judge_one_hibernate(Judgequestion judge) {
		//获取hibernate的session对象
		session = this.getSession();
		
		Judgequestion judge1 = (Judgequestion)session.get(Judgequestion.class, judge.getId());
		
		return judge1;
	}
	
	//编辑考试（修改数据库）
	public void edit_judge_hibernate(Judgequestion judge) {
		//获取hibernate的session对象
		session = this.getSession();
		
		String hql = "from Lesson where name = ?";
		
		Query query = session.createQuery(hql);
		query.setParameter(0, judge.getLesson().getName());
		
		Lesson lesson = (Lesson)query.list().get(0);
		
		judge.setLesson(lesson);
		
		//获取事务对象
		transaction = session.beginTransaction();
		
		session.update(judge);
		
		//提交事务
		transaction.commit();
		
	}

	
	
}
