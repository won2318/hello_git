<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %> 
<%@ page import="com.yundara.util.*"%>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
 <script>
	function resizeFrame(frm) {
		if (navigator.userAgent.indexOf("Firefox")> -1 ){					
			var baseHeight=document.getElementById(frm).scrollHeight;
			thisHeight=document.getElementById(frm).contentWindow.document.body.scrollHeight;			
			if(thisHeight>baseHeight){			 			
			document.getElementById(frm).height=thisHeight;			 
			}else{					
			//기본사이즈보다 작아도 기본사이즈 유지			 
			document.getElementById(frm).height=baseHeight;			 
			}

		} else {			
			document.getElementById(frm).style.height = "auto";
			contentHeight = document.getElementById(frm).contentWindow.document.body.scrollHeight;	
			document.getElementById(frm).style.height = contentHeight + 4 + "px";
		}
	}
</script>						
							<li <% if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && ( request.getRequestURI().indexOf("video_list.jsp") < 0) ) { out.print(" class='active' ");} %>>
							<a href="#"><span>최신영상</span></a>
								 <div><iframe title="최신영상" id="right_new_video" name="right_new_video" src="/2017/include/right_new_video_iframe.jsp" scrolling="no" width="100%" height="100%" marginwidth="0" frameborder="0" framespacing="0" allowfullscreen="true" webkitallowfullscreen="true" mozallowfullscreen="true" oallowfullscreen="true" msallowfullscreen="true"></iframe></div>
							</li>