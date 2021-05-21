<%@ page contentType="application;" %><%@ page import="java.util.*,java.io.*,java.sql.*,java.text.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%><jsp:useBean id="DirectoryNameManager" class="com.vodcaster.sqlbean.DirectoryNameManager"/><%
request.setCharacterEncoding("EUC-KR");
String file_name = request.getParameter("file").replaceAll("<","").replaceAll(">","");

String UPLOADFILE = DirectoryNameManager.UPLOAD_BORADLIST+"/" + file_name; 

File file = new File(CharacterSet.toKorean( UPLOADFILE ) ); // 절대경로입니다.
byte b[] = new byte[(int)file.length()];

	String strClient=request.getHeader("User-Agent");
            if(strClient.indexOf("MSIE 7.5")>-1) {
				response.setHeader("Content-Disposition", "filename=" + file_name + ";");
            } else {
				response.setHeader("Content-Disposition", "attachment;filename=" + file_name + ";");

				response.setHeader("Content-Transfer-Encoding", "binary;"); 
				response.setHeader("Pragma", "no-cache;"); 
				response.setHeader("Expires", "-1;"); 
				response.setContentLength((int)file.length()); //파일크기를 브라우저에 알려준다

            }

if ( file.isFile())
{
	System.out.println("file.isFile() = " + file.isFile());
	BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
	BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
	int read = 0;
	try {

		while ((read = fin.read(b)) != -1){
			outs.write(b,0,read);
		}
		outs.close();
		fin.close();
	} catch (Exception e) {
		System.out.println("e.getMessage() == "+e.getMessage());
	} finally {
		if(outs!=null) outs.close();
		if(fin!=null) fin.close();
	}
}
else{
	System.out.println("else file.isFile() = " + file.isFile());
}
%>