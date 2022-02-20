package servlet;

import java.awt.Color;  
import java.awt.Font;  
import java.awt.Graphics;  
import java.awt.image.BufferedImage;  
import java.io.IOException;  
import java.util.Iterator;  
  
import javax.imageio.IIOImage;  
import javax.imageio.ImageIO;  
import javax.imageio.ImageTypeSpecifier;  
import javax.imageio.ImageWriteParam;  
import javax.imageio.ImageWriter;  
import javax.imageio.stream.ImageOutputStream;  
import javax.servlet.ServletException;  
import javax.servlet.ServletOutputStream;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession;  
   
public class ValidateCode extends HttpServlet {  
	private static final long serialVersionUID = 5952689219411916553L;
    public static final String VALIDATE_CODE_KEY = "ValidateCode";  
  
    public void doGet(HttpServletRequest request, HttpServletResponse response)  
    		throws ServletException, IOException {  
	   	response.setContentType("image/jpeg");  
		HttpSession session = request.getSession();  
		String code = generateString();  
		session.setAttribute(VALIDATE_CODE_KEY, code);  
		BufferedImage image = generateImage(code);  
		outputImage(image, response.getOutputStream());  
    }  
 
    private void outputImage(BufferedImage image, ServletOutputStream out)  
		throws IOException {  
		ImageWriter writer = null;  

		//下面进行对图片格式的一些修改  
		ImageTypeSpecifier type =  ImageTypeSpecifier.createFromRenderedImage(image);  

		/*SuppressWarnings压制警告，即去除警告
		rawtypes是说传参时也要传递带泛型的参数*/
        @SuppressWarnings("rawtypes")
		Iterator iter = ImageIO.getImageWriters(type, "jpg");  
            if (iter.hasNext()) {  
            	writer = (ImageWriter) iter.next();  
        	}  
  
            IIOImage iioImage = new IIOImage(image, null, null);  
            ImageWriteParam param = writer.getDefaultWriteParam();  
            param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);  
            param.setCompressionQuality(1.0F);  
            ImageOutputStream outputStream = ImageIO.createImageOutputStream(out);  

            //将构建好的图片输出流写入到页面中  
        writer.setOutput(outputStream);  
        writer.write(null, iioImage, param);  
    }  
  
    private String generateString() {  
    	int a = (int) (Math.random() * 10);  
    	int b = (int) (Math.random() * 10);  
    	int c = (int) (Math.random() * 10);  
    	int d = (int) (Math.random() * 10);  
    	return "" + a + b + c + d;  
    }  
  
    //生成图片的方法  
    private BufferedImage generateImage(String code) {  
    	BufferedImage image = new BufferedImage(100, 30,  
		BufferedImage.TYPE_INT_RGB);  
    	Graphics g = image.getGraphics();  
    	g.setColor(Color.white);  
    	g.fillRect(1, 1, 98, 28);  
    	for (int i = 0; i < 20; i++) {  
    		g.setColor(generateColor());  
    		int x1 = (int) (Math.random() * 100);  
    		int y1 = (int) (Math.random() * 30);  
    		int x2 = (int) (Math.random() * 100);  
    		int y2 = (int) (Math.random() * 30);  
    		g.drawLine(x1, y1, x2, y2);  
		}  
    	g.setFont(new Font("IMPACT", Font.PLAIN,  
		20 + (int) (Math.random() * 10)));  
    	g.setColor(generateColor());  
    	g.drawString(code.charAt(0) + "", 5, 28);  
    	g.setFont(new Font("IMPACT", Font.PLAIN,  
		20 + (int) (Math.random() * 10)));  
    	g.setColor(generateColor());  
    	g.drawString(code.charAt(1) + "", 30, 28);  
    	g.setFont(new Font("IMPACT", Font.PLAIN,  
		20 + (int) (Math.random() * 10)));  
    	g.setColor(generateColor());  
    	g.drawString(code.charAt(2) + "", 55, 28);  
    	g.setFont(new Font("IMPACT", Font.PLAIN,  
		20 + (int) (Math.random() * 10)));  
    	g.setColor(generateColor());  
    	g.drawString(code.charAt(3) + "", 80, 28);  
    	return image;
	}  
  
    private Color generateColor() {  
    	int r = (int) (Math.random() * 180);  
    	int g = (int) (Math.random() * 180);  
    	int b = (int) (Math.random() * 180);  
    	return new Color(r, g, b);  
	}  
  
}  
