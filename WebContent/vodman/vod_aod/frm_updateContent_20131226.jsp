<%--
date   : 2007-07-04
작성자 : 주현
내용   : vod 등록  

	openflag - 공개, 비공개
	user_id, user_pwd - 등록자 아이디, 등록 비밀번호

--%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@page import="com.security.SEEDUtil"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
	if(!chk_auth(vod_id, vod_level, "v_write")) {
	    out.println("<script language='javascript'>\n" +
	                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
	                "history.go(-1);\n" +
	                "</script>");
	    return;
	} 

%>
<%
	/**
	 * @author 이희락
	 *
	 * description : 주문형 VOD 정보 등록
	 * date : 2007-09-05
	 */

	String mtitle = "VOD";
	String ctype = "V";
 
	String ccode = "";
	String ocode = "";
//	 VOD로 초기화
	if(request.getParameter("ctype") != null)
	{
		ctype = request.getParameter("ctype").replaceAll("<","").replaceAll(">","");
		if (ctype.equals("A")) 
		mtitle = "AOD";
	}


	if(request.getParameter("ocode") == null || request.getParameter("ocode").length()<=0 || request.getParameter("ocode").equals("null")) {
		out.println("<script lanauage='javascript'>alert('미디어코드가 없습니다. 다시 선택해주세요.'); history.go(-1); </script>");
		return;
	} else
		ocode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");

	if(request.getParameter("ccode") == null || request.getParameter("ccode").length()<=0 || request.getParameter("ccode").equals("null")) {
		out.println("<script lanauage='javascript'>alert('미디어코드가 없습니다. 다시 선택해주세요.'); history.go(-1); </script>");
		return;
	} else
		ccode = request.getParameter("ccode").replaceAll("<","").replaceAll(">","");

	String pg = request.getParameter("page").replaceAll("<","").replaceAll(">","");
	
	com.hrlee.sqlbean.MediaManager mgr = com.hrlee.sqlbean.MediaManager.getInstance();
	Vector vt = mgr.getOMediaInfo(ocode);			// 주문형미디어 서브정보
	com.hrlee.silver.OrderMediaInfoBean info = new com.hrlee.silver.OrderMediaInfoBean();
 	 
	if(vt != null && vt.size()>0){
		try {
			Enumeration e = vt.elements();
			com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
 		} catch (Exception e) {
			out.println("<script lanauage='javascript'>alert('동영상 정보 조회에 실패하였습니다. 이전 페이지로 이동합니다.'); history.go(-1); </script>");
			return;
		}
	}else{
		out.println("<script lanauage='javascript'>alert('동영상 정보 조회에 실패하였습니다. 이전 페이지로 이동합니다.'); history.go(-1); </script>");
		return;
	}
	
	CategoryManager cmgr = CategoryManager.getInstance();
	Vector cate_x = cmgr.getCategoryListALL2("X","A");
 
