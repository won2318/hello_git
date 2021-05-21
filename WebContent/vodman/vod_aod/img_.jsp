<%@ page contentType="image/jpeg" %><%@ page import="java.io.*" %><%@ page import="java.awt.*" %><%@ page import="java.awt.image.*" %><%@ page import="javax.imageio.*" %><%@ page import="javax.imageio.stream.*" %><%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*, com.vodcaster.utils.*"%><%@page import="com.yundara.util.TextUtil"%><jsp:useBean id="boardBean" class="com.vodcaster.sqlbean.BoardListSQLBean"/><%

String no = "";
 if (request.getParameter("no") != null && request.getParameter("no").length() > 0) {
	 if (request.getParameter("no") != null && !request.getParameter("no").equals("0") ) {
			no =TextUtil.nvl(request.getParameter("no").replaceAll("<","").replaceAll(">",""));
	 }
 } 
 com.hrlee.sqlbean.MediaManager mgr = com.hrlee.sqlbean.MediaManager.getInstance();
 
String list_image_file = mgr.getReturn_Thumbnil(no);		
 
String real_file = DirectoryNameManager.UPLOAD_VOD+"/"+list_image_file;
File file = new File(real_file);

if(!file.exists()) {
	real_file = DirectoryNameManager.UPLOAD+"/noimg.gif";
}
 FileInputStream is = null;
 BufferedInputStream bis = null;
 try{
  bis = new BufferedInputStream(is);
 }catch(Exception e){
  e.printStackTrace();
 }finally{
  try{
  }catch(Exception e){
   e.printStackTrace();
  }
 }
 try{
	 BufferedImage im = new BufferedImage(100, 50, BufferedImage.TYPE_INT_RGB);
	
	 im = ImageIO.read(new File(real_file));
	  
	  Graphics g = im.getGraphics();
	  g.dispose();
	 
	   ServletOutputStream sos = null;
	// 1. 바이너리를 크라이언트 측에 전송하기 위해 준비된 ServletOutputStream 인스턴스를 사용.
	
	 try{
	  sos = response.getOutputStream();
	  ImageOutputStream ios = ImageIO.createImageOutputStream(sos);
	
	/*  2. ImageOutputStream : 이미지를 출력하는 인스턴스로 ImageWriter 등이 사용하는 이미지 출력용 스트림이다. */
	  ImageWriter iw = (ImageWriter)ImageIO.getImageWritersByFormatName("jpeg").next();
	 /* 3. JPEG 데이터를 출력하기 위해 사용. 이런 방법이 이미지를 클라이언트에 출력시키는 write(스트림)이다. */
	
	  iw.setOutput(ios);
	
	// 4. 얻어진 ImageWriter의 출력처에 앞에서 얻은 ImageOutputStream을 설정한다.
	if (!iw.canWriteEmpty()) {
	  iw.write(im);
	  im.flush();
	}
	// 5. ImageWriter에 이미지를 출력한다.
	 
	ios.close();
	 
	 
	 }catch(Exception e){
	  e.printStackTrace();
	 }finally{
	  try{
	   sos.close();
	
	// 6. ServletOutputStream을 닫아서 종료한다.
	  }catch(Exception e){
	   e.printStackTrace();
	  }
	 }
 }catch(Exception e2){
   out.println(e2);
  } 
 
%>