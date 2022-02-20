package action;

import java.util.Map;

import com.opensymphony.xwork2.ActionContext;

import dao.ManagerDao;
import model.Manager;
import model.Suggest;

public class ManagerAction {
	private Suggest suggest;
	public Suggest getSuggest() {
		return suggest;
	}

	public void setSuggest(Suggest suggest) {
		this.suggest = suggest;
	}
	
	//要删除id号的数组
	String delete_arr;
	public String getDelete_arr() {
		return delete_arr;
	}

	public void setDelete_arr(String delete_arr) {
		this.delete_arr = delete_arr;
	}
	
	//显示提示信息
	private String message = "";
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
		
	//管理员对象
	Manager manager;
	
	public Manager getManager() {
		return manager;
	}


	public void setManager(Manager manager) {
		this.manager = manager;
	}


	//管理员dao对象
	ManagerDao managerdao;

	public ManagerDao getManagerdao() {
		return managerdao;
	}


	public void setManagerdao(ManagerDao managerdao) {
		this.managerdao = managerdao;
	}
	
	//管理员登录
	public String manager_login() {
		message = managerdao.manager_login_hibernate(manager);
		if(message.equals("")) {
			return "success";
		}
		return "error";
	}
	
	//管理员退出登录
	public String manager_logout() {
		ActionContext context = ActionContext.getContext();
		Map<String,Object> session = context.getSession();
		session.remove("manager");
		return "success";
	}
	
	//显示管理员首页
	public String list_manager_message() {
		return "success";
	}
	
	// 删除反馈建议
	public String delete_feedback() {
		// 切分从前台传过来的字符串数据
		String[] sourceStrArray = delete_arr.split(",");
		managerdao.delete_feedback(sourceStrArray);
		return "success";
	}

	public String suggest_content() {
		suggest = managerdao.suggest_content(suggest);
		return "success";
	}
	
}
