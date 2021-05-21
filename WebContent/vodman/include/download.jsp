<%@ page contentType="application; charset=euc-kr"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%
try {
  String path = "c:\\des\\";
  String fileName = request.getParameter("_filename");
  String fileName2 = new String(fileName.getBytes("8859_1"), "MS949");
  String loadedSize = request.getParameter("_filesize");

  File file = new File(path + fileName2);

  response.reset() ;
  response.setContentType("application/x-octetstream");

  response.setHeader("Accept-Ranges", "bytes");
  response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName2 +"\"" );
  

	int read = 0;
	long size=0;
	if(	loadedSize != null )
	{
		size = Long.parseLong(loadedSize);
	}
	response.setHeader("Content-Length", ""+ (file.length()-size) );
	
	FileInputStream fs = new FileInputStream(file);
	BufferedInputStream in = new BufferedInputStream(fs);
	BufferedOutputStream os = new BufferedOutputStream(response.getOutputStream());
	
	if( size != 0 )
	{
		long n = in.skip(size);
		if(n == -1)
		{	
			read = -1;
		}
	}

	while(  ( read = in.read() ) != -1  )
	{
		os.write(read);
	}

  fs.close();
  in.close();
  os.close();

 } catch(Exception e) {
  e.printStackTrace();
  System.out.println("error");    
 }
%>