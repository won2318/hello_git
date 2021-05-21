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
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author hrlee
	 *
	 * @description : � ���� ��� ����  / �ٿ�ε� / ��ũ ����
	 * date : 2010-10-11
	 */

	 
	String source_file_path = com.vodcaster.sqlbean.DirectoryNameManager.UPLOAD_MEDIA+"/avi";
	String rwork = request.getParameter("work").replaceAll("<","").replaceAll(">","");
	String rename_source = request.getParameter("rename_source").replaceAll("<","").replaceAll(">","");
	String rename_target = request.getParameter("rename_target").replaceAll("<","").replaceAll(">","");
	if(rwork != null && rwork.length()>0 && !rwork.equals("null") && rwork.equals("rename"))
	{
		//�ش� ���� �̸��� �����Ѵ�.
		File file_name =null;//���� �����̸�
		File file_rename =null;//�ٲ� �����̸�
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
			out.println("������ �߻� �Ͽ����ϴ�. �����ڿ��� ���� �ּ���");
		}

	}
	File[] channel_arra = null;
	String[] channel_list = null;
	File f_file_path = new File(source_file_path);
	int list_cnt = 0;
	
	if(f_file_path.isDirectory()){
		
	}else{
		// ���� ��ΰ� �ùٸ��� �ʽ��ϴ�.
		out.println(" ���� ��ΰ� �ùٸ��� �ʽ��ϴ�.");
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
		<!-- ������ -->
		<div id="contents">
			<h3><span>��������</span> ���</h3>
			<p class="location">������������ &gt; ����������� &gt; <span>����������</span></p>
			<div id="content">
				<!-- ���� -->
				<form name='frmMedia' method='post' action="mng_aviList.jsp" >
				<input type="hidden" name="mcode" value="<%=mcode%>" />  
				<input type="hidden" name="work" value="list" /> 
				<input type="hidden" name="rename_source" value="" /> 
				<input type="hidden" name="rename_target" value="" />				
				
				<table cellspacing="0" class="board_view" summary="����������">
				<caption>��õVOD</caption>
				<colgroup>
					<col width="15%"/>
					<col/>
				</colgroup>
				<tbody class="bor_top03">
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>���丮</strong></th>
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
								//���� ����Ʈ ��� 
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