%>
<%@ include file="/vodman/include/top.jsp"%>
<script language="javascript" src="/vodman/include/js/script.js"></script>
<script language="javascript" src="/vodman/include/js/viewer.js"></script>
<script type="text/javascript" src="/vodman/editer/js/HuskyEZCreator.js" charset="utf-8"></script>
<script language="javascript" src="/vodman/include/js/ajax_category_select2.js"></script>
<script language="javascript">
// 대분류 카테고리 불러오기 (ajax_category_select.js)
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


		<%
		FucksInfoManager fmgr = FucksInfoManager.getInstance();
		Hashtable result_ht = null;
		result_ht = fmgr.getAllFucks_admin("");
		Vector fvt = null;
		com.yundara.util.PageBean pageBean = null;
		int totalArticle =0; //총 레코드 갯수
		int totalPage = 0 ; //
		if(!result_ht.isEmpty() ) {
		    fvt = (Vector)result_ht.get("LIST");

			if ( fvt != null && fvt.size() > 0){
		        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
		        if(pageBean != null){
		        	pageBean.setPagePerBlock(10);
		        	pageBean.setPage(1);
					totalArticle = pageBean.getTotalRecord();
			        totalPage = pageBean.getTotalPage();
		        }
			}
		}
		%>
		var rgExp;
		<%
		if(totalPage >0 ){
		%>
		var splitFilter = new Array("script",<%=totalPage%>);
		<%
		}else{%>
		var splitFilter = new Array("시팔","씨팔","쌍놈","쌍년","개년","개놈","개새끼","니미럴","개같은년","개같은놈","니기미","존나","좃나","십새끼","script");
		<%
		}
		%>
		<%
		if(fvt != null && fvt.size()>0){
			int list = 0;
			FuckInfoBean linfo = new FuckInfoBean();
			for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<fvt.size()) ; i++, list++){
				  com.yundara.beans.BeanUtils.fill(linfo, (Hashtable)fvt.elementAt(list));
				  %>
				  splitFilter[<%=i%>] = '<%=linfo.getFucks()%>';
				  <%
			}
		}
		%>
		function filterIng(str , element , id){  
			for (var ii = 0 ;ii < splitFilter.length  ; ii++ )
			{
				rgExp = splitFilter[ii];
				if (str.match(rgExp))
				{
					alert(rgExp + "은(는) 불량단어로 입력하실수 없습니다");
					var range = document.getElementsByName(id)[0].createTextRange();
					range.findText(rgExp);
					range.select();
					return false;
				}
			}
		}
		
		function start_insert(){

			var f = document.frmMedia;
	      
			//if (f.ownerid.value=="") {
			//  alert ("작성자가 없습니다.")
			//   f.ownerid.focus();
			//   return
			//}
			 
			if (f.title.value=="") {
			   alert ("제목을 입력하지 않으셨습니다.")
			   f.title.focus();
			   return
			}
			 
			if(filterIng(f.title.value, f.title,"title") == false){
				return;
			}
			if(!CheckText(f.title)){
				return;
			}

			//oEditors.getById["description"].exec("UPDATE_IR_FIELD", []);
			oEditors[0].exec("UPDATE_CONTENTS_FIELD", []);
			// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("list_contents").value를 이용해서 처리하면 됩니다.
			 
			if (f.description.value=="") {
			   alert ("내용을 입력하지 않으셨습니다.")
			  // f.description.focus();
			   return
			}
		 
			if(filterIng(document.getElementById("description").value, f.description,"description") == false){
				return;
			}
		 
			if(f.encodedfilename.value == "") {
				   alert ("동영상이 등록 되지 않았습니다.")
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
							alert("(')특수문자는 불가능합니다");
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
	//달력 open window event 
	//////////////////////////////////////////////////////

	var calendar=null;

	/*날짜 hidden Type 요소*/
	var dateField;

	/*날짜 text Type 요소*/
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
		  
		   alert("입력하신 파일은 업로드 될 수 없습니다!");
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
    }

		function memo_comment(ocode) {
		window.open("/vodman/comment/comment.jsp?ocode="+ocode+"&flag=M","admin_commnet","width=540,height=250,scrolling=none");
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
</script>
 
 
 <style type="text/css">
        .main_img { width: 95px; height: 70px; text-align: center; border:1px solid silver;
        background: url(/vodman/include/images/no_image.gif) repeat-x bottom;
        }
</style>
<%@ include file="/vodman/vod_aod/vod_left.jsp"%>
		<div id="contents">
			<h3><%= CategoryManager.getInstance().getCategoryName(ccode, "V")%></h3>
			<!--<p class="location">관리자페이지 &gt; 콘텐츠 관리 &gt; <span><%=mtitle%> 등록</span></p>-->
			<div id="content">
		 
			<p class="title_dot01">콘텐츠 정보 입력 <span class="font_11r"> (*) 필수 입력항목 입니다.</span></p>
				<table cellspacing="0" class="board_view" summary="<%=mtitle%> 등록">
				<caption><%=mtitle%> 등록</caption>
				<colgroup>
					<col width="20%" class="back_f7"/>
					<col width="35%"/>
					<col width="20%" class="back_f7"/>
					<col width="25%"/>
				</colgroup>
				<tbody>
				<form name='frmMedia' method='post' enctype="multipart/form-data">
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
				 
				   <tr>
						<td class="bor_bottom01 right_border" colspan="4" align="center" >
								
							<div id="media_player">
							<div id='errorLocation' style="font-size: small;color: Gray;"></div>
							<%
							if(info.getIsended() == 1){
							%>
							<div><iframe id="bestVod" name="bestVod" src="/silverPlayer_thumbnail.jsp?ocode=<%=ocode%>" scrolling='no' width="750" height="550" marginwidth='0' frameborder='0' framespacing='0' ></iframe></div>
							<%}%>
							</div>
							<div id="img_panel"></div>
						</td>
					</tr>
<%--					
					 	<tr class="height_25">
						<th class="bor_bottom01"><strong>대표이미지</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
							<table class="thumnailList" cellspacing="0" summary="썸네일수정">
							<tbody>
							<tr>
								<%
                                     
								Vector img_vector = mgr.getMediaImages(ocode); 
                                 for (int i=0; i < img_vector.size(); i++) {
                                	  String img_time = String.valueOf(((Vector)img_vector.elementAt(i)).elementAt(3));  // 시간
                                      String img_url = DirectoryNameManager.SILVERLIGHT_SERVERNAME+"/ClientBin/Media/"+info.getSubfolder()+"/thumbnail/"+ String.valueOf(((Vector)img_vector.elementAt(i)).elementAt(1));  // 이미지파일
                              %>
											<td><img src="<%=img_url%>" width="120px;"/> <span> <input type='radio' name='main_img'  onClick='go_main_img(this.value);' value='<%=String.valueOf(((Vector)img_vector.elementAt(i)).elementAt(1))%>' 
											<%if (img_url.indexOf(info.getModelimage()) > 0 ) {out.println("checked");} %> /><label for="thumnail1"><%=img_time%></label> </span></td>
									<% if ( i != 0 && (i+1) % 5 == 0) {out.println("</tr><tr>");} %>
								 <%
									 }
								 %>
							</tr>
							</tbody>
							</table>
							
						</td>
					</tr>
 --%>					
					<%
					if (info.getCcode() != null && info.getCcode().equals("007000000000")) 
					{
 
							EventManager event_user = EventManager.getInstance();
							Vector event_user_vt = event_user.getUserInfo(info.getOcode(),"0");
							if (event_user_vt != null && event_user_vt.size() > 0) 
							{ %>
								<tr class="height_25">
									<th class="bor_bottom01"><strong>연락처</strong></th>
									<td class="bor_bottom01 pa_left">
									<%=SEEDUtil.getDecrypt(event_user_vt.elementAt(4).toString()) %>
									</td>
									<th class="bor_bottom01"><strong>이메일</strong></th>
									<td class="bor_bottom01 pa_left">
									<%=SEEDUtil.getDecrypt(event_user_vt.elementAt(5).toString()) %>
									</td>
								</tr>
						<%
							}
					}%>
					<tr class="height_25">
						<th class="bor_bottom01"><strong>제목 (*)</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="text" name="title" value="<%=info.getTitle() %>" class="input01" style="width:600px;"/></td>
					</tr>
					<tr class="height_25">
	 					
						<th class="bor_bottom01"><strong>카테고리 선택 (*)</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<select id="ccategory1" name="ccategory1" class="sec01" style="width:125px;" onchange="javascript:setCcode(document.frmMedia, this.value); refreshCategoryList('V', this.value, 'B', 'ccategory2');">
							<option value="">--- 대분류 선택 ---</option>
						</select>
	
						<select id="ccategory2" name="ccategory2" class="sec01" style="width:125px;" onchange="javascript:setCcode(document.frmMedia, this.value);refreshCategoryList('V', this.value, 'C', 'ccategory3');">
							<option value="">--- 중분류 선택 ---</option>
						</select>
	 
						<select id="ccategory3" name="ccategory3" class="sec01" style="width:125px;" onchange="javascript:setCcode(document.frmMedia, this.value);">
							<option value="">--- 소분류 선택 ---</option>
						</select>
<!-- 						<select id="ccategory4" name="ccategory4" class="sec01" style="width:125px;" onchange="javascript:setCcode(document.frmMedia, this.value);"> -->
<!-- 							<option value="">--- 세분류 선택 ---</option> -->
<!-- 						</select> -->
 
						</td>

					</tr>
					<tr class="height_25">
					
						<th class="bor_bottom01"><strong>프로그램 구분</strong></th>
						<td class="bor_bottom01 pa_left" >
						<select id="vcategory1" name="vcategory1" class="sec01" style="width:125px;" onchange="javascript:setCcodeY(document.frmMedia, this.value); refreshCategoryListV('Y', this.value, 'B', 'vcategory2');">
						<option value="">--- 대분류 선택 ---</option>
						</select>
						 
						<select id="vcategory2" name="vcategory2" class="sec01" style="width:125px;" onchange="javascript:setCcodeY(document.frmMedia, this.value);">
							<option value="">--- 중분류 선택 ---</option>
						</select>
							
						</td>
						<th class="bor_bottom01"><strong>작성자 (*)</strong></th>
						<td class="bor_bottom01 pa_left" >
 						<%=info.getOwnerid() %>
						</td>
						
					</tr>
				
					
					
					<tr class="height_25">
						<th class="bor_bottom01"><strong>분야 선택</strong></th>
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
						<th class="bor_bottom01"><strong>웹공개구분</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio" name="openflag"  value="Y" <%if(info.getOpenflag().equals("Y")) { out.println("checked='checked'");}%> /> 공개&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="openflag" value="N"  <%if(info.getOpenflag().equals("N")) { out.println("checked='checked'");}%>/> 비공개
					    </td>
						<th class="bor_bottom01"><strong>모바일공개구분</strong></th>
						 
						<td class="bor_bottom01 pa_left"><input type="radio" name="openflag_mobile"  value="Y"  <%if(info.getOpenflag_mobile().equals("Y")) { out.println("checked='checked'");}%>/> 공개&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="openflag_mobile"  value="N" <%if(info.getOpenflag_mobile().equals("N")) { out.println("checked='checked'");}%>/> 비공개
					    </td>
					</tr>
					 
					 <tr class="height_25">
						<th class="bor_bottom01"><strong>간략설명 (*)</strong>
						</br>100자 내외
						</th>
						<td class="bor_bottom01 pa_left" colspan="3">
					 
						<textarea name="content_simple" id="content_simple" style="width:620px;height:80px;" cols="100" rows="60"><%=info.getContent_simple()%></textarea>
						</td>
					</tr> 
					
					<tr>
						<th class="bor_bottom01"><strong>내용 (*)</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3" >
						<textarea name="description" id="description" style="width:620px;height:293px; display:none;" cols="100" rows="10" ><%=info.getDescription()%></textarea>
								<script type="text/javascript">
									var oEditors = [];
									nhn.husky.EZCreator.createInIFrame({
									    oAppRef: oEditors,
									    elPlaceHolder: "description",
									    sSkinURI: "/vodman/editer/SmartEditor2Skin.html",
									    fCreator: "createSEditor2"
									});
							
									function insertIMG(qnacontent,filename){ 
								        var sHTML = "<img src=/vodman/editer/popup/upload/"+filename+">"; 
								        oEditors.getById["description"].exec("PASTE_HTML", [sHTML]); 
									} 
								</script>
						</td>
					</tr>
					
					<tr class="height_25">
 
						<th class="bor_bottom01"><strong>등록일자</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<input type="text" name="mk_date" value="<%=info.getMk_date()%>" class="input01" style="width:70px;"/>&nbsp;<a href="javascript:openCalendarWindow(document.frmMedia.mk_date);" title="찾아보기"><img src="/vodman/include/images/icon_calender.gif" alt="찾아보기"/></a>
						</td>
					</tr>
					
					<tr class="height_25">
						<th class="bor_bottom01"><strong>퍼가기  여부 </strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="radio" name="linkcopy_flag"  value="Y"  <%if(info.getLinkcopy_flag().equals("Y")) { out.println("checked='checked'");}%>/> 허용&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="linkcopy_flag"  value="N"  <%if(info.getLinkcopy_flag().equals("N")) { out.println("checked='checked'");}%>/> 비허용</td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01"><strong>다운로드 여부 </strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="radio" name="download_flag"  value="Y" <%if(info.getDownload_flag().equals("Y")) { out.println("checked='checked'");}%>/> 허용&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="download_flag"  value="N"  <%if(info.getDownload_flag().equals("N")) { out.println("checked='checked'");}%>/> 비허용</td>
					</tr>
	 
					<tr class="height_25">
						<th class="bor_bottom01"><strong>첨부파일</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="file" id="attach_file" name="attach_file" class="sec01" size="40" value="" onchange="javascript:limitFile('attach_file')" />
						<% if (info.getAttach_file() != null && info.getAttach_file().indexOf(".") > 1) { %> <p style="margin-left:5px; margin-top: 3px;">
						<a href="attach_download.jsp?ocode=<%=info.getOcode()%>">
						<%if (info.getOrg_attach_file() != null && info.getOrg_attach_file().length() > 0) { out.println(info.getOrg_attach_file()); } else {out.println(info.getAttach_file());} %>
						</a>
						삭제 <input type="checkbox" name="attach_file_del" value="Y" /></p><%} %> 
					    </td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01"><strong>파일 다운로드 </strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<%
						String sourcefile_url = DirectoryNameManager.SILVERLIGHT_SERVERNAME+"/ClientBin/Media/"+info.getSubfolder()+"/Medium/"+info.getMediumfilename();
						String mp4file_url = DirectoryNameManager.SILVERLIGHT_SERVERNAME+"/ClientBin/Media/"+info.getSubfolder()+"/Encoded/"+info.getEncodedfilename();
						%>
						<a href="<%=sourcefile_url%>">* 일반화질 다운로드 <br/> <%=sourcefile_url%> </a> <br/>
						<%
						if(info.getEncodedfilename() != null && info.getEncodedfilename().length()>4){
						%>
						<a href="<%=mp4file_url%>">* 고화질 다운로드 <br/> <%=mp4file_url%></a>
						<%}%>
						</td>
					</tr>
					</form>
				</tbody>
				</table>
				<div class="but01">
		 
                    <a href="javascript:memo_comment('<%=ocode%>');"><img src="/vodman/include/images/but_reply.gif" border="0"></a>
					 
					<a href="frm_AddNewContent.jsp?ocode=<%=ocode %>&ccode=<%=ccode%>&mcode=<%=mcode%>" title="영상교체"><img src='/vodman/include/images/btn_vodChange.gif' alt='영상 교체'/></a>
					<a href="javascript:start_insert();" title="확인"><img src="/vodman/include/images/but_ok3.gif" alt="확인"/></a>
					<a href="javascript:history.go(-1);" title="취소"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
				</div>	
			</div>
		</div>
 
<IFRAME name="hiddenFrame" src="#" height="0" width="0" frameborder="0"></IFRAME>
<%@ include file="/vodman/include/footer.jsp"%>	

