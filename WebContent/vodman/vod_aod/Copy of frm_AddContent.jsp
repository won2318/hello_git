<%--
date   : 2007-07-04
작성자 : 주현
내용   : vod 등록  

	openflag - 공개, 비공개
	user_id, user_pwd - 등록자 아이디, 등록 비밀번호

--%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>

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
//	 VOD로 초기화
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
 
%>
<%@ include file="/vodman/include/top.jsp"%>
<script language="javascript" src="/vodman/include/js/script.js"></script>
<script language="javascript" src="/vodman/include/js/viewer.js"></script>
<script type="text/javascript" src="/vodman/editer2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script language="javascript" src="/vodman/include/js/ajax_category_select2.js"></script>
<script language="javascript">
// 대분류 카테고리 불러오기 (ajax_category_select.js)
//ctype, param, info,target
 
		window.onload = function() {
			refreshCategoryList_A('V', '', 'A', '<%=ccode%>');
			refreshCategoryList_B('V', '', 'B', '<%=ccode%>');
			refreshCategoryList_C('V', '', 'C', '<%=ccode%>');
			refreshCategoryList_D('V', '', 'D', '<%=ccode%>');
			
			refreshCategoryList_AV('Y', '', 'A', '');
			refreshCategoryList_BV('Y', '', 'B', '');

		}
		
		
		function setCcode(form, val) {
			form.ccode.value = val;
		}
		function setCcodeY(form, val) {
			form.ycode.value = val;
		}

		<%
		FucksInfoManager mgr = FucksInfoManager.getInstance();
		Hashtable result_ht = null;
		result_ht = mgr.getAllFucks_admin("");
		Vector vt = null;
		com.yundara.util.PageBean pageBean = null;
		int totalArticle =0; //총 레코드 갯수
		int totalPage = 0 ; //
		if(!result_ht.isEmpty() ) {
		    vt = (Vector)result_ht.get("LIST");

			if ( vt != null && vt.size() > 0){
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
		if(vt != null && vt.size()>0){
			int list = 0;
			FuckInfoBean linfo = new FuckInfoBean();
			for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
				  com.yundara.beans.BeanUtils.fill(linfo, (Hashtable)vt.elementAt(list));
				  %>
				  splitFilter[<%=i%>] = '<%=linfo.getFucks()%>';
				  <%
			}
		}
		%>
		function filterIng(str , element , id){  
			for (var ii = 0 ;ii < splitFilter.length ; ii++ )
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
			
			if (f.ccode.value=="") {
				   alert ("카데코리를 입력하지 않으셨습니다.")
				   f.ccode.focus();
				   return
				}
			
			if(filterIng(f.title.value, f.title,"title") == false){
				return;
			}
			
			if(!CheckText(f.title)){
				return;
			}

			oEditors.getById["description"].exec("UPDATE_IR_FIELD", []);
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
			
			
			 
			var vod_img = document.getElementsByName("vod_images2");
			if(vod_img){
				if(vod_img.length > 1){
					for(i=0;i<vod_img.length;i++){
						var txt = document.createElement("input");
						txt.setAttribute("type","hidden");
						txt.setAttribute("id","vod_images"+i);
						txt.setAttribute("name","vod_images");
						txt.setAttribute("value",vod_img[i].value);
						document.forms['frmMedia'].appendChild(txt);
					}
				}
			}else{
				alert('이미지가 등록되지 않았습니다.');
			}
					
			
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
	alert(path);
var pathArray = path.split(":")
			//alert(path);
var ocode = pathArray[3]; // 파일명에서 ocode 구함
ocode = ocode.substring(ocode.lastIndexOf('/')+1,ocode.lastIndexOf('.')); // 파일명에서 ocode 구함
var playtime = pathArray[4];  // 재생시간
var filename = pathArray[3];  // 등록된 파일명
filename = filename.substring(filename.lastIndexOf('/')+1,filename.length);

var modelimage = pathArray[2]; // 대표 이미지
modelimage = (modelimage.substring(modelimage.lastIndexOf('/')+1,modelimage.length));

var encodedfilename = pathArray[0]; // web 인코딩 파일
encodedfilename =(encodedfilename.substring(encodedfilename.lastIndexOf('Encoded/')+8,encodedfilename.legnth));

var subfolder = pathArray[0]; // 폴더경로
subfolder = (subfolder.substring(subfolder.lastIndexOf('Media')+6,subfolder.lastIndexOf('/Encoded')));

var mobilefilename = pathArray[1]; // 모바일 인코딩 파일
mobilefilename = (mobilefilename.substring(mobilefilename.lastIndexOf('Mobile/')+7,mobilefilename.legnth));

			document.getElementById("ocode").value = ocode;
			document.getElementById("playtime").value = playtime;
			document.getElementById("filename").value  = filename;
			document.getElementById("modelimage").value  = modelimage;
			document.getElementById("encodedfilename").value  = encodedfilename;
			document.getElementById("subfolder").value  = subfolder;
			document.getElementById("mobilefilename").value  = mobilefilename;

			if (pathArray.length > 5) {
				document.getElementById("img_panel").innerHTML = "";
 				for (i =5; i < pathArray.length ; i++ )
				{
				 var txt = document.createElement("input");
				 /*
	                txt.type = "text";
	                txt.id = "vod_images" + i;
	                txt.name = "vod_images";
	                txt.value = pathArray[i].substring(pathArray[i].lastIndexOf('/')+1,pathArray[i].length) ;
	                //동적 이벤트 추가
	                //alert( pathArray[i].substring(pathArray[i].lastIndexOf('/')+1,pathArray[i].length));
	                document.getElementById("img_panel").appendChild(txt);
	                */
					document.getElementById("img_panel").appendChild(txt);
					txt.setAttribute("type","hidden");
					txt.setAttribute("id","vod_images2"+i);
					txt.setAttribute("name","vod_images2");
					txt.setAttribute("value",pathArray[i].substring(pathArray[i].lastIndexOf('/')+1,pathArray[i].length));
					

				}
				 //alert(document.getElementsByName("vod_images2").length);
			}
	alert("영상이 업로드 되었습니다. 제목과 내용을 입력후 저장을 눌러 주세요");
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
					<col width="15%" class="back_f7"/>
					<col width="35%"/>
					<col width="15%" class="back_f7"/>
					<col width="35%"/>
				</colgroup>
				<tbody>
				<form name='frmMedia' method='post' enctype="multipart/form-data" id="frmMedia" />
		 		<input type="hidden" id="ocode" name="ocode" value=""/>
				<input type="hidden" name="playtime" id="playtime" value="" />
				<input type="hidden" name="filename" id="filename" value="" />
				<input type="hidden" name="modelimage" id="modelimage" value="" />
				<input type="hidden" name="encodedfilename" id="encodedfilename" value="" />
				<input type="hidden" name="subfolder" id="subfolder" value="" />
				<input type="hidden" id="ccode" name="ccode" value="<%=ccode%>"/>
				<input type="hidden" id="ycode" name="ccode" value=""/>

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
										<param name="initParams" value="returnThumbnails=true, userID=<%=vod_id %>,showFinishButton=false, useMaxFileSizeUcc=false"/>
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
 						<%=vod_name %>
						</td>
						
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01"><strong>제목 (*)</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="text" name="title" value="" class="input01" style="width:600px;"/></td>
					</tr>
					<tr class="height_25">
	 					
						<th class="bor_bottom01"><strong>카테고리 선택 (*)</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<select id="ccategory1" name="ccategory1" class="sec01" style="width:125px;" onchange="javascript:setCcode(document.frmMedia, this.value); refreshCategoryList('V', this.value, 'B', 'ccategory2');">
							<option value="">--- 대분류 선택 ---</option>
						</select>
	
						<select id="ccategory2" name="ccategory2" class="sec01" style="width:125px;" onchange="javascript:setCcode(document.frmMedia, this.value)">
							<option value="">--- 중분류 선택 ---</option>
						</select>
	 
						<select id="ccategory3" name="ccategory3" class="sec01" style="width:125px;" onchange="javascript:setCcode(document.frmMedia, this.value);refreshCategoryList('V', this.value, 'D', 'ccategory4');">
							<option value="">--- 소분류 선택 ---</option>
						</select>
						<select id="ccategory4" name="ccategory4" class="sec01" style="width:125px;" onchange="javascript:setCcode(document.frmMedia, this.value);">
							<option value="">--- 세분류 선택 ---</option>
						</select>
 
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
						<input type="checkbox" name="xcode" value="<%=xinfo.getCcode()%>"/><%=xinfo.getCtitle()%>&nbsp;&nbsp;&nbsp;
						
<%
							 if (cntx % 8 == 0) {out.println("<br/>");}
							} 
						}%>
							
						</td>
					</tr>
					
					
 
					<tr class="height_25">
						<th class="bor_bottom01"><strong>웹공개구분</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio" name="openflag"  value="Y" checked="checked" /> 공개&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="openflag"  value="N"/> 비공개
					    </td>
						<th class="bor_bottom01"><strong>모바일공개구분</strong></th>
						 
						<td class="bor_bottom01 pa_left"><input type="radio" name="openflag_mobile"  value="Y" checked="checked" /> 공개&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="openflag_mobile"  value="N"/> 비공개
					    </td>
					</tr>
					
					<tr class="height_25">
						<th class="bor_bottom01"><strong>간략설명 (*)</strong>
						</br>100자 내외
						</th>
						<td class="bor_bottom01 pa_left" colspan="3">
					 
						<textarea name="content_simple" id="content_simple" style="width:620px;height:80px;" cols="100" rows="60"></textarea>
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>내용 (*)</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<textarea name="description" id="description" style="width:620px;height:300px;" cols="100" rows="60"></textarea>
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
						<input type="text" name="mk_date" value="<%=today%>" class="input01" style="width:70px;"/>&nbsp;<a href="javascript:openCalendarWindow(document.frmMedia.mk_date);" title="찾아보기"><img src="/vodman/include/images/icon_calender.gif" alt="찾아보기"/></a>
						</td>
					</tr>
					
					<tr class="height_25">
						<th class="bor_bottom01"><strong>퍼가기  여부 </strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="radio" name="linkcopy_flag"  value="Y"  checked="checked"/> 허용&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="linkcopy_flag"  value="N" /> 비허용</td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01"><strong>다운로드 여부 </strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="radio" name="download_flag"  value="Y" checked="checked"/> 허용&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="download_flag"  value="N"  /> 비허용</td>
					</tr>
	 
					<tr class="height_25">
						<th class="bor_bottom01"><strong>첨부파일</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><input type="file" id="attach_file" name="attach_file" class="sec01" size="40" value="" onchange="javascript:limitFile('attach_file')" />
						<!-- <p style="margin-left:5px; margin-top: 3px;"> * 웹접근성을 위한 자막 대용으로 텍스트로 된 대본을 첨부</p> -->
					    </td>
					</tr>
					</form>
				</tbody>
				</table>
				<div class="but01">
					<a href="javascript:start_insert();" title="확인"><img src="/vodman/include/images/but_ok3.gif" alt="확인"/></a>
					<a href="javascript:history.go(-1);" title="취소"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
				</div>	
			</div>
		</div>
 
<IFRAME name="hiddenFrame" src="" height="0" width="0" frameborder="0"></IFRAME>
<%@ include file="/vodman/include/footer.jsp"%>	

