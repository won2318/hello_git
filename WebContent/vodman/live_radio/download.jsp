<%@ page contentType="text/html; charset=euc-kr"%><%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,java.text.DecimalFormat"%><%@ page import="org.apache.commons.lang.StringUtils" %><%
	String rcode = "";
	if(request.getParameter("rcode") == null
		|| request.getParameter("rcode").length()<=0 
		|| request.getParameter("rcode").equals("null")
		|| !com.yundara.util.TextUtil.isNumeric(request.getParameter("rcode"))) {
		//out.println("<script lanauage='javascript'>alert('잘 못된 요청입니다.'); history.go(-1); </script>");
		out.println("<script lanauage='javascript'>alert('잘 못된 요청입니다.');  </script>");
	} else
		rcode = request.getParameter("rcode");
	
	String rflag = request.getParameter("rflag");
	if(rflag == null) rflag = "R";
	
	com.hrlee.sqlbean.LiveManager mgr = com.hrlee.sqlbean.LiveManager.getInstance();
	
	Vector vt = mgr.getLive(rcode,rflag);
	
    com.hrlee.sqlbean.LiveInfoBean linfo = new com.hrlee.sqlbean.LiveInfoBean();
    com.vodcaster.sqlbean.DirectoryNameManager Dmanager = new com.vodcaster.sqlbean.DirectoryNameManager();

    try {
		Enumeration e = vt.elements();
        Hashtable ht = (Hashtable)e.nextElement();

        com.yundara.beans.BeanUtils.fill(linfo, ht);
	} catch (Exception e) {}
	
	boolean isView = true;
	String ofilename = "";
	if (StringUtils.isNotEmpty(linfo.getRfilename())) {
		isView = true;
	} else {
		//미디어 아이디가 없는 경우 
		isView = false;
	}

	if(isView) {
		
		String filename = linfo.getRfilename();
		String org_data_file = "";
		
		 org_data_file = filename;
     	if (linfo.getOrg_rfilename() != null && linfo.getOrg_rfilename().length() > 0) {
     		org_data_file = linfo.getOrg_rfilename();
     	}
     	

		String UPLOADFILE = Dmanager.UPLOAD_RESERVE + "/" + filename;
	
	
		File file = new File(  UPLOADFILE   ); // 절대경로입니다.
		if ( file.isFile())
		{
			response.setContentType("application/octet-stream");
			byte b[] = new byte[(int)file.length()];
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
				out.println("<script>");
				out.println("alert('첨부파일 다운로드 실패');\n");
				out.println("</script>");
	        }
	        finally {
	            if(in != null) try{in.close();}catch(Exception e){}
	            if(os != null) try{os.close();}catch(Exception e){}
	        }
		}
		else{
			out.println("<script>");
			out.println("alert('첨부파일 다운로드 실패');\n");
			//out.println("history.go(-1)");
			out.println("</script>");
		}

	} else {
		out.println("<script>");
		out.println("alert('첨부파일 다운로드 실패');\n");
		out.println("</script>");
	}
%>