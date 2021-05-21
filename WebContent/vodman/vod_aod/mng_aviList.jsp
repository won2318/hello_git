<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="java.io.*" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
	//request.setCharacterEncoding("euc-kr");

if(!chk_auth(vod_id, vod_level, "v_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author hrlee
	 *
	 * @description : 운본 파일 목록 제공  / 다운로드 / 링크 제공
	 * date : 2010-10-11
	 */

	 
	String source_file_path = com.vodcaster.sqlbean.DirectoryNameManager.UPLOAD_MEDIA+"/avi";
	String rwork = request.getParameter("work").replaceAll("<","").replaceAll(">","");
	String rename_source = request.getParameter("rename_source").replaceAll("<","").replaceAll(">","");
	String rename_target = request.getParameter("rename_target").replaceAll("<","").replaceAll(">","");
	if(rwork != null && rwork.length()>0 && !rwork.equals("null") && rwork.equals("rename"))
	{
		//해당 파일 이름을 변경한다.
		File file_name =null;//원래 파일이름
		File file_rename =null;//바꾼 파일이름
		try{
			
			if(rename_source != null && rename_source.length()>0 && !rename_source.equals("null")
				&& rename_target != null && rename_target.length()>0 && !rename_target.equals("null")){
				file_name = new File(source_file_path+"/"+rename_source);
				file_rename = new File(source_file_path+"/"+rename_target);

				if(file_name.renameTo(file_rename)){
					
				}
			}
		}catch(Exception ex)
		{
			out.println("오류가 발생 하였습니다. 관리자에게 문의 주세요");
		}

	}
	File[] channel_arra = null;
	String[] channel_list = null;
	File f_file_path = new File(source_file_path);
	int list_cnt = 0;
	
	if(f_file_path.isDirectory()){
		
	}else{
		// 서버 경로가 올바르지 않습니다.
		out.println(" 서버 경로가 올바르지 않습니다.");
	}
			
	
	
	
	
%>
<script language='javascript'>
function fileDown(path){
		document.chkPath.chkPath.value=path;
		document.chkPath.action="filechk.jsp"
		document.chkPath.submit();
	}
function avi_player(name){
	var url = "avi_player.jsp?name_source="+name;
		window.open(url,"aviplayer","width=520,height=430");
	}	
function renameChk(name,work,idx){
		document.frmMedia.rename_source.value=name;
		document.frmMedia.rename_target.value=document.getElementById(idx).value;
		if(document.frmMedia.rename_target.value == ""){
		}else{
			document.frmMedia.work.value=work;
			document.frmMedia.action="mng_aviList.jsp"
			document.frmMedia.submit();
		}
	}	
</SCRIPT>
	
<%@ include file="/vodman/include/top.jsp"%>

<%@ include file="/vodman/vod_aod/avi_left.jsp"%>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>원본영상</span> 목록</h3>
			<p class="location">관리자페이지 &gt; 원본영상관리 &gt; <span>원본영상목록</span></p>
			<div id="content">
				<!-- 내용 -->
				<form name='frmMedia' method='post' action="mng_aviList.jsp" >
				<input type="hidden" name="mcode" value="<%=mcode%>" />  
				<input type="hidden" name="work" value="list" /> 
				<input type="hidden" name="rename_source" value="" /> 
				<input type="hidden" name="rename_target" value="" />				
				
				<table cellspacing="0" class="board_view" summary="원본영상목록">
				<caption>추천VOD</caption>
				<colgroup>
					<col width="15%"/>
					<col/>
				</colgroup>
				<tbody class="bor_top03">
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>디렉토리</strong></th>
						<td class="bor_bottom01 pa_left"><%=source_file_path%></td>
					</tr>
					<%
					channel_arra = f_file_path.listFiles();
					if(channel_arra != null){
						channel_list = new String[channel_arra.length];
						for(int i=0;i<channel_arra.length;i++){
							String name_file_dir = "";
							boolean bIsDir = false;
							if(channel_arra[i].isDirectory()){
								channel_list [list_cnt++] =channel_arra[i].getName(); 
								name_file_dir = channel_arra[i].getName();
								bIsDir = true;
							}else{
								//파일 리스트 얻기 
								name_file_dir = channel_arra[i].getName();
							}

							if(!bIsDir && channel_arra[i].getName().endsWith(".avi")){
					%>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>&nbsp;</strong></th>
						<td class="bor_bottom01 pa_left"><a href="javascript:avi_player('<%=name_file_dir%>')" title="<%=name_file_dir%>" ><%=name_file_dir%></a>
						&nbsp;&nbsp;&nbsp;
						<a href="javascript:fileDown('<%=name_file_dir%>')" title="<%=name_file_dir%> file download">[download]</a>
						&nbsp;&nbsp;&nbsp;
						<input type="text" name="targetName<%=i%>" id="targetName<%=i%>" maxlength="40" value="" class="input01" style="width:200px;"/><a href="javascript:renameChk('<%=name_file_dir%>','rename','targetName<%=i%>')" title="<%=name_file_dir%> rename">rename</a>
						</td>
					</tr>
					<%
							}
						}
						
					}
					
					%>
					<tr>
						<td colspan="2" class="height_25"></td>
					</tr>
				</tbody>
			</table>
			</form>
			</div>
		</div>
<form name="chkPath" method="post" >
	<input type="hidden" name = "chkPath" value="" >
</form>
									  
<%@ include file="/vodman/include/footer.jsp"%>	