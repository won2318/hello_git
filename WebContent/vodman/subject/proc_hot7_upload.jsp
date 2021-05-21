<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*,java.io.*"%>
<%@ page import="com.vodcaster.multpart.MultipartRequest, com.vodcaster.multpart.DefaultFileRenamePolicyITNC21"%>
<%@ include file="/vodman/include/auth.jsp"%>

<%
if(!chk_auth(vod_id, vod_level, "led_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
 
<%
    request.setCharacterEncoding("euc-kr");

	String num = request.getParameter("num").replaceAll("<","").replaceAll(">",""); 
	if(num == null){
		out.println("<script lanauage='javascript'>alert('미디어 코드가 없습니다. 다시 선택해주세요.'); history.go(-1); </script>");
	}

 
    try {
 
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD + "/subject";
		MultipartRequest multi = new MultipartRequest(request, UPLOAD_PATH, 20 * 1024 * 1024, new DefaultFileRenamePolicyITNC21());
		String question_image = "";
		 
		 try {
			 if (multi.getFilesystemName("img_upload") != null )
				 question_image = multi.getFilesystemName("img_upload");
			} catch(Exception e) {
				question_image = "";

			}
		 
		String ans_content = CharacterSet.toKorean(multi.getParameter("title").replaceAll("<","").replaceAll(">",""));
		String ans_etc = CharacterSet.toKorean(multi.getParameter("content").replaceAll("<","").replaceAll(">",""));
		
		if(question_image != null && question_image.length() > 0){
			out.println("<script language='javascript'>"+
			"window.opener.document.getElementById('ans_content_"+num+"').value='"+ans_content+"';"+ 
			"window.opener.document.getElementById('ans_etc_"+num+"').value='"+ans_etc+"';"+
			"window.opener.document.getElementById('ans_img_"+num+"').value='/upload/subject/"+question_image+"';"+ 
			"window.opener.document.getElementById('ans_hot7_ocode_"+num+"').value='';"+ 
			"self.close();"+
			"</script>");
 	 
 		}
		else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('오류가 발생하였습니다. 관리자에게 문의 하세요.')");
			out.println("self.close()");
			out.println("</SCRIPT>");
		}
    } catch(Exception e){
        System.out.println(e);
    }

%>