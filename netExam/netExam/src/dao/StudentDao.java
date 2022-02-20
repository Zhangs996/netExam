package dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.opensymphony.xwork2.ActionContext;

import model.Sturesult;
import model.Suggest;
import model.Student;

import tool.ChStr;
import tool.CipherEncryption;

public class StudentDao {
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
	
	//学生登录Dao方法
	public String student_login_hibernate(int flag,String id, Student student) {
		//hibernate 相关接口初始化
		session = getSession();
		
		//由flag确定hql语句
		String tem;
		if(flag == 1) {
			tem = "id";
		}
		else {
			tem = "cardNo";
		}
		
		//获取密码加密类对象
		CipherEncryption cipherEncryption = new CipherEncryption();
		
		//加密
		String pwd = cipherEncryption.encryption(student.getPwd());
		
		//hql语句
		String hql = "from Student where " + tem + " = ? and pwd = ?";
		Query query=session.createQuery(hql);
		query.setParameter(0, id);
		query.setParameter(1, pwd);
		
		//判断是否有该学生
		if(query.list().size() == 0 ){
			session.close();
			sessionFactory.close();
			return "密码错误或账号不存在";
		}
		
		//判断该账号是否已经登录
		Student student1 = (Student)query.list().get(0);
		if(student1.getStatus().equals("在线")) {
			session.close();
			sessionFactory.close();
			return "该账号已在别处登录";
		}
		
		//设置账号状态为登录
		transaction = session.beginTransaction();
		student1.setStatus("在线");
		session.update(student1);
		transaction.commit();
		
		//把student变量存入session中，以便日后取用
		ActionContext context = ActionContext.getContext();
		Map<String, Object> session_web = context.getSession();
		session_web.put("student", query.list().get(0));
		
		session.close();
		sessionFactory.close();
		return "";
	}
	//学生成绩查询hibernate方法
	@SuppressWarnings("deprecation")
	public  ArrayList<Sturesult> studentresult_hibernate(Student student) throws Exception{
		//hibernate 相关接口初始化
		configuration = new Configuration().configure();
		sessionFactory= configuration.buildSessionFactory();
		session = sessionFactory.openSession();
		
		//hql语句查询该学生的所有成绩
		String hql  = "from Sturesult where stuId = ?";	
		Query query = session.createQuery(hql);
		query.setParameter(0, student.getId());
		
		//System.out.println(query.list().size());
		//接受查询到的成绩
		@SuppressWarnings("unchecked")
		ArrayList<Sturesult> studentresults = (ArrayList<Sturesult>)query.list();
		session.close();
		sessionFactory.close();
		return studentresults;
	}
	
	//学生注册
	public String student_register_hibernate(Student student) {
		session = getSession();
		
		//判断是否已经注册
		String hql = "from Student where cardNo = ?";
		Query query = session.createQuery(hql);
		query.setParameter(0, student.getCardNo());
		
		if(query.list().size() != 0) {
			session.close();
			sessionFactory.close();
			return "";
		}
		
		//获取当前日期
		java.util.Date date = new java.util.Date(); 
		
		//格式化当前日期为字符串
		String date_str = new SimpleDateFormat("yyyyMMdd").format(date); 
		
		//定义考生号
		String id = "";
		
		//查询当前最大考生号
		hql = "select max(id) from Student";
		query = session.createQuery(hql);
		
		//已经有考生
		if(query.list().get(0) != null) {
			//获取当前最大考生号
			String max_id = (String)query.list().get(0);
			
			//获取最大考生号的注册日期
			String max_date = max_id.substring(2,10);
			
			//获取最大考生号的序号
			int old_id = Integer.parseInt(max_id.substring(10,16));
			
			//定义当前考试序号
			int new_id;
			
			//今天没有考生注册
			if(!max_date.equals(date_str)) {
				new_id = 1;
			}
			//今天已有考生注册
			else {
				new_id = old_id + 1;
			}
			
			//将生成的编号格式化为6位字符串String no = chStr.formatNO(newId, 6);
			ChStr chStr=new ChStr();
			String no = chStr.formatNO(new_id, 6);
			
			//组合完整的准考证号(CN + 注册日期 + 考生当天注册序号)
			id = "CN" + date_str + no;
		}
		//当第一个考生注册时
		else {
			id = "CN" + date_str + "000001";
		}
		
		//获取密码加密类对象
		CipherEncryption cipherEncryption = new CipherEncryption();
		
		//加密
		String pwd = cipherEncryption.encryption(student.getPwd());
		
		student.setPwd(pwd);
		
		//将考生号存入studnet对象中，存入数据库
		java.sql.Timestamp time = new java.sql.Timestamp(System.currentTimeMillis());
		student.setId(id);
		student.setJoinTime(time);
		student.setStatus("离线");
		transaction = session.beginTransaction();
		session.save(student);
		transaction.commit();
		
		session.close();
		sessionFactory.close();
		
		//将考生号赋值给提示信息
		return id;
	}
	
	//学生注销
	public void student_logout_hibernate(Student student) {
		//hibernate 相关接口初始化
		session = getSession();
		transaction = session.beginTransaction();
		
		student.setStatus("离线");
		session.update(student);
		transaction.commit();
		
		session.close();
		sessionFactory.close();
	}
	
	//找回密码
	public void findPassword(Student student){
		session = this.getSession();
		String hql = "from Student where tel =?";
		Query query=session.createQuery(hql);
		query.setParameter(0, student.getTel());
		Student student1 = (Student)query.uniqueResult();
		
		//获取密码加密类对象
		CipherEncryption cipherEncryption = new CipherEncryption();
		
		//加密
		String pwd = cipherEncryption.encryption(student.getPwd());
		
		student1.setPwd(pwd);
		transaction  = session.beginTransaction();
		session.update(student1);
		transaction.commit();
		session.close();
		sessionFactory.close();
	}
	
	//验证输入的手机号是否正确
	public boolean validateTel(String tel){
		session=this.getSession();
		String hql = "from Student where tel =?";
		Query query=session.createQuery(hql);
	    query.setParameter(0, tel);
	    Student stu = (Student)query.uniqueResult();
		if(stu==null){
			 return false;
		}else{
			return true;
		}
	}
	
	//提交反馈
	public void feedback(Suggest suggest){
		session=this.getSession();
		transaction  = session.beginTransaction();
		session.save(suggest);
		transaction.commit();
		session.close();
		sessionFactory.close();
	}
	
	
	public void update_student(Student student){
		session = this.getSession();
		String hql="from Student where id= ?";
		Query query = session.createQuery(hql);
		query.setParameter(0, student.getId());
		Student studentone = (Student)query.list().get(0);
	    student.setPwd(studentone.getPwd());
	    
	    session.clear();
        transaction = session.beginTransaction();
		session.update(student);
		transaction.commit();
	}
	public Student studentInfo(Student student){
		session = this.getSession();
		String hql="from Student where id= ?";
		Query query = session.createQuery(hql);
		query.setParameter(0, student.getId());
		Student studentone = (Student)query.list().get(0);
		return studentone;
	}


}
