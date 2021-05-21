<%@ page contentType="text/html;" %><%@ page import="java.util.*,java.io.*,java.sql.*,java.text.*, com.vodcaster.sqlbean.DirectoryNameManager, com.yundara.util.CharacterSet"%><jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/><jsp:useBean id="BoardListSQLBean" class="com.vodcaster.sqlbean.BoardListSQLBean"/><%

	String chkPath = "";
	com.vodcaster.sqlbean.DirectoryNameManager DirectoryNameManager = new com.vodcaster.sqlbean.DirectoryNameManager();

	
	String file_name = "";

	try{
		if(request.getParameter("chkPath") == null || request.getParameter("chkPath").length()<=0 || request.getParameter("chkPath").equals("null"))
		{
			return ;
		}
		chkPath = request.getParameter("chkPath").replaceAll("<","").replaceAll(">","");
		if(chkPath.indexOf("/") >= 0 || chkPath.indexOf("..") >= 0 ){
			return;
		}
		file_name = chkPath;
    }catch(NullPointerException e){
		return;
	}

	String UPLOADFILE = DirectoryNameManager.UPLOAD_MEDIA+"/avi/" + file_name; 

	File file = new File(  UPLOADFILE   ); // 절대경로입니다.
	if ( file.isFile())
	{
		response.setContentType("application/octet-stream");
		 
		String strClient=request.getHeader("User-Agent");
		
		
		if( strClient.indexOf("MSIE 5.5") != -1 ) {
			response.setHeader("Content-Type", "doesn/matter;");
			response.setHeader("Content-Disposition", "filename=" + new String(file_name.getBytes("euc-kr"),"8859_1") + ";");
		} else {
			response.setHeader("Content-Type", "application/octet-stream;");
			response.setHeader("Content-Disposition", "attachment;filename="+new String(file_name.getBytes("euc-kr"),"8859_1") + ";");
		};
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Content-Length", ""+file.length());
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");

		//BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
		//BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
		
		int read = 0;
		InputStream in = null;
        OutputStream os = null;
        try {
            in = new FileInputStream(file);
            os = response.getOutputStream();
            //  PrintWriter out  = res.getWriter();

            byte[] buf = new byte[4096]; //buffer size 4K.
            // NOTE: do NOT use : 
            //       byte[] buf =  new byte[file.length()];
            //       this could lead a memory problem.
            int count = 0;
            while ((count = in.read(buf)) != -1) {
                os.write(buf,0,count);
                os.flush();
            }
        }
        catch(Exception e){
            // There is nothing you can do at this time 
            // because HEADER is alreay set as "application/octet-stream"
            // System.out.println(e.toString());
        }
        finally {
            if(in != null) try{in.close();}catch(Exception e){}
            if(os != null) try{os.close();}catch(Exception e){}
        }
	}
	else{
		//System.out.println(" not exist file ");
	}
%>