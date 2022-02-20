package tool;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


import sun.misc.BASE64Encoder;
 
public class CipherEncryption {
	@SuppressWarnings("static-access")
	public String encryption(String pwd) {
		return String.valueOf(this.getMD5(pwd));
	}
	
	//MD5加密
	@SuppressWarnings("unused")
	private static byte[] encrypt(String msg) {
		try {
		    //生成MessageDigest对象
		    MessageDigest md5 = MessageDigest.getInstance("MD5");
		    
		    /*byte[] srcBytes = msg.getBytes();
		    
		    //更新摘要
		    md5.update(srcBytes);*/
		    
		    //完成hash计算。得到result
		    byte[] resulBytes=md5.digest();
		    
		    return resulBytes;
	    } catch (NoSuchAlgorithmException e) {
	    	//handle exception
	    	e.printStackTrace();
	    }
	    return null;
    }

    public static String getMD5(String str){
        String newStr = null;
        try {
            // 确定计算方法
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            BASE64Encoder base64e = new BASE64Encoder();
            // 加密后的字符串
            newStr = base64e.encode(md5.digest(str.getBytes()));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return newStr;// 16位的加密
    }


	/*
	public static void main(String[] args) {
		String code = String.valueOf(encrypt("123456"));
		System.out.println(code);
	}
	*/
}