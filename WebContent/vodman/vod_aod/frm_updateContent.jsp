<%--
date   : 2007-07-04
�ۼ��� : ����
����   : vod ���  

	openflag - ����, �����
	user_id, user_pwd - ����� ���̵�, ��� ��й�ȣ

--%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@page import="com.security.SEEDUtil"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
	if(!chk_auth(vod_id, vod_level, "v_write")) {
	    out.println("<script language='javascript'>\n" +
	                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
	                "history.go(-1);\n" +
	                "</script>");
	    return;
	} 

%>
<%
	/**
	 * @author �����
	 *
	 * description : �ֹ��� VOD ���� ���
	 * date : 2007-09-05
	 */

	String mtitle = "VOD";
	String ctype = "V";
 
	String ccode = "";
	String ocode = "";
//	 VOD�� �ʱ�ȭ
	if(request.getParameter("ctype") != null)
	{
		ctype = request.getParameter("ctype").replaceAll("<","").replaceAll(">","");
		if (ctype.equals("A")) 
		mtitle = "AOD";
	}


	if(request.getParameter("ocode") == null || request.getParameter("ocode").length()<=0 || request.getParameter("ocode").equals("null")) {
		out.println("<script lanauage='javascript'>alert('�̵���ڵ尡 �����ϴ�. �ٽ� �������ּ���.'); history.go(-1); </script>");
		return;
	} else
		ocode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");

	if(request.getParameter("ccode") == null || request.getParameter("ccode").length()<=0 || request.getParameter("ccode").equals("null")) {
		out.println("<script lanauage='javascript'>alert('�̵���ڵ尡 �����ϴ�. �ٽ� �������ּ���.'); history.go(-1); </script>");
		return;
	} else
		ccode = request.getParameter("ccode").replaceAll("<","").replaceAll(">","");

	String pg = request.getParameter("page").replaceAll("<","").replaceAll(">","");
	
	com.hrlee.sqlbean.MediaManager mgr = com.hrlee.sqlbean.MediaManager.getInstance();
	Vector vt = mgr.getOMediaInfo(ocode);			// �ֹ����̵�� ��������
	com.hrlee.silver.OrderMediaInfoBean info = new com.hrlee.silver.OrderMediaInfoBean();
	MediaNewsManager mnm = MediaNewsManager.getInstance();
	Vector news = null;
	MediaNewsInfoBean newsInfoBean = new com.hrlee.sqlbean.MediaNewsInfoBean();
	if(vt != null && vt.size()>0){
		try {
			Enumeration e = vt.elements();
			com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
			news = mnm.getNews_ListAll(ocode);
			
 		} catch (Exception e) {
			out.println("<script lanauage='javascript'>alert('������ ���� ��ȸ�� �����Ͽ����ϴ�. ���� �������� �̵��մϴ�.'); history.go(-1); </script>");
			return;
		}
	}else{
		out.println("<script lanauage='javascript'>alert('������ ���� ��ȸ�� �����Ͽ����ϴ�. ���� �������� �̵��մϴ�.'); history.go(-1); </script>");
		return;
	}
	
	CategoryManager cmgr = CategoryManager.getInstance();
	Vector cate_x = cmgr.getCategoryListALL2("X","A");
	 
