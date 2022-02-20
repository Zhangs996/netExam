package util;

import java.io.IOException;

import org.json.JSONException;

import com.github.qcloudsms.SmsSingleSender;
import com.github.qcloudsms.httpclient.HTTPException;

public class SendMessage {
	public static boolean sendAMessage(String phoneNumber, String vCode) {//给指定的手机号码发送一条短信
		String[] params = new String[1];
		params[0] = vCode;//六位数验证码 
		int appid = 1400194291;
		String appkey = "1c95333cd80dd4c28ff0b90d54e1beae";
		int templateId = 295077;//模板ID
		SmsSingleSender sender = new SmsSingleSender(appid, appkey);
		try {
			System.out.println(sender.sendWithParam("86", phoneNumber, templateId, params, "线上考试星:", "", ""));
			return true;
		} catch (JSONException e) {
			e.printStackTrace();
		} catch (HTTPException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		};
		return false;
	}
}
