<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="pageBean" class="com.vodcaster.utils.PageBean" scope="page"/>

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

	String ctype = "";
	String strTitle = "";
	int num = 1;

	if(request.getParameter("ctype") != null) {
		ctype = String.valueOf(request.getParameter("ctype").replaceAll("<","").replaceAll(">",""));
	}else
		ctype = "L"; // ����� �����
 

	String cate1 = request.getParameter("cate1").replaceAll("<","").replaceAll(">","");
	String cate2 = request.getParameter("cate2").replaceAll("<","").replaceAll(">","");
	String cate3 = request.getParameter("cate3").replaceAll("<","").replaceAll(">","");
	String ccode = "";
	String ocode = "";
	String user_id = "";
	

	if(request.getParameter("cate1")!=null && !request.getParameter("cate1").equals("") && !request.getParameter("cate1").equals("null")) {
        if(request.getParameter("cate2")!=null && !request.getParameter("cate2").equals("") && !request.getParameter("cate2").equals("null")) {
            if(request.getParameter("cate3")!=null && !request.getParameter("cate3").equals("") && !request.getParameter("cate3").equals("null")) {
                ccode = request.getParameter("cate3").trim();
            }else{
                ccode = request.getParameter("cate2").trim().substring(0,6);
            }
        }else{
            ccode = request.getParameter("cate1").substring(0,3);
        }
    }
    else{
		if(request.getParameter("ccode") != null) {ccode = request.getParameter("ccode").replaceAll("<","").replaceAll(">","");}
    	cate1 = "";
    	cate2 = "";
    	cate3 = "";
    }

    		
		    String rstime = "";

	        String retime = "";
	        String dept = "";
	        String grade = "";
	        if(request.getParameter("rstime") !=null && request.getParameter("rstime").length()>0)
	            rstime = request.getParameter("rstime").replaceAll("<","").replaceAll(">","");
	       
	        if(request.getParameter("retime") !=null && request.getParameter("retime").length()>0)
	            retime = request.getParameter("retime").replaceAll("<","").replaceAll(">","");

			if(request.getParameter("ocode") !=null && request.getParameter("ocode").length()>0)
				ocode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");
		    if(request.getParameter("user_id") !=null && request.getParameter("user_id").length()>0)
				user_id = request.getParameter("user_id").replaceAll("<","").replaceAll(">","");

		    if(request.getParameter("dept") !=null && request.getParameter("dept").length()>0)
		    	dept = request.getParameter("dept").replaceAll("<","").replaceAll(">","");
		    if(request.getParameter("grade") !=null && request.getParameter("grade").length()>0)
		    	grade = request.getParameter("grade").replaceAll("<","").replaceAll(">","");
	
	
	        
	        
	String strtmp = "";


	MediaManager mgr = MediaManager.getInstance();
	Vector vt =  null;
	if (request.getParameter("search_true")!= null &&  request.getParameter("search_true").equals("Y")){
		//vt = mgr.getOVODMemberList3( rstime, retime, ocode, user_id, ccode, ctype);
		vt = mgr.getOVODMemberList3_group( rstime, retime, ocode, user_id, ccode, ctype, dept, grade);
		
	}


	/******************************************************************************
	PAGEBEAN ����
	******************************************************************************/
	int totalArticle =0; //�� ���ڵ� ����
	int todayArticle = 0 ; //���� ��� ���ڵ� ��
	int pg = 0;
    String cpage = request.getParameter("page");

    if(cpage == null || cpage.equals("")) {
        pg = 1;
    }else {
        try{
			pg = Integer.parseInt(cpage);
		}catch(Exception e){
			pg = 0;
		}
    }

	String jspName = "";

	if(vt != null && vt.size() >0){
		totalArticle= vt.size(); // �� �Խù� ��

		jspName="mng_view_stat_mobileL.jsp";

		try{
			pageBean.setTotalRecord(totalArticle);
			pageBean.setLinePerPage(Integer.parseInt("20"));
			pageBean.setPagePerBlock(10);
			pageBean.setPage(pg);
		}catch(Exception e){
			System.out.println("PAGEEXCEPTION = "+e);

		}
	}

    String strLink = "dept="+dept+"&grade="+grade+"&rstime=" +rstime+ "&retime=" +retime+ "&ctype="+ctype+"&ocode="+ocode+"&user_id="+user_id+"&ccode="+ccode+"&search_true=Y";
