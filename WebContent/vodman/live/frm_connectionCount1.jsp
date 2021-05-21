<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,com.security.SEEDUtil"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.yundara.util.CharacterSet" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
<%
if(!chk_auth(vod_id, vod_level, "b_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}


%>

<%
	String paramOcode = request.getParameter("ocode");
	paramOcode = StringUtils.defaultString(request.getParameter("ocode"),"");
	String flag = request.getParameter("flag");
	if (flag == null || flag.length()<=0 || flag.equals("null")) {
		flag = "B";
	}
	 
	LiveManager lMgr = LiveManager.getInstance();
	String play_btn = "";
	String live_popup = "";
	Vector v_onair = null;

	String channel = "";
	String stream = "";
	String live_title ="";
	String live_rcontents ="";
	String temp_server_name = DirectoryNameManager.SV_LIVE_SERVER_IP;
	String rcode ="";
	try {
		// rcode, rtitle, rcontents, rbcst_time, ralias, 
		// rstart_time, rend_time, rflag, rstatus, rwdate, 
		// rhit, rlevel,rfilename, rid, rimagefile,
		// property_id, openflag,group_id, del_flag, ocode, 
		// otitle, mobile_sream, inoutflag, org_rfilename 
		v_onair =  lMgr.getLive();
		if(v_onair != null && v_onair.size() > 0) 
		{  
			rcode =  String.valueOf(v_onair.elementAt(0));

			live_title = String.valueOf(v_onair.elementAt(1)); 
			live_rcontents  = String.valueOf(v_onair.elementAt(2)); 
			String[] data= null;

			data=String.valueOf(v_onair.elementAt(4)).split("/");

			if(data.length > 2){
				channel = data[1];
				stream = data[2];
				if (stream.startsWith("suwon01r") ) {
					temp_server_name = "livetv.suwon.go.kr"; 
				}

			}
		}
 
 	}catch(Exception e) {}
	

	




	
%>

<%@ include file="/vodman/include/top.jsp"%>

<%@ include file="/vodman/live/live_left.jsp"%>
<script src=../include/js/script.js></script>

<script type="text/javascript" src="../../2013/include/js/AC_RunActiveContent.js"></script>
<script language='javascript'>
	function searchI(){
		if (listForm.searchstring.value == ''){
			 alert("검색어를 입력하세요");
			 return;
		}
		else{
			listForm.action='mng_boardListComment.jsp';
			listForm.submit();
		}
		return
	}

	

</script>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>생방송 모니터링</span></h3>
			<p class="location">관리자페이지 &gt; 생방송관리 &gt; 생방송 정보 &gt; <span>생방송 모니터링</span></p>
			<form name="listForm" method="post">
			<input type="hidden" name="mcode" value="<%=mcode%>">
			
			<div id="content">
				<!-- 내용 -->
				
				<table cellspacing="0" class="border_search" summary="게시판 검색">
				<caption>게시판 검색</caption>
				<colgroup>
					<col width="50%"/>
					<col/>
				</colgroup>
				<tbody class="bor_top03">
					<tr class="height_25">
						<td colspan="2" align="left" >
						<strong> 커넥션 카운트 <iframe src="http://<%=DirectoryNameManager.SV_LIVE_SERVER_IP %>:8086/connectioninfo/index.html?application=live" name="live" width="300" height="35" scrolling="no" frameborder="0"/></iframe></td>
					</tr>
					
					
					<tr class="height_25">
						<td colspan="2" >
					<%
					int iViewerHeight = 468;
int iViewerWidth = 760;
					%>

					
						
						<script language="javascript">
					if (AC_FL_RunContent == 0) {
						alert("This page requires AC_RunActiveContent.js.");
					} else {
						AC_FL_RunContent(
							'codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0',
							'width', '<%=iViewerWidth%>',
							'height', '<%=iViewerHeight%>',
							'src', 'live_wide',
							'quality', 'high',
							'pluginspage', 'http://www.macromedia.com/go/getflashplayer',
							'align', 'middle',
							'play', 'true',
							'loop', 'true',
							'scale', 'showall',
							'wmode', 'window',
							'devicefont', 'false',
							'id', 'live',
							'bgcolor', '#FFFFFF',
							'name', 'live_wide',
							'menu', 'true',
							'allowFullScreen', 'true',
							'allowScriptAccess','sameDomain',
							'movie', '/2013/live/live_wide',
							'FlashVars', 'userName=rtmp://<%=temp_server_name%>/<%=channel%>&userId=<%=stream%>',
							'salign', ''
							); //end AC code
						
					}
				</script>
				
				<noscript>
					<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="<%=iViewerWidth%>px" height="<%=iViewerHeight%>px" id="live" align="middle">
					<param name="allowScriptAccess" value="sameDomain" />
					<param name="allowFullScreen" value="true" />
					<param name="movie" value="/2013/live/live_wide.swf" />
					<param name="quality" value="high" />
					<param name=" s" value="choice=1&app=live.stream" />
					<param name="bgcolor" value="#000000" />
					
					<embed src="/2013/live/live_wideswf" quality="high" bgcolor="#000000" width="<%=iViewerWidth%>px" height="<%=iViewerHeight%>px" name="live_wide" align="middle" 
						allowScriptAccess="sameDomain" allowFullScreen="true" type="application/x-shockwave-flash" 
						FlashVars="choice=1&app=live.stream" 
						pluginspage="http://www.macromedia.com/go/getflashplayer" />
					
					</object>		
				</noscript>
						
						</td>
					</tr>
					
					<tr>
						<td colspan="2" class="height_25"></td>
					</tr>
				</tbody>
				</table>
						
				
				<br/><br/>
			</div>
		</div>	
	 </form>


			<%@ include file="/vodman/include/footer.jsp"%>