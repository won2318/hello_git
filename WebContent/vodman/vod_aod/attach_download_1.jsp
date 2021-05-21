<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.yundara.util.*,com.vodcaster.sqlbean.DirectoryNameManager,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>

<%@ include file="/2012/include/chkLogin.jsp" %>
<%
	com.hrlee.silver.OrderMediaInfoBean omiBean = new com.hrlee.silver.OrderMediaInfoBean();
//request.setCharacterEncoding("euc-kr");
	MediaManager mgr = MediaManager.getInstance();
	Hashtable result_ht = null;
	String strMenuName = "";
 
	String ocode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ocode"));
	if (ocode == null || ocode.length() <= 0) {
		ocode = "";
	}
	
//	com.vodcaster.sqlbean.DirectoryNameManager DirectoryNameManager = new com.vodcaster.sqlbean.DirectoryNameManager();
	
	boolean isView = true;
	boolean bOmibean = false;
	
	Vector vo = null;
	if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode)) {
		vo = mgr.getOMediaInfo(ocode);

	} else {
			out.println("<script language='javascript'>\n" +
						"window.close();\n" +
						"</script>");
			return;
	}
	
	int auth_v = 1;
	if (vo != null && vo.size() > 0) {
		try {
			Enumeration e2 = vo.elements();
			com.yundara.beans.BeanUtils.fill(omiBean, (Hashtable) e2.nextElement());
			bOmibean = true;
		} catch (Exception e2) {
			System.err.println(e2.getMessage());
			isView = false;
			out.println("<script language='javascript'>\n" +
						"window.close();\n" +
						"</script>");
			return;
		}
	}else{
		out.println("<script language='javascript'>\n" +
						"window.close();\n" +
						"</script>");
			return;
	}

	String ofilename = "";
	if (StringUtils.isNotEmpty(omiBean.getAttach_file())) {
		isView = true;
	} else {
		//미디어 아이디가 없는 경우 
		isView = false;
		out.println("<script language='javascript'>\n" +
						"window.close();\n" +
						"</script>");
			return;
	}

	try{
	  String path =   com.vodcaster.sqlbean.DirectoryNameManager.UPLOAD_VOD +omiBean.getAttach_file();
	  String fileName = omiBean.getAttach_file();
	  String org_fileName = fileName;
	  if (omiBean.getOrg_attach_file() != null && omiBean.getOrg_attach_file().length() > 0) {
		  org_fileName = omiBean.getOrg_attach_file();
	  }
	  //String fileName2 = new String(org_fileName.getBytes("8859_1"), "MS949");
	  String fileName2 = new String(org_fileName.getBytes("euc-kr"), "8859_1");
	  String loadedSize = request.getParameter("_filesize").replaceAll("<","").replaceAll(">","");

	  //File file = new File(path + fileName2);
	  File file = new File(path );

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
<html>
<head>
<title>download</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
 </head>
 <body>

 </body>
 </html>