<%--
date   : 2007-07-04
�ۼ��� : ����
����   : vod ���  

	openflag - ����, �����
	user_id, user_pwd - ����� ���̵�, ��� ��й�ȣ

--%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>

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
//	 VOD�� �ʱ�ȭ
	if(request.getParameter("ctype") != null)
	{
		ctype = request.getParameter("ctype").replaceAll("<","").replaceAll(">","");
		if (ctype.equals("A")) 
		mtitle = "AOD";
	}

if(request.getParameter("ccode") == null || request.getParameter("ccode").length()<=0 || request.getParameter("ccode").equals("null")) {
} else{
		ccode = request.getParameter("ccode").replaceAll("<","").replaceAll(">","");
}
		
	 Calendar cal = Calendar.getInstance();
		int year  = cal.get(Calendar.YEAR),
		    month = cal.get(Calendar.MONTH)+1,
		    date = cal.get(Calendar.DATE),
		hour = cal.get(Calendar.HOUR_OF_DAY),
		min = cal.get(Calendar.MINUTE),
		sec = cal.get(Calendar.MILLISECOND);
		 
		
String temp_month = "";
String temp_date="";
if (month <= 9) {
	temp_month = "0"+ month;
	} else {
		temp_month = Integer.toString(month);
	}
if (date <= 9) {
	temp_date = "0"+ date;
	} else {
		temp_date = Integer.toString(date);
	}

String today = year+"-"+temp_month+"-"+temp_date;
 
CategoryManager cmgr = CategoryManager.getInstance();
Vector cate_x = cmgr.getCategoryListALL2("X","A");
 
