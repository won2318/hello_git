<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "m_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}

%>
<%
	/**
	 * @author lee hee rak
	 *
	 * @description : �弳	 ���� �Է�.
	 * date : 2012-5-4
	 */

%>
<%@ include file="/vodman/include/top.jsp"%>


<script language="javascript">
<!--
	function chkForm(form) {



		if(form.fucks.value == "") {
			alert("�弳 �ؽ�Ʈ�� �Է����ּ���.");
			form.fucks.focus();
			return;
		}
		
		if(confirm("�����Ͻðڽ��ϱ�?")) {
			form.submit();
		}
	}

	
//-->
</script>

<%@ include file="/vodman/site/site_left.jsp"%>

		<!-- ������ -->
		<div id="contents">
			<h3><span>�弳</span> ����</h3>
			<p class="location">������������ &gt; ����Ʈ���� &gt; <span>�弳 ����</span></p>
			<div id="content">
			 <form name='frmMe' method='post' action="proc_fuck_Add.jsp" >
			 <input type="hidden" name="mcode" value="<%=mcode%>" />
				<table cellspacing="0" class="board_view" summary="�弳 ����">
				<caption>�弳 ����</caption>
				<colgroup>
					<col width="17%" class="back_f7"/>
					<col/>
				</colgroup>
				<tbody class="bor_top03">
					<tr>
						<th class="bor_bottom01"><strong>�弳</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="fucks" value="" class="input01" style="width:150px;" maxlength="20" /> (20�ڸ�)</td>
					</tr>
				</tbody>
				</table>
				
				<div class="but01">
					<a href="javascript:chkForm(document.frmMe);" title="����"><img src="/vodman/include/images/but_save.gif" alt="����"/></a>
					<a href="mng_fuckList.jsp?mcode=<%=mcode%>" title="���"><img src="/vodman/include/images/but_cancel.gif" alt="���"/></a>
				</div>	
				
				<br/><br/>
				</form>
			</div>
		</div>	
<%@ include file="/vodman/include/footer.jsp"%>