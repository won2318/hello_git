  <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %> 
<%@ page import="com.yundara.util.*"%>

<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" /> 
 
 <%@ include file = "/include/chkLogin.jsp"%>
 <%



// java.util.Date day = new java.util.Date();
// SimpleDateFormat today_sdf = new SimpleDateFormat("yyyyMMdd");
// String today_string = today_sdf.format(day);

// long lCurTime = day.getTime();
// day = new java.util.Date(lCurTime+(1000*60*60*24*-1));
// String sYesterDay  = today_sdf.format(day);  

MediaManager mgr = MediaManager.getInstance(); 
String ccode ="";
if (request.getParameter("ccode") != null && request.getParameter("ccode").length() > 0  && !request.getParameter("ccode").equals("null")) {
	ccode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ccode"));
}

int board_id = NumberUtils.toInt(request.getParameter("board_id"), 0);

String ocode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ocode"));
if(ocode == null || ocode.length() <= 0 || ocode.equals("null")){
ocode = "";
} else {
	Vector vo = null;
	vo = mgr.getOMediaInfo_cate(ocode);	
	if (vo != null && vo.size() > 0) {
		try {
			Enumeration e2 = vo.elements();
			com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable) e2.nextElement());
			ccode = oinfo.getCcode(); 
		} catch (Exception e2) {
			System.err.println(e2.getMessage());
			 
		}
	}
}



%>
    <%@ include file = "../include/html_head.jsp"%>       

<script language="JavaScript" type="text/JavaScript">
<!-- 
	
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

function go_VideoView(ccode, ocode) {
	parent.document.getElementById("video_player").src = "video_player.jsp?ccode="+ccode+"&ocode="+ocode;
}

//-->
</script>
<noscript>
죄송합니다! 스크립트를 지원하지 않는 브라우져 입니다! <br/> 
일부 프로그램이 원활하게 작동 하지 않을수 있습니다!<br/> 
 </noscript>
 	
		<section id="body">
			<div id="container_out">
				<div id="container_inner">
					 <iframe title="동영상 재생 창" id="video_player" name="video_player" src="video_player.jsp?ccode=<%=ccode%>&ocode=<%=ocode%>&type=sub" scrolling="no" width="100%" height="100%" marginwidth="0" frameborder="0" framespacing="0" allowfullscreen="true" webkitallowfullscreen="true" mozallowfullscreen="true" oallowfullscreen="true" msallowfullscreen="true" onload="resizeFrame('video_player')"></iframe>
					<!--//vodView-->
				
				</div><!--//container_inner-->
				<aside class="container_right">
					<div class="NewTab list5 list3">
						<ul>
							<li class="active"><a href="#"><span>카테고리영상</span></a>
								<div><iframe title="동영상 목록" id="vod_cate_list" name="vod_cate_list" src="vod_cate_list.jsp?ccode=<%=ccode%>" scrolling="no" width="100%" height="100%" marginwidth="0" frameborder="0" framespacing="0" allowfullscreen="true" webkitallowfullscreen="true" mozallowfullscreen="true" oallowfullscreen="true" msallowfullscreen="true" onload="resizeFrame('vod_cate_list')"></iframe>
								</div>
							</li> 
							
							<%@ include file = "../include/right_new_video.jsp"%>   
							
						</ul>
					</div><!--//NewTab list3-->
 
					<%@ include file = "../include/right_best_video.jsp"%>   
				</aside><!--//container_right-->
			</div><!--//container_out-->
		</section><!--콘텐츠부분:section-->    
		
	<%@ include file = "../include/html_foot.jsp"%>    