String menu_title = "�������";
%>
<%@ include file="/vodman/include/top.jsp"%>
<script language="javascript" src="/vodman/include/js/script.js"></script>
<script language="javascript" src="/vodman/include/js/viewer.js"></script>
<script type="text/javascript" src="/vodman/editer_2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script language="javascript" src="/vodman/include/js/ajax_category_select2.js"></script>
<script language="javascript">
// ��з� ī�װ� �ҷ����� (ajax_category_select.js)
//ctype, param, info,target
 
		window.onload = function() {
			refreshCategoryList_A('V', '', 'A', '<%=ccode%>');
			refreshCategoryList_B('V', '', 'B', '<%=ccode%>');
			refreshCategoryList_C('V', '', 'C', '<%=ccode%>');
<%-- 			refreshCategoryList_D('V', '', 'D', '<%=ccode%>'); --%>
			
			refreshCategoryList_AV('Y', '', 'A', '');
			refreshCategoryList_BV('Y', '', 'B', '');

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
			
			if (f.ccode.value=="") {
				   alert ("ī���ڸ��� �Է����� �����̽��ϴ�.")
				   f.ccode.focus();
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
 

// 			if(f.encodedfilename.value == "") {
// 				   alert ("�������� ��� ���� �ʾҽ��ϴ�.")
// 			   return
// 			}
			
			
			//if (f.user_pwd.value=="") {
			//	   alert ("��й�ȣ�� �Է����� �����̽��ϴ�.")
			//	   f.user_pwd.focus();
			//	   return
			//}else if(!pwCheck(f.user_pwd.value)){
			//		f.user_pwd.focus();
			//		alert("����+����+Ư�� ���ڸ� ��� �ϳ� �̻� ������ 8�� �̻�, 12�� �̳��� �Է��Ͻñ� �ٶ��ϴ�.");
			//		return;
			//}
// 			var vod_img = document.getElementsByName("vod_images2");
// 			if(vod_img){
// 				if(vod_img.length > 1){
// 					for(i=0;i<vod_img.length;i++){
// 						var txt = document.createElement("input");
// 						txt.setAttribute("type","hidden");
// 						txt.setAttribute("id","vod_images"+i);
// 						txt.setAttribute("name","vod_images");
// 						txt.setAttribute("value",vod_img[i].value);
// 						document.forms['frmMedia'].appendChild(txt);
// 					}
// 				}
// 			}else{
// 				alert('�̹����� ��ϵ��� �ʾҽ��ϴ�.');
// 			}
					
			
			f.action="proc_write_ucc.jsp?ccode=<%=ccode%>&mcode=<%=mcode%>";
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

 
</script>

 
<script type="text/javascript" src="<%=DirectoryNameManager.SILVERLIGHT_SERVERNAME%>/Silverlight.js"></script>
 
<script type="text/javascript">
function onSilverlightError(sender, args) {

    var appSource = "";
    if (sender != null && sender != 0) {
        appSource = sender.getHost().Source;
    } 
    var errorType = args.ErrorType;
    var iErrorCode = args.ErrorCode;
    
    var errMsg = "Unhandled Error in Silverlight Application " +  appSource + "\n" ;

    errMsg += "Code: "+ iErrorCode + "    \n";
    errMsg += "Category: " + errorType + "       \n";
    errMsg += "Message: " + args.ErrorMessage + "     \n";

    if (errorType == "ParserError")
    {
        errMsg += "File: " + args.xamlFile + "     \n";
        errMsg += "Line: " + args.lineNumber + "     \n";
        errMsg += "Position: " + args.charPosition + "     \n";
    }
    else if (errorType == "RuntimeError")
    {           
        if (args.lineNumber != 0)
        {
            errMsg += "Line: " + args.lineNumber + "     \n";
            errMsg += "Position: " +  args.charPosition + "     \n";
        }
        errMsg += "MethodName: " + args.methodName + "     \n";
    }

    throw new Error(errMsg);
}
function returnPath(path)
{
var pathArray = path.split(":")
//alert(path);
var subfolder = pathArray[0]; // �������
var ocode = pathArray[1];
var filename = pathArray[2];  // �������ϸ�
//var playtime = pathArray[3];  // ����ð�
 
			document.getElementById("ocode").value = ocode;
//			document.getElementById("playtime").value = playtime;
			document.getElementById("filename").value  = filename;
 
			document.getElementById("subfolder").value  = subfolder;
 
	alert("������ ���ε� �Ǿ����ϴ�. ����� ������ �Է��� ������ ���� �ּ���");
}
</script>
 
 
 <style type="text/css">
        .main_img { width: 95px; height: 70px; text-align: center; border:1px solid silver;
        background: url(/vodman/include/images/no_image.gif) repeat-x bottom;
        }
</style>
<%
if (ccode != null && ccode.length() > 0) {
	menu_title = cmgr.getCategoryName(ccode, "V");
} else {
	mcode = "0710";
}
%>
<%@ include file="/vodman/vod_aod/vod_left.jsp"%>
		<div id="contents">
			<h3><%= menu_title%></h3>
			<!--<p class="location">������������ &gt; ������ ���� &gt; <span><%=mtitle%> ���</span></p>-->
			<div id="content">
		 
			<p class="title_dot01">������ ���� �Է� <span class="font_11r"> (*) �ʼ� �Է��׸� �Դϴ�.</span></p>
				<table cellspacing="0" class="board_view" summary="<%=mtitle%> ���">
				<caption><%=mtitle%> ���</caption>
				<colgroup>
					<col width="15%" class="back_f7"/>
					<col width="35%"/>
					<col width="15%" class="back_f7"/>
					<col width="35%"/>
				</colgroup>
				<tbody>
				<form name='frmMedia' method='post' enctype="multipart/form-data" id="frmMedia" />
		 		<input type="hidden" id="ocode" name="ocode" value=""/>
				<input type="hidden" name="playtime" id="playtime" value="00:00:00" />
				<input type="hidden" name="filename" id="filename" value="" />
				<input type="hidden" name="modelimage" id="modelimage" value="" />
				<input type="hidden" name="encodedfilename" id="encodedfilename" value="" />
				<input type="hidden" name="encoding_plan" id="encoding_plan" value="WEB_MEDIUM_MOBILE" />
				<input type="hidden" name="subfolder" id="subfolder" value="" />
				<input type="hidden" id="ccode" name="ccode" value="<%=ccode%>"/>
				<input type="hidden" id="ycode" name="ycode" value=""/>

				<input type="hidden" name="mobilefilename" id="mobilefilename" value="" />
					 <tr>
						<td class="bor_bottom01 right_border" colspan="4" align="center" >
								
							<div id="media_player">
				   
							  	<div id='errorLocation' style="font-size: small;color: Gray;"></div>		 
								<div id="silverlightControlHost">
									<object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="460" height="410">
										<param name="source" value="<%=DirectoryNameManager.SILVERLIGHT_SERVERNAME %>/ClientBin/VODManager_Upload_UCC.xap"/>
										<param name="onerror" value="onSilverlightError" />
										<param name="background" value="white" />
										<param name="minRuntimeVersion" value="3.0.40624.0" />
										<param name="initParams" value="RegMode=3,returnThumbnails=true, userID=<%=vod_id %>,showFinishButton=false, useMaxFileSizeUcc=false"/>
										<param name="autoUpgrade" value="true" />
										<a href="http://go.microsoft.com/fwlink/?LinkID=141205" style="text-decoration: none;">
											<img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style: none"/>
										</a>
										<param name="enableHtmlAccess" value="true" />
									</object>
									<iframe style='visibility:hidden;height:0;width:0;border:0px'></iframe>
								</div>
             
							</div>
							<div id="img_panel"></div>
						</td>
					</tr>
					 <tr class="height_25">
						<th class="bor_bottom01"><strong>���� (*)</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="text" name="title" value="" class="input01" style="width:600px;"/></td>
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
 						<%=vod_name %>
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
						<input type="checkbox" name="xcode" value="<%=xinfo.getCcode()%>"/><%=xinfo.getCtitle()%>&nbsp;&nbsp;&nbsp;
						
<%
							 if (cntx % 8 == 0) {out.println("<br/>");}
							} 
						}%>
							
						</td>
					</tr>
					
					
 
					<tr class="height_25">
						<th class="bor_bottom01"><strong>����������</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio" name="openflag"  value="Y" checked="checked" /> ����&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="openflag"  value="N"/> �����
					    </td>
						<th class="bor_bottom01"><strong>����ϰ�������</strong></th>
						 
						<td class="bor_bottom01 pa_left"><input type="radio" name="openflag_mobile"  value="Y" checked="checked" /> ����&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="openflag_mobile"  value="N"/> �����
					    </td>
					</tr>
					
					<tr class="height_25">
						<th class="bor_bottom01"><strong>�������� (*)</strong>
						</br>100�� ����
						</th>
						<td class="bor_bottom01 pa_left" colspan="3">
					 
						<textarea name="content_simple" id="content_simple" style="width:620px;height:80px;" cols="100" rows="60"></textarea>
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>���� (*)</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<textarea name="description" id="description" style="width:620px;height:300px;" cols="100" rows="60"></textarea>
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
						<input type="text" name="mk_date" value="<%=today%>" class="input01" style="width:70px;"/>&nbsp;<a href="javascript:openCalendarWindow(document.frmMedia.mk_date);" title="ã�ƺ���"><img src="/vodman/include/images/icon_calender.gif" alt="ã�ƺ���"/></a>
						</td>
					</tr>
					<tr class="height_25">
 
						<th class="bor_bottom01"><strong>��������</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<input type="text" name="open_date" value="<%=today%>" class="input01" style="width:70px;"/>&nbsp;<a href="javascript:openCalendarWindow(document.frmMedia.open_date);" title="ã�ƺ���"><img src="/vodman/include/images/icon_calender.gif" alt="ã�ƺ���"/></a>
						* �������θ� ������� ���� �Ͻð� ����ϼ��� (�ش����ڿ� ������ ����˴ϴ�.)
						</td>
					</tr>
					<tr class="height_25">
 
						<th class="bor_bottom01"><strong>���������</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<input type="text" name="close_date" value="" class="input01" style="width:70px;"/>&nbsp;<a href="javascript:openCalendarWindow(document.frmMedia.close_date);" title="ã�ƺ���"><img src="/vodman/include/images/icon_calender.gif" alt="ã�ƺ���"/></a>
						* �������θ� ������� ���� �Ͻð� ����ϼ��� (�ش����ڿ� ������ ����˴ϴ�.)
						</td>
					</tr>
					
					<tr class="height_25">
						<th class="bor_bottom01"><strong>�۰���  ���� </strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="radio" name="linkcopy_flag"  value="Y"  checked="checked"/> ���&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="linkcopy_flag"  value="N" /> �����</td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01"><strong>�ٿ�ε� ���� </strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="radio" name="download_flag"  value="Y" checked="checked"/> ���&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="download_flag"  value="N"  /> �����</td>
					</tr>
	 				<tr class="height_25">
						<th class="bor_bottom01"><strong>��ǥ�̹��� ����</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="file" id="thumbnail_file" name="thumbnail_file" class="sec01" size="40" value="" onchange="javascript:limitFile('thumbnail_file')" />
					 
					    </td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01"><strong>÷������</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="file" id="attach_file" name="attach_file" class="sec01" size="40" value="" onchange="javascript:limitFile('attach_file')" />
						<!-- <p style="margin-left:5px; margin-top: 3px;"> * �����ټ��� ���� �ڸ� ������� �ؽ�Ʈ�� �� �뺻�� ÷��</p> -->
					    </td>
					</tr>
					
					<tr class="height_25">
						<th class="bor_bottom01"><strong>������ ����</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
							<font color="blue">����</font>  
							<br/>
							<input type="checkbox" name="gender_type" value="M"/>��
							<input type="checkbox" name="gender_type" value="F"/>��
							<br/>
							<br/>
							<font color="blue">���ɴ�</font>    
							<br/> 
							<input type="checkbox" name="age_type" value="NB"/>������
							<input type="checkbox" name="age_type" value="CH"/>���
							<input type="checkbox" name="age_type" value="YU"/>û�ҳ�
							<input type="checkbox" name="age_type" value="AD"/>����
							<input type="checkbox" name="age_type" value="OM"/>����
							<br/>
							<br/>
							<font color="blue">�о�</font>    
							<br/>
							<input type="checkbox" name="section_type" value="1181"/>�ο�
							<input type="checkbox" name="section_type" value="1183"/>��������/����
							<input type="checkbox" name="section_type" value="1182"/>�ù�����
							<input type="checkbox" name="section_type" value="1184"/>�����ҽ�
							<input type="checkbox" name="section_type" value="1185"/>�����Ұ�
							
							<input type="checkbox" name="section_type" value="1170"/>����
							<input type="checkbox" name="section_type" value="1175"/>����
							<input type="checkbox" name="section_type" value="1179"/>����
							<input type="checkbox" name="section_type" value="1178"/>����
							<input type="checkbox" name="section_type" value="1174"/>��ȭ����
							<br/>
							<input type="checkbox" name="section_type" value="1169"/>�ι���
							<input type="checkbox" name="section_type" value="1180"/>����
							<input type="checkbox" name="section_type" value="1173"/>����
							<input type="checkbox" name="section_type" value="1172"/>����
							<input type="checkbox" name="section_type" value="1168"/>����
							
							<input type="checkbox" name="section_type" value="1186"/>�ι���
							<input type="checkbox" name="section_type" value="1171"/>���ڸ�
							<input type="checkbox" name="section_type" value="1176"/>�������
							<input type="checkbox" name="section_type" value="1177"/>ȯ��
							 
							<br/>
							<br/>
							<font color="blue">Ű����</font> 
							<br/>
							<input type="text" name="tag_kwd" value="" class="input01" style="width:600px;"/>
							<br/>
							[Ű����� �ܹ����� �Է��ϵ� (/) �� �����Ͽ� �Է½ø� �˴ϴ�. ��) ����/ȭ��  ]
					    </td>
					</tr>
					
					</form>
				</tbody>
				</table>
				<div class="but01">
					<a href="javascript:start_insert();" title="Ȯ��"><img src="/vodman/include/images/but_ok3.gif" alt="Ȯ��"/></a>
					<a href="javascript:history.go(-1);" title="���"><img src="/vodman/include/images/but_cancel.gif" alt="���"/></a>
				</div>	
			</div>
		</div>
 
<IFRAME name="hiddenFrame" src="" height="0" width="0" frameborder="0"></IFRAME>
<%@ include file="/vodman/include/footer.jsp"%>	

