<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page language="java" import="java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*" %>
<%@ page import="java.util.*,java.io.*, javax.mail.*,javax.mail.internet.*,javax.activation.*" %> 
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="emailTransferBean" class="com.vodcaster.utils.EmailTransferBean"/>
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
<%
	String sex = "";
	String level = "";
	String useMailling = "";
	String joinDate1 = "";
	String joinDate2 = "";
	String searchField = "";
	String searchString = "";
	
	if(request.getParameter("sex") != null && request.getParameter("sex").length() > 0 && !request.getParameter("sex").equals("null"))
		sex = request.getParameter("sex");
	
	if(request.getParameter("level") != null && request.getParameter("level").length() > 0 && !request.getParameter("level").equals("null"))
		level = request.getParameter("level");
	
	if(request.getParameter("useMailling") != null && request.getParameter("useMailling").length() > 0 && !request.getParameter("useMailling").equals("null"))
		useMailling = request.getParameter("useMailling");
	
	if(request.getParameter("joinDate1") != null && request.getParameter("joinDate1").length() > 0 && !request.getParameter("joinDate1").equals("null"))
		joinDate1 = request.getParameter("joinDate1");
	
	if(request.getParameter("joinDate2") != null && request.getParameter("joinDate2").length() > 0 && !request.getParameter("joinDate2").equals("null"))
		joinDate2 = request.getParameter("joinDate2");
	
	if(request.getParameter("searchField") != null && request.getParameter("searchField").length() > 0 && !request.getParameter("searchField").equals("null"))
		searchField = request.getParameter("searchField");
	
	if(request.getParameter("searchString") != null && request.getParameter("searchString").length() > 0 && !request.getParameter("searchString").equals("null"))
		searchString = CharacterSet.toKorean(request.getParameter("searchString"));
	
	String strLink = "sex=" +sex+ "&level=" +level+ "&useMailling=" +useMailling+ "&joinDate1=" +joinDate1+ "&joinDate2=" +joinDate2+ "&searchField=" +searchField+ "&searchString=" +searchString;


	String from_name = "";
	if(request.getParameter("from_name") != null && request.getParameter("from_name").length() > 0){
		from_name = CharacterSet.toKorean(request.getParameter("from_name"));
	}
	
	String from_email = "";
	if(request.getParameter("from_email") != null && request.getParameter("from_email").length() > 0){
		from_email = CharacterSet.toKorean(request.getParameter("from_email"));
	}
	
	String title = "";
	if(request.getParameter("title") != null && request.getParameter("title").length() > 0){
		title = CharacterSet.toKorean(request.getParameter("title"));
	}

	String message = "";
	if(request.getParameter("message") != null && request.getParameter("message").length() > 0){
		message = CharacterSet.toKorean(request.getParameter("message"));
	}
	
	try {
		MemberManager mgr = MemberManager.getInstance();
		MemberInfoBean bean = new MemberInfoBean();
	

		Vector vt = mgr.getMemberListAll(sex, level, useMailling, joinDate1, joinDate2, searchField, searchString);

		if(vt != null && vt.size() > 0) {
			
			try {
				String [] email_array = new String[vt.size()];
			    String [] name_array = new String[vt.size()];
			    
				for(int i=0; i< vt.size(); i++) {
					name_array[i] = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(3));
					email_array[i] = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(4));
				}

				com.vodcaster.sqlbean.DirectoryNameManager Dmanager = new com.vodcaster.sqlbean.DirectoryNameManager();
				String domain = "http://"+ Dmanager.SERVERNAME;
				String path = Dmanager.VODROOT + "/vodman/member/sendmail/mailform.html";
				String body = CharacterSet.toKorean( com.vodcaster.utils.TextUtil.getText( path ) );
				
				message = chb.getContent(message,"false");
				
				body = TextUtil.replace(body, "#mail_title#", title);
				body = TextUtil.replace(body, "#mail_contents#", message);
				body = TextUtil.replace(body, "#domain#", domain);

				out.println(body);
				
				int result = emailTransferBean.sendEmailAllMemeber(from_name, from_email, title, email_array,name_array, body );
				
				if( result > 0) {
					out.println("<script>" + 
								"	alert('전체 발송 메일을 보냈습니다.');" +
								"	location.href = '/vodman/member/mng_memberList.jsp?mcode=1001';" +
								"</script>");
				} else {
					out.println("<script>" + 
							"	alert('전체 메일 보내기에 실패하였습니다.');" +
							"	history.go(-1);" +
							"</script>");
				}

			} catch (Exception e) {
				out.println("<script>" + 
							"	alert('메일을 보내는 중에 오류가 발생하였습니다.');" +
							"	history.go(-1);" +
							"</script>");
			}
			
		} else {
			out.println("<script>" + 
							"	alert('메일 수신인이 없습니다.');" +
							"	history.go(-1);" +
							"</script>");
		}

	}catch(Exception e) {
		System.out.println(e);
		//out.println(e);
		out.println("<script>" + 
							"	alert('처리 중 오류가 발생했습니다. 이전 페이지로 이동합니다.');" +
							"	history.go(-1);" +
							"</script>");
	}


%>
