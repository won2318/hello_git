<%@ page contentType="text/html;" %><%@ page import="java.util.*,java.io.*,java.sql.*,java.text.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.DirectoryNameManager, com.yundara.util.CharacterSet"%><%
	String seq = "";
	
	if(request.getParameter("seq") != null) {
		seq = request.getParameter("seq");
	}else{
		out.println("<script lanauage='javascript'>alert('Àß¸øµÈ Á¢±ÙÀÔ´Ï´Ù.'); </script>");
	}
 
	com.vodcaster.sqlbean.DirectoryNameManager DirectoryNameManager = new com.vodcaster.sqlbean.DirectoryNameManager();

	 
	String file_name = "";
	String org_data_file = "";

	try{
 
		EventManager mgr = EventManager.getInstance();
		com.hrlee.sqlbean.EventInfoBean info = new com.hrlee.sqlbean.EventInfoBean();
		Vector vt = mgr.getEvent(seq);
		try {
			Enumeration e = vt.elements();
	        Hashtable ht = (Hashtable)e.nextElement();
	        com.yundara.beans.BeanUtils.fill(info, ht);
	        
	        file_name =  info.getList_data_file();
	        
	        org_data_file = file_name;
        	if (info.getOrg_data_file() != null && info.getOrg_data_file().length() > 0) {
        		org_data_file = info.getOrg_data_file();
        	}
        	
			out.println(DirectoryNameManager.UPLOAD+"/event/" + file_name);
 
		} catch (Exception e) {
			 out.println("오류가 발생 하였습니다. 관리자에게 문의 주세요");
		}
    }catch(NullPointerException e){
	System.out.println(e);
	}

	String UPLOADFILE = DirectoryNameManager.UPLOAD+"/event/" + file_name; 

	File file = new File(  UPLOADFILE   );  
	if ( file.isFile())
	{
		response.setContentType("application/octet-stream");
		 
		String strClient=request.getHeader("User-Agent");
		
		
		if( strClient.indexOf("MSIE 5.5") != -1 ) {
			response.setHeader("Content-Type", "doesn/matter;");
			response.setHeader("Content-Disposition", "filename=" + new String(org_data_file.getBytes("euc-kr"),"8859_1") + ";");
		} else {
			response.setHeader("Content-Type", "application/octet-stream;");
			response.setHeader("Content-Disposition", "attachment;filename="+new String(org_data_file.getBytes("euc-kr"),"8859_1") + ";");
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