package servlet;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;
import model.Optionalquestion;
import util.SortOptionalquestion;
import dao.QuestionDao;
@WebServlet(name = "QuestionBranchPageServlet", urlPatterns = {"/manager_question.servlet"})
public class QuestionBranchPage extends HttpServlet{
		/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
		private List<Optionalquestion> questions;
	    //question的dao对象
	    @Autowired
	    private QuestionDao questiondao;

		public QuestionDao getQuestiondao() {
			return questiondao;
		}

		public void setQuestiondao(QuestionDao questiondao) {
			this.questiondao = questiondao;
		}

		@SuppressWarnings("unchecked")
		@Override
	    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	        String condition = req.getParameter("condition");
	        String totalUsersStr = req.getParameter("totalUsers");
	        
	        int totalUsers_page;
	        if(totalUsersStr == null) {
	        	totalUsers_page = -1;
	        }
	        else {
	        	totalUsers_page = Integer.parseInt(totalUsersStr);
	        }
	        questions = questiondao.list_questions(condition,totalUsers_page);
	        
	        Collections.sort(questions, new SortOptionalquestion());
	        
			String p = req.getParameter("page");
	        int page;
	        try {
	            //当前页数
	            page = Integer.valueOf(p);
	        } catch (NumberFormatException e) {
	            page = 1;
	        }
	        //用户总数
	        int totalUsers = questions.size();
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
	        req.setAttribute("questions", questions);
	        req.getRequestDispatcher("jsp/manager/manager_optionalquestion.jsp").forward(req, resp);
	    }

	    @Override
		public void init(ServletConfig config) throws ServletException {
	    	super.init(config);
	    	SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this,config.getServletContext());
		}


}