%>

<%@ include file="/vodman/include/top.jsp"%>
<script language="javascript">
<!--

function search() {
    document.frmMedia.action = "mng_view_stat_mobileL.jsp";
	document.frmMedia.target="";
    document.frmMedia.submit();
}


//////////////////////////////////////////////////////
//�޷� open window event 
//////////////////////////////////////////////////////

var calendar=null;

/*��¥ hidden Type ���*/
var dateField;

/*��¥ text Type ���*/
var dateField2;

function openCalendarWindow(elem) 
{
	dateField = elem;
	dateField2 = elem;

	if (!calendar) {
		calendar = window.open('/vodman/include/calendar/calendar.html','cal','WIDTH=200,HEIGHT=250,scrollbars=no,resizable=no');
	} else if (!calendar.closed) {
		calendar.focus();
	} else {
		calendar = window.open('/vodman/include/calendar/calendar.html','cal','WIDTH=200,HEIGHT=250,scrollbars=no,resizable=no');
	}
}


function go_vlist(){

	document.frmMedia.action="./frame_vlist.jsp";
	document.frmMedia.target="vlist";
	document.frmMedia.submit();
}

//-->
</script>

<%@ include file="/vodman/site/site_left.jsp"%>

		<div id="contents">
			<h3><span>��û�α�</span> ����</h3>
			<p class="location">������������ &gt; ����Ʈ���� &gt; <span>��û�α� ����</span></p>
			<div id="content">
				<!-- ���� -->
				<div id="tab01">
 
					<ul class="s_tab01_bg">
					<li ><a href="mng_view_stat.jsp?mcode=<%=mcode%>" title="VOD">VOD</a></li>
					<li ><a href="mng_view_stat_live.jsp?mcode=<%=mcode%>" title="LIVE">LIVE</a></li>
					<li ><a href="mng_view_stat_mobile.jsp?mcode=<%=mcode%>" title="Mobile-VOD" >Mobile-VOD</a></li>
					<li ><a href="mng_view_stat_mobileL.jsp?mcode=<%=mcode%>" title="Mobile-LIVE"  class='visible'>Mobile-LIVE</a></li>
					</ul>

				</div>
				<form name="frmMedia" method="post">
					<input type="hidden" name="mcode" value="<%=mcode%>">
					<input type="hidden" name="ocode" value="">
					<input type="hidden" name="cate2" value="">
					<input type="hidden" name="cate3" value="">
					<input type="hidden" name="search_true" value="Y">
					<input type="hidden" name="dept" value="<%=dept%>">
					<input type="hidden" name="grade" value="<%=grade%>">
				<table cellspacing="0" class="log_list" summary="��û�α� ����">
				<caption>��û�α� ����</caption>
				<colgroup>
					<col width="15%" class="back_f7"/>
					<col/>
					<col width="15%" class="back_f7"/>
					<col/>
				</colgroup>
				<tbody>
					<tr>
						<th class="bor_bottom01"><strong>�������</strong></th>
						<td class="bor_bottom01 pa_left">
							<iframe name="vlist" src="./frame_vlive.jsp?ctype=<%=ctype%>" scrolling="no" width="300" height="21" marginwidth="0" frameborder="0" framespacing="0" ></iframe>
						</td>
						<th class="bor_bottom01"><strong>ȸ��ID</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="user_id" value="" class="input01" style="width:150px;"/></td>
					</tr>
