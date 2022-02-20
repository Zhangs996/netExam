package interceptor;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

import action.ExamAction;

public class ExamInterceptor extends AbstractInterceptor{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public String intercept(ActionInvocation arg0) throws Exception {
		
		//获取ExamAction对象
		ExamAction examAction = (ExamAction)arg0.getAction();
		
		//执行examAction的校验方法
		String message = examAction.question_num_validation();
		
		//如果校验无问题，继续执行
		if(message.equals("")) {
			return arg0.invoke();
		}
		
		//校验有问题，返回当前页
		examAction.setMessage(message);
		return Action.INPUT;
	}
}
