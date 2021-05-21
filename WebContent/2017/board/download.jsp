<%@ page contentType="text/html;" %><%@ page import="java.util.*,java.io.*,java.sql.*,java.text.*, org.apache.commons.lang.math.NumberUtils, com.vodcaster.sqlbean.DirectoryNameManager, com.yundara.util.CharacterSet"%><jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/><jsp:useBean id="BoardListSQLBean" class="com.vodcaster.sqlbean.BoardListSQLBean"/><%

	int board_id = NumberUtils.toInt(request.getParameter("board_id"), 0);
	int list_id = NumberUtils.toInt(request.getParameter("list_id"), 0);
 

	com.vodcaster.sqlbean.DirectoryNameManager DirectoryNameManager = new com.vodcaster.sqlbean.DirectoryNameManager();

	Vector v_bl = null;
	String file_name = "";
	String org_attach_name = "";

	try{
        v_bl = BoardListSQLBean.getOnlyBoardList(board_id,list_id);

        if(v_bl != null && v_bl.size() > 0){
        	file_name = String.valueOf(v_bl.elementAt(7));
        	org_attach_name = file_name;
        	if (org_attach_name != null && org_attach_name.length() > 0) {
        		org_attach_name = String.valueOf(v_bl.elementAt(43));
        	}
        }
    }catch(NullPointerException e){
	System.out.println(e);
	}

	String UPLOADFILE = DirectoryNameManager.UPLOAD_BORADLIST+"/" + file_name; 

	File file = new File(  UPLOADFILE   );  
	if ( file.isFile())
	{
		response.setContentType("application/octet-stream");
		 
		String strClient=request.getHeader("User-Agent");
		
		
		if( strClient.indexOf("MSIE 5.5") != -1 ) {
			response.setHeader("Content-Type", "doesn/matter;");
			response.setHeader("Content-Disposition", "filename=" + new String(org_attach_name.getBytes("euc-kr"),"8859_1") + ";");
		} else {
			response.setHeader("Content-Type", "application/octet-stream;");
			response.setHeader("Content-Disposition", "attachment;filename="+new String(org_attach_name.getBytes("euc-kr"),"8859_1") + ";");
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
			out.clear();
			out=pageContext.pushBody();
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