<!-- 
					<tr>
						<th class="bor_bottom01"><strong>�μ�</strong></th>
						<td class="bor_bottom01 pa_left">
							<iframe name="vlist" src="./frame_Dept.jsp" scrolling="no" width="200" height="21" marginwidth="0" frameborder="0" framespacing="0" ></iframe>
						</td>
						<th class="bor_bottom01"><strong>����</strong></th>
						<td class="bor_bottom01 pa_left">
							<iframe name="vlist" src="./frame_Grade.jsp" scrolling="no" width="200" height="21" marginwidth="0" frameborder="0" framespacing="0" ></iframe>
						</td>
					</tr>
 -->
					<tr>
						<th class="bor_bottom01"><strong>�Ⱓ</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<input type="text" name="rstime" value="" class="input01" style="width:80px;" onkeypress="onlyNumber();" />
						<a href="javascript:openCalendarWindow(document.frmMedia.rstime)" title="ã�ƺ���"><img src="/vodman/include/images/but_seek.gif" alt="ã�ƺ���"/></a>&nbsp;~&nbsp;
						<input type="text" name="retime" value="" class="input01" style="width:80px;" onkeypress="onlyNumber();" />
						<a href="javascript:openCalendarWindow(document.frmMedia.retime)" title="ã�ƺ���"><img src="/vodman/include/images/but_seek.gif" alt="ã�ƺ���"/></a>
						</td>
					</tr>
				</tbody>
				</table>
				</form>
				<div class="but01">
					<a href="javascript:search();" title="�˻�"><img src="/vodman/include/images/but_search2.gif" alt="�˻�"/></a>
				</div>
				<br/><br/>
				<div class="to_but">
					<p class="to_page">Total<b><%if(vt!=null && vt.size()>0){out.println(vt.size());}else{out.println("0");}%></b>
					Page<b><%if (vt != null && vt.size() > 0) {out.println(pg);} else {out.println("0");}%>/<%if (vt != null && vt.size() > 0) {out.println(pageBean.getTotalPage());} else {out.println("0");}%></b></p>
					<p class="align_right02 height_25"><a href="mng_view_stat_live_excel.jsp?<%=strLink%>" title="�����ޱ�"><img src="/vodman/include/images/but_excel.gif" alt="�����ޱ�"/></a></p>
				</div>
				<table cellspacing="0" class="board_list" summary="����� ��û�α�">
				<caption>����� ��û�α�</caption>
				<colgroup>
					<col width="6%"/>
					<col width="12%"/>
					<col/>
					<col width="10%"/>
					<col width="15%"/>
				</colgroup>
				<thead>
					<tr>
						<th>��ȣ</th>
						<th>���̵�</th>
						<th>��������</th>
						<th>��û��</th>
						<th>������</th>
					</tr>
				</thead>
				<tbody>
<%
	String sub_link = "";

	if(vt != null && vt.size() > 0){

		String list_id = "";
		String list_name = "";
		String list_date = "";
		String list_time = "";
		String list_ip = "";
		String list_title = "";

		try{
			for(int i = pageBean.getStartRecord()-1; i < pageBean.getEndRecord(); i++) {
			
				list_ip = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(1));
				list_id = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(2));
				list_name = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(3));
				list_date  = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(5));
				list_title = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(6));
%>
					<tr class="height_25 font_127">
						<td class="bor_bottom01"><%=pageBean.getTotalRecord()-i%></td>
						<td class="bor_bottom01"><%=list_name%>(<%=list_id%>)</td>
						<td class="align_left bor_bottom01"><%=list_title%></td>
						<td class="bor_bottom01"><%=list_date.substring(0,10)%></td>
						<td class="bor_bottom01"><%=list_ip%></td>
					</tr>
<%
			}
		}catch(Exception e) {}
	}
%>
				</tbody>
			</table>
			<% strLink = strLink + "&mcode="+mcode;%>
			<%@ include file="pop_page_link.jsp" %>
			<br/><br/>
			</div>
			<!-- ���� �� -->
		</div>	
		<!-- ������ �� -->
<%@ include file="/vodman/include/footer.jsp"%>