%>
<%@ include file="/vodman/include/top.jsp"%>
<script type="text/javascript" src="/vodman/include/js/script.js"></script>
<script type="text/javascript" src="/vodman/include/js/viewer.js"></script>
<script type="text/javascript" src="/vodman/editer_2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/vodman/include/js/ajax_category_select2.js"></script>
<script type="text/javascript" src="/vodman/include/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/vodman/include/js/jquery.leanModal.min.js"></script> <!-- ���θ޴���� -->
<script type="text/javascript">
// ��з� ī�װ� �ҷ����� (ajax_category_select.js)
		window.onload = function() {
			refreshCategoryList_A('V', '', 'A', '<%=ccode%>');
			refreshCategoryList_B('V', '', 'B', '<%=ccode%>');
			refreshCategoryList_C('V', '', 'C', '<%=ccode%>');
<%-- 			refreshCategoryList_D('V', '', 'D', '<%=ccode%>'); --%>
			
			refreshCategoryList_AV('Y', '', 'A', '<%=info.getYcode()%>');
			refreshCategoryList_BV('Y', '', 'B', '<%=info.getYcode()%>');
			 
		} 
		function setCcode(form, val) {
			form.ccode.value = val;
		}
		function setCcodeY(form, val) {
			form.ycode.value = val;
		}
 
		function start_insert(){

			var f = document.frmMedia;
	      
			//if (f.ownerid.value=="") {
			//  alert ("�ۼ��ڰ� �����ϴ�.")
			//   f.ownerid.focus();
			//   return
			//}
			 
			if (f.title.value=="") {
			   alert ("������ �Է����� �����̽��ϴ�.")
			   f.title.focus();
			   return
			}

  
			//oEditors.getById["description"].exec("UPDATE_IR_FIELD", []);
			oEditors[0].exec("UPDATE_CONTENTS_FIELD", []);
			// �������� ���뿡 ���� �� ������ �̰����� document.getElementById("list_contents").value�� �̿��ؼ� ó���ϸ� �˴ϴ�.
			 
			if (f.description.value=="") {
			   alert ("������ �Է����� �����̽��ϴ�.")
			  // f.description.focus();
			   return
			} 
 
			f.action="proc_update_ucc.jsp?mcode=<%=mcode%>&ccode=<%=ccode%>&page=<%=pg%>";
			f.submit();
			

		}
			function CheckText(str) {
				strarr = new Array(str.value.length);
				schar = new Array("'");

				for (i=0; i<str.value.length; i++)
				{
					for (j=0; j<schar.length; j++)
					{
						if (schar[j] ==str.value.charAt(i))
						{
							alert("(')Ư�����ڴ� �Ұ����մϴ�");
							str.focus();
							return false;
						}
						else
							continue;
					}

				}
				return true;
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


	function limitFile(flag)
	 {
		 var file = document.frmMedia.attach_file.value;
		 
		  extArray = new Array(".jsp", ".cgi", ".php", ".asp", ".aspx", ".exe", ".com", ".js", ".pl", ".php3",".html",".htm");
		  allowSubmit = false;

		  while (file.indexOf("\\") != -1) {
		   file = file.slice(file.indexOf("\\") + 1);
		   ext = file.slice(file.indexOf(".")).toLowerCase();

			   for (var i = 0; i < extArray.length; i++) {
					if (extArray[i] == ext) { 
					 allowSubmit = true; 
					 break; 
					}
			   }
		  }

		  if (allowSubmit){
		  
		   alert("�Է��Ͻ� ������ ���ε� �� �� �����ϴ�!");
			document.frmMedia.attach_file.outerHTML = document.frmMedia.attach_file.outerHTML;
		   return;
		  }
	 }



    function f_newChange(){
        var pcd = document.frmMedia.ccategory1.value;
            document.all.newCdFrame.src = "./codeValue.jsp?ctype=<%=ctype%>&category="+pcd;
            document.all.newCdFrame2.src = "./codeValue2.jsp?ctype=<%=ctype%>&category2="+pcd;
			document.all.ccode.value= pcd;
    }

	function go_main_img(val){
    	document.frmMedia.modelimage.value=val;
    	position_xy.src="pop_img_position.jsp?ocode=<%=ocode %>&mcode=<%=mcode %>&value="+val;
  
    }

		function memo_comment(ocode) {
		window.open("/vodman/comment/comment.jsp?ocode="+ocode+"&flag=M","admin_commnet","width=540,height=250,scrolling=none");
	}
</script>


 
 <style type="text/css">
        .main_img { width: 95px; height: 70px; text-align: center; border:1px solid silver;
        background: url(/vodman/include/images/no_image.gif) repeat-x bottom;
        }
</style>
<%@ include file="/vodman/vod_aod/vod_left.jsp"%>
		<div id="contents">
			<h3><%= CategoryManager.getInstance().getCategoryName(ccode, "V")%></h3>
			<!--<p class="location">������������ &gt; ������ ���� &gt; <span><%=mtitle%> ���</span></p>-->
			<div id="content">
		 
			<p class="title_dot01">������ ���� �Է� <span class="font_11r"> (*) �ʼ� �Է��׸� �Դϴ�.</span></p>
			<form name='frmMedia' method='post' enctype="multipart/form-data" >
				<input type="hidden" id="ocode" name="ocode" value="<%=ocode%>"/>
				<input type="hidden" name="olevel" value="<%=info.getOlevel()%>">
				<input type="hidden" name="playtime" id="playtime" value="<%=info.getPlaytime() %>" />
				<input type="hidden" name="filename" id="filename" value="<%=info.getFilename() %>" />
				<input type="hidden" name="modelimage" id="modelimage" value="<%=info.getModelimage() %>" />
				<input type="hidden" name="encodedfilename" id="encodedfilename" value="<%=info.getEncodedfilename() %>" />
				<input type="hidden" name="subfolder" id="subfolder" value="<%=info.getSubfolder() %>" />
				<input type="hidden" id="ccode" name="ccode" value="<%=ccode%>"/>
				<input type="hidden" name="mobilefilename" id="mobilefilename" value="<%=info.getMobilefilename() %>" />
				<input type="hidden" id="old_attach_file" name="old_attach_file" value="<%=info.getAttach_file()%>"/>
				 
				<input type="hidden" id="mcode" name="mcode" value="<%=mcode%>"/>
				<input type="hidden" id="ycode" name="ycode" value="<%=info.getYcode()%>"/>
				 
				<table cellspacing="0" class="board_view" summary="<%=mtitle%> ���">
				<caption><%=mtitle%> ���</caption>
				<colgroup>
					<col width="20%" class="back_f7"/>
					<col width="35%"/>
					<col width="20%" class="back_f7"/>
					<col width="25%"/>
				</colgroup>
				<tbody> 
		 		
				   <tr>
						<td class="bor_bottom01 right_border" colspan="4" align="center" >
								
							<div id="media_player">
							<div id='errorLocation' style="font-size: small;color: Gray;"></div>
							<%
							if(info.getIsended() == 1){
							%>
							<div>
						 
<%--  							<iframe id="bestVod" name="bestVod" src="/silverPlayer_thumbnail.jsp?ocode=<%=ocode%>" scrolling='no' width="750" height="550" marginwidth='0' frameborder='0' framespacing='0' ></iframe>  --%>
								<iframe id="bestVod" name="bestVod" src="/videoJs_2019/vodmanjsPlayer.jsp?ocode=<%=ocode%>&type=vodman" scrolling='no' width="690" height="388" marginwidth='0' frameborder='0' framespacing='0' allowfullscreen="true" webkitallowfullscreen="true" mozallowfullscreen="true" oallowfullscreen="true" msallowfullscreen="true"></iframe>

							</div>
							<%}%>
							</div>
							<div id="img_panel"></div>
						</td>
					</tr>
 					
					 	<tr class="height_25">
						<th class="bor_bottom01"><strong>��ǥ�̹���</strong>
<!-- 						<br> -->
<!-- 20190304						<a href="#img_position" class="flatbtn">�̹��� ��ġ ����</a> -->
						</th>
						<td class="bor_bottom01 pa_left" colspan="3">
							<table class="thumnailList" cellspacing="0" summary="����ϼ���">
							<tbody>
							<tr>
								<%
                                     
								Vector img_vector = mgr.getMediaImages(ocode); 
                                 for (int i=0; i < img_vector.size(); i++) {
                                	  String img_time = String.valueOf(((Vector)img_vector.elementAt(i)).elementAt(3));  // �ð�
                                      String img_url = DirectoryNameManager.SILVERLIGHT_SERVERNAME+"/ClientBin/Media/"+info.getSubfolder()+"/thumbnail/"+ String.valueOf(((Vector)img_vector.elementAt(i)).elementAt(1));  // �̹�������
                              %>
											<td ><img src="<%=img_url%>" width="120px;"/> <span> <input type='radio' name='main_img'  onClick='go_main_img(this.value);' value='<%=String.valueOf(((Vector)img_vector.elementAt(i)).elementAt(1))%>' 
											<%if (img_url.indexOf(info.getModelimage()) > 0 ) {out.println("checked='checked'");} %> /><label for="thumnail1"><%=img_time%></label></span></td>
									<% if ( i != 0 && (i+1) % 5 == 0) {out.println("</tr><tr>");} %>
								 <%
									 }
								 %>
							</tr>
							</tbody>
							</table>
							
						</td>
					</tr>
 				
					<%
					if (info.getCcode() != null && info.getCcode().equals("007000000000")) 
					{
 
							EventManager event_user = EventManager.getInstance();
							Vector event_user_vt = event_user.getUserInfo(info.getOcode(),"0");
							if (event_user_vt != null && event_user_vt.size() > 0) 
							{ %>
								<tr class="height_25">
									<th class="bor_bottom01"><strong>����ó</strong></th>
									<td class="bor_bottom01 pa_left">
									<%=SEEDUtil.getDecrypt(event_user_vt.elementAt(4).toString()) %>
									</td>
									<th class="bor_bottom01"><strong>�̸���</strong></th>
									<td class="bor_bottom01 pa_left">
									<%=SEEDUtil.getDecrypt(event_user_vt.elementAt(5).toString()) %>
									</td>
								</tr>
						<%
							}
					}%>
					<tr class="height_25">
						<th class="bor_bottom01"><strong>���� (*)</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="text" name="title" value="<%=info.getTitle() %>" class="input01" style="width:600px;"/></td>
					</tr>
					<tr class="height_25">
	 					
						<th class="bor_bottom01"><strong>ī�װ� ���� (*)</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<select id="ccategory1" name="ccategory1" class="sec01" style="width:125px;" onchange="javascript:setCcode(document.frmMedia, this.value); refreshCategoryList('V', this.value, 'B', 'ccategory2');">
							<option value="">--- ��з� ���� ---</option>
						</select>
	
						<select id="ccategory2" name="ccategory2" class="sec01" style="width:125px;" onchange="javascript:setCcode(document.frmMedia, this.value);refreshCategoryList('V', this.value, 'C', 'ccategory3');">
							<option value="">--- �ߺз� ���� ---</option>
						</select>
	 
						<select id="ccategory3" name="ccategory3" class="sec01" style="width:125px;" onchange="javascript:setCcode(document.frmMedia, this.value);">
							<option value="">--- �Һз� ���� ---</option>
						</select>
<!-- 						<select id="ccategory4" name="ccategory4" class="sec01" style="width:125px;" onchange="javascript:setCcode(document.frmMedia, this.value);"> -->
<!-- 							<option value="">--- ���з� ���� ---</option> -->
<!-- 						</select> -->
 
						</td>

					</tr>
					<tr class="height_25">
					
						<th class="bor_bottom01"><strong>���α׷� ����</strong></th>
						<td class="bor_bottom01 pa_left" >
						<select id="vcategory1" name="vcategory1" class="sec01" style="width:125px;" onchange="javascript:setCcodeY(document.frmMedia, this.value); refreshCategoryListV('Y', this.value, 'B', 'vcategory2');">
						<option value="">--- ��з� ���� ---</option>
						</select>
						 
						<select id="vcategory2" name="vcategory2" class="sec01" style="width:125px;" onchange="javascript:setCcodeY(document.frmMedia, this.value);">
							<option value="">--- �ߺз� ���� ---</option>
						</select>
							
						</td>
						<th class="bor_bottom01"><strong>�ۼ��� (*)</strong></th>
						<td class="bor_bottom01 pa_left" >
 						<%=info.getOwnerid() %>
						</td>
						
					</tr>
				
					
					
					<tr class="height_25">
						<th class="bor_bottom01"><strong>�о� ����</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<%
						if(cate_x != null && cate_x.size()>0)
						{
						int cntx = 0;
						CategoryInfoBean xinfo = new CategoryInfoBean();
						for(Enumeration e = cate_x.elements(); e.hasMoreElements();) {
							com.yundara.beans.BeanUtils.fill(xinfo, (Hashtable)e.nextElement());
							
							cntx ++;
						%>
						<input type="checkbox" name="xcode" value="<%=xinfo.getCcode()%>" <%if (info.getXcode().contains(xinfo.getCcode())) {out.println("checked='checked'");} %>/><%=xinfo.getCtitle()%>&nbsp;&nbsp;&nbsp;
						<%
							 if (cntx % 8 == 0) {out.println("<br/>");}
							} 
						}%>
							
						</td>
					</tr>
 
					<tr class="height_25">
						<th class="bor_bottom01"><strong>����������</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio" name="openflag"  value="Y" <%if(info.getOpenflag().equals("Y")) { out.println("checked='checked'");}%> /> ����&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="openflag" value="N"  <%if(info.getOpenflag().equals("N")) { out.println("checked='checked'");}%>/> �����
					    </td>
						<th class="bor_bottom01"><strong>����ϰ�������</strong></th>
						 
						<td class="bor_bottom01 pa_left"><input type="radio" name="openflag_mobile"  value="Y"  <%if(info.getOpenflag_mobile().equals("Y")) { out.println("checked='checked'");}%>/> ����&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="openflag_mobile"  value="N" <%if(info.getOpenflag_mobile().equals("N")) { out.println("checked='checked'");}%>/> �����
					    </td>
					</tr>
					 
					 <tr class="height_25">
						<th class="bor_bottom01"><strong>�������� (*)</strong>
						</br>100�� ����
						</th>
						<td class="bor_bottom01 pa_left" colspan="3">
					 
						<textarea name="content_simple" id="content_simple" style="width:620px;height:80px;" cols="100" rows="60"><%=info.getContent_simple()%></textarea>
						</td>
					</tr> 
					
					<tr>
						<th class="bor_bottom01"><strong>���� (*)</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3" >
						<textarea name="description" id="description" style="width:620px;height:293px; display:none;" cols="100" rows="10" ><%=info.getDescription()%></textarea>
								<script type="text/javascript">
									var oEditors = [];
									nhn.husky.EZCreator.createInIFrame({
									    oAppRef: oEditors,
									    elPlaceHolder: "description",
									    sSkinURI: "/vodman/editer_2/SmartEditor2Skin.html",
									    fCreator: "createSEditor2"
									});
							
									function insertIMG(qnacontent,filename){ 
								        var sHTML = "<img src="+qnacontent+"/"+filename+">"; 
								        oEditors.getById["description"].exec("PASTE_HTML", [sHTML]); 
									} 
								</script>
						</td>
					</tr>
					
					<tr class="height_25">
 
						<th class="bor_bottom01"><strong>�������</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<input type="text" name="mk_date" value="<%=info.getMk_date()%>" class="input01" style="width:70px;"/>&nbsp;<a href="javascript:openCalendarWindow(document.frmMedia.mk_date);" title="ã�ƺ���"><img src="/vodman/include/images/icon_calender.gif" alt="ã�ƺ���"/></a>
						</td>
					</tr>
					<tr class="height_25">
 
						<th class="bor_bottom01"><strong>��������</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<input type="text" name="open_date" value="<%=info.getOpen_date()%>" class="input01" style="width:70px;"/>&nbsp;<a href="javascript:openCalendarWindow(document.frmMedia.open_date);" title="ã�ƺ���"><img src="/vodman/include/images/icon_calender.gif" alt="ã�ƺ���"/></a>
						* �������θ� ������� ���� �Ͻð� ����ϼ��� (�ش����ڿ� ������ ����˴ϴ�.)
						</td>
					</tr>
					
					<tr class="height_25">
 
						<th class="bor_bottom01"><strong>���������</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<input type="text" name="close_date" value="<%=info.getClose_date()%>" class="input01" style="width:70px;"/>&nbsp;<a href="javascript:openCalendarWindow(document.frmMedia.close_date);" title="ã�ƺ���"><img src="/vodman/include/images/icon_calender.gif" alt="ã�ƺ���"/></a>
						* �ش����ڿ� ������� ����˴ϴ�. ���ڰ� ���������� �������� ������� ���� �ؾ� �մϴ�.    
						</td>
					</tr>
					
					<tr class="height_25">
						<th class="bor_bottom01"><strong>�۰���  ���� </strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="radio" name="linkcopy_flag"  value="Y"  <%if(info.getLinkcopy_flag().equals("Y")) { out.println("checked='checked'");}%>/> ���&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="linkcopy_flag"  value="N"  <%if(info.getLinkcopy_flag().equals("N")) { out.println("checked='checked'");}%>/> �����</td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01"><strong>�ٿ�ε� ���� </strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="radio" name="download_flag"  value="Y" <%if(info.getDownload_flag().equals("Y")) { out.println("checked='checked'");}%>/> ���&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="download_flag"  value="N"  <%if(info.getDownload_flag().equals("N")) { out.println("checked='checked'");}%>/> �����</td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01"><strong>��ǥ�̹���</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="file" id="thumbnail_file" name="thumbnail_file" class="sec01" size="40" value="" onchange="javascript:limitFile('thumbnail_file')" />
						<% if (info.getThumbnail_file() != null && info.getThumbnail_file().indexOf(".") > 1) { %> <p style="margin-left:5px; margin-top: 3px;">
						  <img src="img_.jsp?no=<%=ocode%>" height="150px;" />
						���� <input type="checkbox" name="thumbnail_file_del" value="Y" /></p><%} %> 
					    </td>
					</tr>
	 
					<tr class="height_25">
						<th class="bor_bottom01"><strong>÷������</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="file" id="attach_file" name="attach_file" class="sec01" size="40" value="" onchange="javascript:limitFile('attach_file')" />
						<% if (info.getAttach_file() != null && info.getAttach_file().indexOf(".") > 1) { %> <p style="margin-left:5px; margin-top: 3px;">
						<a href="attach_download.jsp?ocode=<%=info.getOcode()%>">
						<%if (info.getOrg_attach_file() != null && info.getOrg_attach_file().length() > 0) { out.println(info.getOrg_attach_file()); } else {out.println(info.getAttach_file());} %>
						</a>
						���� <input type="checkbox" name="attach_file_del" value="Y" /></p><%} %> 
					    </td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01"><strong>���� �ٿ�ε� </strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<%
						String sourcefile_url = DirectoryNameManager.SILVERLIGHT_SERVERNAME+"/ClientBin/Media/"+info.getSubfolder()+"/Middle/"+info.getMediumfilename();
						String mp4file_url = DirectoryNameManager.SILVERLIGHT_SERVERNAME+"/ClientBin/Media/"+info.getSubfolder()+"/Encoded/"+info.getEncodedfilename();
						%>
						<a href="<%=sourcefile_url%>">* �Ϲ�ȭ�� �ٿ�ε� <br/> <%=sourcefile_url%> </a> <br/>
						<%
						if(info.getEncodedfilename() != null && info.getEncodedfilename().length()>4){
						%>
						<a href="<%=mp4file_url%>">* ��ȭ�� �ٿ�ε� <br/> <%=mp4file_url%></a>
						<%}%>
						</td>
					</tr>
					
					<tr class="height_25">
						<th class="bor_bottom01"><strong>������ ����</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
							<font color="blue">����</font>  
							<br/>
 
							<input type="checkbox" name="gender_type" value="M" <% if (info.getGender_type() != null && info.getGender_type().indexOf("M") >= 0) out.println("checked='checked'"); %> />��
							<input type="checkbox" name="gender_type" value="F" <% if (info.getGender_type() != null && info.getGender_type().indexOf("F") >= 0) out.println("checked='checked'"); %>/>��
							<br/>
							<br/>
							<font color="blue">���ɴ�</font>    
							<br/> 
							<input type="checkbox" name="age_type" value="NB" <% if (info.getAge_type() != null && info.getAge_type().indexOf("NB") >= 0) out.println("checked='checked'"); %>/>������
							<input type="checkbox" name="age_type" value="CH" <% if (info.getAge_type() != null && info.getAge_type().indexOf("CH") >= 0) out.println("checked='checked'"); %>/>���
							<input type="checkbox" name="age_type" value="YU" <% if (info.getAge_type() != null && info.getAge_type().indexOf("YU") >= 0) out.println("checked='checked'"); %>/>û�ҳ�
							<input type="checkbox" name="age_type" value="AD" <% if (info.getAge_type() != null && info.getAge_type().indexOf("AD") >= 0) out.println("checked='checked'"); %>/>����
							<input type="checkbox" name="age_type" value="OM" <% if (info.getAge_type() != null && info.getAge_type().indexOf("OM") >= 0) out.println("checked='checked'"); %>/>����
							<br/>
							<br/>
							<font color="blue">�о�</font>    
							<br/>
							<input type="checkbox" name="section_type" value="1181" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1181") >= 0) out.println("checked='checked'"); %>/>�ο�
							<input type="checkbox" name="section_type" value="1183" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1183") >= 0) out.println("checked='checked'"); %>/>��������/����
							<input type="checkbox" name="section_type" value="1182" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1182") >= 0) out.println("checked='checked'"); %>/>�ù�����
							<input type="checkbox" name="section_type" value="1184" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1184") >= 0) out.println("checked='checked'"); %>/>�����ҽ�
							<input type="checkbox" name="section_type" value="1185" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1185") >= 0) out.println("checked='checked'"); %>/>�����Ұ�
							
							<input type="checkbox" name="section_type" value="1170" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1170") >= 0) out.println("checked='checked'"); %>/>����
							<input type="checkbox" name="section_type" value="1175" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1175") >= 0) out.println("checked='checked'"); %>/>����
							<input type="checkbox" name="section_type" value="1179" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1179") >= 0) out.println("checked='checked'"); %>/>����
							<input type="checkbox" name="section_type" value="1178" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1178") >= 0) out.println("checked='checked'"); %>/>����
							<input type="checkbox" name="section_type" value="1174" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1174") >= 0) out.println("checked='checked'"); %>/>��ȭ����
							<br/>
							<input type="checkbox" name="section_type" value="1169" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1169") >= 0) out.println("checked='checked'"); %>/>�ι���
							<input type="checkbox" name="section_type" value="1180" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1180") >= 0) out.println("checked='checked'"); %>/>����
							<input type="checkbox" name="section_type" value="1173" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1173") >= 0) out.println("checked='checked'"); %>/>����
							<input type="checkbox" name="section_type" value="1172" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1172") >= 0) out.println("checked='checked'"); %>/>����
							<input type="checkbox" name="section_type" value="1168" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1168") >= 0) out.println("checked='checked'"); %>/>����
							
							<input type="checkbox" name="section_type" value="1186" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1186") >= 0) out.println("checked='checked'"); %>/>�ι���
							<input type="checkbox" name="section_type" value="1171" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1171") >= 0) out.println("checked='checked'"); %>/>���ڸ�
							<input type="checkbox" name="section_type" value="1176" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1176") >= 0) out.println("checked='checked'"); %>/>�������
							<input type="checkbox" name="section_type" value="1177" <% if (info.getSection_type() != null && info.getSection_type().indexOf("1177") >= 0) out.println("checked='checked'"); %>/>ȯ��
							 
							<br/>
							<br/>
							<font color="blue">Ű����</font> 
							<br/>
							<input type="text" name="tag_kwd" value="<%=info.getTag_kwd()%>" class="input01" style="width:600px;"/>
							<br/>
							[Ű����� �ܹ����� �Է��ϵ� (/) �� �����Ͽ� �Է½ø� �˴ϴ�. ��) ����/ȭ��  ]
					    </td>
					</tr>

					<tr class="height_25">
						<th class="bor_bottom01"><strong>���� ���</strong> <span class="btn_m"><a href="javascript:addRow();">�߰�</a><!--<a class="addBtn" href="javascript:;" onclick="rowAdd('tbladdsimuItem')">�߰�</a>--></span></th>
						<td class="bor_bottom01 pa_left" colspan="3">
 
							 
							<div id="textFrom"  class="tbladdsimuItem">
							<% if (news != null) {
   								 for ( int i = 0; i < news.size() ; i++) {  
  							 	com.yundara.beans.BeanUtils.fill(newsInfoBean, (Hashtable)news.get(i));%>  
								<div id="block<%=i%>">
									<dl>
										<dt><label for="news_title<%=i%>">���� :</label> </dt>
										<dd><input type="text" value="<%=newsInfoBean.getTitle()%>" id="news_title<%=i%>" name="news_title"/></dd>
										<dt><label for="news_url<%=i%>">URL :</label> </dt>
										<dd><input type="text" value="<%=newsInfoBean.getLink()%>" id="news_url<%=i%>" name="news_link"/></dd>
										<dt><label for="news_date<%=i%>">Date :</label> </dt>
										<dd><input type="text" value="<%=newsInfoBean.getWdate()%>" id="news_date<%=i%>" name="news_date"/></dd>
									</dl> 
									<input type="button" value="����" class="input" onclick="deleteRow(<%=i%>);">	
								</div>
								<%}
 								 }%>  
								<input type="hidden" name="defaultRow" value="0">
								<input type="hidden" name="maxRow" value="<%=news.size()%>">
							
								<div id="addRowBlock" >

								</div>

							</div>	 
						</td>
					</tr>
					
					
				
				</tbody>
				</table>
				</form>
				<div class="but01">
		 
                    <a href="javascript:memo_comment('<%=ocode%>');"><img src="/vodman/include/images/but_reply.gif" border="0"></a>
					 
					<a href="frm_AddNewContent.jsp?ocode=<%=ocode %>&ccode=<%=ccode%>&mcode=<%=mcode%>" title="����ü"><img src='/vodman/include/images/btn_vodChange.gif' alt='���� ��ü'/></a>
					<a href="javascript:start_insert();" title="Ȯ��"><img src="/vodman/include/images/but_ok3.gif" alt="Ȯ��"/></a>
					<a href="javascript:history.go(-1);" title="���"><img src="/vodman/include/images/but_cancel.gif" alt="���"/></a>
				</div>	
			</div>
		</div>
		<div id="img_position" style="display:none;">
			<a href="#" class="img_position_close hidemodal"><img src="../include/images/btn_view_close2.gif" alt="�ݱ�"/></a>
			<div class="img_position_in" >
				<iframe id="position_xy" src="pop_img_position.jsp?ocode=<%=ocode %>&mcode=<%=mcode %>" width="100%" height="500" frameborder="0"></iframe>
			</div>
		</div><!--//menuFull-->
		<!--���������κ�-->
		<script type="text/javascript">
		$(function(){
		  $('.flatbtn').leanModal({ top: 110, overlay: 0.6, closeButton: ".hidemodal" });
		 
		});
		</script>
		<!--//���������κ�-->	
		<!--����߰�-->
		<script type="text/javascript">
			function addRow(){
        var f = document.frmMedia;

//		 if (Number(f.defaultRow.value) > 2 ){
//           alert("�� �̻� �߰��Ͻ� �� �����ϴ�.");
//            return;
//		} else{

			var mr = Number(f.maxRow.value) + 1;
			var dr = Number(f.defaultRow.value) + 1;
			f.maxRow.value = mr;
			f.defaultRow.value = dr;

			var sel_inx = mr+2;

			var html = "<div id=block" + mr + " class='rowblock_list' >"
				+ "<dl>"
				+ "<dt><label for='news_title" + mr + "'>���� :</label> </dt>"
				+ "<dd><input type='text'  id='news_title" + mr + "' name='news_title'/></dd>"
				+ "<dt><label for='news_url" + mr + "'>URL :</label> </dt>"
				+ "<dd><input type='text' id='news_url" + mr + "' name='news_link'/></dd>"
				+ "<dt><label for='news_date" + mr + "'>Date :</label> </dt>"
				+ "<dd><input type='text' id='news_date" + mr + "' name='news_date'/></dd>"
				+ "</dl>"
				+ "<input type='button' value='����' class='input' onClick='deleteRow(" + mr + ");'></br>"
				+ "</div>";
				document.getElementById('addRowBlock').insertAdjacentHTML("BeforeEnd", html);
//	   }
    }
    function deleteRow(delGap){
        var f = document.frmMedia;
        var defaultRowNum = f.defaultRow.value;
        if (Number( defaultRowNum ) == 1 ){
            alert("�� �̻� �����Ͻ� �� �����ϴ�.");
            return;
        } else {
            f.defaultRow.value = Number(defaultRowNum) - 1;
            eval("document.getElementById('block" + delGap + "').outerHTML = '';");
        }
    }
		</script><!--//����߰�-->
<!-- <IFRAME name="hiddenFrame" src="#" height="0" width="0" frameborder="0"></IFRAME> -->
<%@ include file="/vodman/include/footer.jsp"%>	

