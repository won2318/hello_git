<%@ page contentType="image/jpeg" %><%@ page import="java.io.*" %><%@ page import="java.awt.*" %><%@ page import="java.awt.image.*" %><%@ page import="javax.imageio.*" %><%@ page import="javax.imageio.stream.*" %><%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*, com.vodcaster.utils.*"%><%@page import="com.yundara.util.TextUtil"%><jsp:useBean id="boardBean" class="com.vodcaster.sqlbean.BoardListSQLBean"/><%

String no = "";
 if (request.getParameter("no") != null && request.getParameter("no").length() > 0) {
	 if (!request.getParameter("no").equals("0")  && com.yundara.util.TextUtil.isNumeric(request.getParameter("no"))) {
			no =TextUtil.nvl(request.getParameter("no"));
	 } 
 }

String list_id = TextUtil.nvl(request.getParameter("list_id"));
if(list_id == null || !com.yundara.util.TextUtil.isNumeric(com.vodcaster.utils.TextUtil.getValue(list_id))){
		out.println("<script lanauage='javascript'>alert('Àß¸øµÈ Á¢±Ù ÀÔ´Ï´Ù. ÀÌÀü ÆäÀÌÁö·Î µ¹¾Æ°©´Ï´Ù.'); history.go(-1); </script>");
}
if(list_id.equals(""))
{
	out.println("<SCRIPT LANGUAGE='JavaScript'>");
	out.println("alert('Àß¸øµÈ Á¢±Ù ÀÔ´Ï´Ù. ÀÌÀü ÆäÀÌÁö·Î µ¹¾Æ°©´Ï´Ù.')");
	out.println("history.go(-1)");
	out.println("</SCRIPT>");
}

String list_image_file = "";
String list_image_file2 = "";
String list_image_file3 = "";
String list_image_file4 = "";
String list_image_file5 = "";
String list_image_file6 = "";
String list_image_file7 = "";
String list_image_file8 = "";
String list_image_file9 = "";
String list_image_file10 = "";


 
Vector vt_result = boardBean.getBoardList_view(list_id);
if(vt_result != null && vt_result.size() > 0)
{
	Hashtable ht_list = (Hashtable)vt_result.get(0); 
	list_image_file = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file"+no)));
  	
}

String real_file = DirectoryNameManager.UPLOAD+"/board_list/"+list_image_file;
File file = new File(real_file);

if(!file.exists()) {
	real_file = DirectoryNameManager.UPLOAD+"/noimg.gif";
}
 
 try{
	 BufferedImage im = new BufferedImage(100, 50, BufferedImage.TYPE_INT_RGB);
	
	 im = ImageIO.read(new File(real_file));
	  
	  Graphics g = im.getGraphics();
	  g.dispose();
	 
	   ServletOutputStream sos = null;
	// 1. ¹ÙÀÌ³Ê¸®¸¦ Å©¶óÀÌ¾ðÆ® Ãø¿¡ Àü¼ÛÇÏ±â À§ÇØ ÁØºñµÈ ServletOutputStream ÀÎ½ºÅÏ½º¸¦ »ç¿ë.
	
	 try{
	  String temp_name = real_file.substring(real_file.lastIndexOf(".")+1,real_file.length());
	  sos = response.getOutputStream();
	  ImageOutputStream ios = ImageIO.createImageOutputStream(sos);
	
	/*  2. ImageOutputStream : ÀÌ¹ÌÁö¸¦ Ãâ·ÂÇÏ´Â ÀÎ½ºÅÏ½º·Î ImageWriter µîÀÌ »ç¿ëÇÏ´Â ÀÌ¹ÌÁö Ãâ·Â¿ë ½ºÆ®¸²ÀÌ´Ù. */
	  ImageWriter iw = (ImageWriter)ImageIO.getImageWritersByFormatName(temp_name).next();
	 /* 3. JPEG µ¥ÀÌÅÍ¸¦ Ãâ·ÂÇÏ±â À§ÇØ »ç¿ë. ÀÌ·± ¹æ¹ýÀÌ ÀÌ¹ÌÁö¸¦ Å¬¶óÀÌ¾ðÆ®¿¡ Ãâ·Â½ÃÅ°´Â write(½ºÆ®¸²)ÀÌ´Ù. */
	
	  iw.setOutput(ios);
	
	// 4. ¾ò¾îÁø ImageWriterÀÇ Ãâ·ÂÃ³¿¡ ¾Õ¿¡¼­ ¾òÀº ImageOutputStreamÀ» ¼³Á¤ÇÑ´Ù.
	if (!iw.canWriteEmpty()) {
	  iw.write(im);
	  im.flush();
	}
	// 5. ImageWriter¿¡ ÀÌ¹ÌÁö¸¦ Ãâ·ÂÇÑ´Ù.
	 
	ios.close();
	 
	 
	 }catch(Exception e){
	  e.printStackTrace();
	 }finally{
	  try{
	   sos.close();
	
	// 6. ServletOutputStreamÀ» ´Ý¾Æ¼­ Á¾·áÇÑ´Ù.
	  }catch(Exception e){
	   e.printStackTrace();
	  }
	 }
 }catch(Exception e2){
	 out.println("오류가 발생 하였습니다. 관리자에게 문의 주세요");
  } 
%>