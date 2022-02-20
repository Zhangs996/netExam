package dao;

import java.util.ArrayList;
import java.util.Map;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.opensymphony.xwork2.ActionContext;

import model.Manager;
import model.Suggest;

public class ManagerDao {
	// hibernate 相关接口
	private Configuration configuration;
	private SessionFactory sessionFactory;
	private Session session;

	// 管理员登录dao方法
	@SuppressWarnings("deprecation")
	public String manager_login_hibernate(Manager manager) {
		// hibernate 相关接口初始化
		configuration = new Configuration().configure();
		sessionFactory = configuration.buildSessionFactory();
		session = sessionFactory.openSession();

		Manager manager1 = (Manager) session.get(Manager.class, manager.getId());
		if (manager1 != null && manager1.getPwd().equals(manager.getPwd())) {
			ActionContext context = ActionContext.getContext();
			Map<String, Object> session_web = context.getSession();
			session_web.put("manager", manager1);
			session.close();
			sessionFactory.close();
			return "";
		}
		session.close();
		sessionFactory.close();
		if (manager1 == null) {
			return "管理员账号不存在";
		}
		return "密码错误";
	}

	@SuppressWarnings({ "deprecation", "unchecked" })
	public ArrayList<Suggest> list_suggest() {
		// 获取hibernate的session对象
		configuration = new Configuration().configure();
		sessionFactory = configuration.buildSessionFactory();
		session = sessionFactory.openSession();

		ArrayList<Suggest> suggests = new ArrayList<Suggest>();
		// 如果condition为null，令其为""
		String hql = "from Suggest";
		Query query = session.createQuery(hql);
		suggests = (ArrayList<Suggest>) query.list();
		
		session.close();
		return suggests;
	}

	@SuppressWarnings("deprecation")
	public void delete_feedback(String[] sourceStrArray) {
		// 获取hibernate的session对象
		configuration = new Configuration().configure();
		sessionFactory = configuration.buildSessionFactory();
		session = sessionFactory.openSession();
		Transaction transaction;
		Suggest suggest = new Suggest();
		for (int i = 0; i < sourceStrArray.length; i++) {
			// 获取事务对象
			transaction = session.beginTransaction();
			suggest.setId(Integer.parseInt(sourceStrArray[i]));
			session.delete(suggest);
			transaction.commit();
		}
		session.close();
	}

	@SuppressWarnings("deprecation")
	public Suggest suggest_content(Suggest suggest) {
		configuration = new Configuration().configure();
		sessionFactory = configuration.buildSessionFactory();
		session = sessionFactory.openSession();
		return (Suggest) session.get(Suggest.class,suggest.getId());
	}
}
