package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import dao.StuResultDao;
import model.AnalysisGrade;
import util.SortExamStuResult;

@WebServlet(name = "ExamStuResultBranchPageServlet", urlPatterns = {"/manager_sturesult_exam_message.servlet"})
public class ExamStuResultBranchPage extends HttpServlet {
	private static final long serialVersionUID = 5952689219411916553L;
	
	//模糊查询搜索条件
	private String condition = "";

	private ArrayList<AnalysisGrade> analysisGrades;
	
	//exam的dao对象
    @Autowired
    private StuResultDao sturesultdao;

	@SuppressWarnings("unchecked")
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		condition = req.getParameter("condition");
		String totalUsersStr = req.getParameter("totalUsers");
        
        int totalUsers_page;
        if(totalUsersStr == null) {
        	totalUsers_page = -1;
        }
        else {
        	totalUsers_page = Integer.parseInt(totalUsersStr);
        }
		
		//如果condition为null，令其为""
		if(condition == null) {
			condition = "";
		}
		
		//从数据库查询对应exam_id的全部成绩
		analysisGrades = sturesultdao.sturesult_exam_message_hibernate(condition,totalUsers_page);
		
		Collections.sort(analysisGrades, new SortExamStuResult());
		
		//分页处理
		String p = req.getParameter("page");
		int page;
        try {
            //当前页数
            page = Integer.valueOf(p);
        } catch (NumberFormatException e) {
            page = 1;
        }
        //用户总数
        int totalUsers = analysisGrades.size();
        //每页用户数
        int usersPerPage = 5;
        //总页数
        int totalPages = totalUsers % usersPerPage == 0 ? totalUsers / usersPerPage : totalUsers / usersPerPage + 1;
        //本页起始用户序号
        int beginIndex = (page - 1) * usersPerPage;
        //本页末尾用户序号的下一个
        int endIndex = beginIndex + usersPerPage;
        if (endIndex > totalUsers)
            endIndex = totalUsers;
        req.setAttribute("totalUsers", totalUsers);
        req.setAttribute("usersPerPage", usersPerPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("beginIndex", beginIndex);
        req.setAttribute("endIndex", endIndex);
        req.setAttribute("page", page);
        req.setAttribute("analysisGrades", analysisGrades);
        req.getRequestDispatcher("jsp/manager/sturesult_exam_message.jsp").forward(req, resp);
		
	}
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	    SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this,config.getServletContext());
	}

}