<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>

<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "r_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%

	 Calendar cal = Calendar.getInstance();
		int year  = cal.get(Calendar.YEAR),
		    month = cal.get(Calendar.MONTH)+1,
		    date = cal.get(Calendar.DATE);

	String today=year+"-"+month+"-"+date;


	String rflag = request.getParameter("rflag");
	if(rflag == null || rflag.length()<=0 || rflag.equals("null")) rflag = "R";

%>
<%@ include file="/vodman/include/top.jsp"%>
<LINK REL="STYLESHEET" TYPE="text/css" HREF="/vodman/include/calendar/calendar.css">
<script language="JavaScript" src="/vodman/include/calendar/calendar.js" type="text/JavaScript"></script>

<script language="javascript">



function limitFile()
 {
	 var file = document.frmMedia.rfilename.value;
	 
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
	    document.frmMedia.rfilename.outerHTML = document.frmMedia.rfilename.outerHTML;
	   return;
	  }
 }



    function chkForm(form) {

		if(form.rtitle.value == "") {
			alert("제목을 입력해주세요.");
			form.rtitle.focus();
			return ;
		}
		if(form.ralias.value == "") {
			alert("생방송 시청 채널을 입력해주세요.");
			form.ralias.focus();
			return ;
		} 
		if(!form.rstime1.value || !form.rstime2.value ||!form.rstime3.value || !form.rstime4.value || !form.rstime5.value) {
			alert("시작일시를 입력해주세요.");
			form.rstime1.focus();
			return ;
		} else {
			var rstime = form.rstime1.value +"-" + form.rstime2.value +"-"+ form.rstime3.value +" "+ form.rstime4.value +":"+ form.rstime5.value;
			form.rstart_time.value=rstime;
		}
	
		if(!form.retime1.value || !form.retime2.value ||!form.retime3.value || !form.retime4.value || !form.retime5.value) {
			alert("종료일시를 입력해주세요.");
			form.retime1.focus();
			return ;
		} else {
			var retime = form.retime1.value  +"-" + form.retime2.value  +"-" +form.retime3.value  +" " + form.retime4.value  +":" + form.retime5.value;
			form.rend_time.value=retime;
		}

		var start_date = form.rstime1.value*12*31*24*60 +form.rstime2.value* 31 *24*60 + form.rstime3.value* 24*60 + form.rstime4.value*60 + form.rstime5.value ;
		var end_date = form.retime1.value*12*31*24*60 + form.retime2.value* 31 *24*60 + form.retime3.value* 24*60 + form.retime4.value*60 + form.retime5.value ;

		if (start_date > end_date) {
			alert("시작일시가 종료일시보다 작아야 합니다.");
			return;
		 }
		 
		if(form.rbcast_time.value == "") {
			alert("방송시간을 입력해주세요.");
			form.rbcast_time.focus();
			return ;
		}

		if(confirm("저장하시겠습니까?")) {
    		form.submit();
		}
    }


    function textarea_resize(formname,size){
        if(size=='reset'){
            formname.rows=6;
        }else{
            var value=formname.rows+size;
            if(value>0) formname.rows=value
            else return;
        }
    }


    function jsImagesPreview(img,iid) {
        Imagesid = iid;
        if(event.srcElement.value.match(/(.jpg|.jpeg|.gif|.JPG|.JPEG|.GIF|[0-9]{10})/)){
            document.images[Imagesid].src = event.srcElement.value;
            document.images[Imagesid].style.display = "";
        }else{
            if(img) {
                document.images[Imagesid].src = img;
                document.images[Imagesid].style.display = "";
            } else {
                document.images[Imagesid].src = "/vodman/include/images/test_img.jpg";
                document.images[Imagesid].style.display = "";
            }
        }
    }

	function resize_img() { 
        full_image = new Image();
        full_image["src"] = document.media_img.src;
	img_width = full_image["width"];
	img_height = full_image["height"];
	
	var maxDim = 250;
	
	var scale = parseFloat(maxDim)/ parseFloat(img_height);
	if (img_width > img_height)
	    scale = parseFloat(maxDim)/ parseFloat(img_width);
	if (maxDim > img_height && maxDim > img_width) 
	    scale = 1;

	if (scale !=1) {	
		var scaleW = scale * img_width;
		var scaleH = scale * img_height;
	
	        document.media_img.height = scaleH;
	        document.media_img.width = scaleW;
        }
}


function getFileSize(path,name) {
		var img = new Image();
		img.dynsrc = path;
		var filesize =img.fileSize;
		if (filesize > 1000000) {
			alert('선택하신 파일은 용량이 1Mbyte 가 넘습니다 \n 1Mbyte 이하로 선택하세요.');
			
				document.frmMedia.rimagefile.outerHTML = document.frmMedia.rimagefile.outerHTML;
		}
	}

</script>
<script>
	
	//파일의 확장자를 가져옮
	function getFileExtension( filePath )
	{
	    var lastIndex = -1;
	    lastIndex = filePath.lastIndexOf('.');
	    var extension = "";
	
	if ( lastIndex != -1 )
	{
	    extension = filePath.substring( lastIndex+1, filePath.len );
	} else {
	    extension = "";
	}
	    return extension;
	}
	
	
	//파일을 선택 후 포커스 이동시 호출
	function uploadImg_Change( value )
	{
	
	    var src = getFileExtension(value);
	    if (src == "") {
	        alert('올바른 파일을 입력하세요');
	        return;
	    } else if ( !((src.toLowerCase() == "gif") || (src.toLowerCase() == "jpg") || (src.toLowerCase() == "jpeg")) ) {
	        alert('gif 와 jpg 파일만 지원합니다.');
	        return;
	    }
	
	    LoadImg( value);
	
	}
	
	function LoadImg(value)
	{
	    var imgInfo = new Image();
	    imgInfo.onload = img_Load;
	    imgInfo.src = value;
	}
	
	function img_Load()
	{
	    var imgSrc, imgWidth, imgHeight, imgFileSize;
	    var maxFileSize; 
	    maxFileSize = 1048576;
	    imgSrc = this.src;
	    imgWidth = this.width;
	    imgHeight = this.height;
	    imgFileSize = this.fileSize;
	
	    if (imgSrc == "" || imgWidth <= 0 || imgHeight <= 0)
	    {
	        alert('그림파일을 가져올 수 없습니다.');
	        return;
	    } 
//	 alert(imgFileSize);
//	     alert(imgWidth);
//	      alert(imgHeight);
	    if (imgFileSize > maxFileSize)
	    {
	        alert('선택하신 그림 파일은 허용 최대크기인 ' + maxFileSize/1024 + ' KB 를 초과하였습니다.');
	        document.frmMedia.reset();
	        return;
	    } 
	
	    //이미지 사이즈 저장 
	    document.all.imgWidth.value = imgWidth;
	    document.all.imgHeight.value = imgHeight;
	
	}

	function maxNumber(obj,flag) {
		if(flag == 1) {
			if(obj.value >= 24 ||obj.value < 0) {
				alert("시간은 00시부터 23시까지만 입력할 수 있습니다.")
				obj.value="";
				obj.focus();
				return;
			}
		}
		if(flag == 2) {
			if(obj.value >= 60 ||obj.value < 0) {
				alert("분은 00분부터 59분까지만 입력할 수 있습니다.")
				obj.value="";
				obj.focus();
				return;
			}
		}
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

	</script>

<%@ include file="/vodman/live_radio/radio_left.jsp"%>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>보이는 라디오</span> 등록</h3>
			<p class="location">관리자페이지 &gt; 보이는 라디오  &gt; <span>보이는 라디오 등록</span></p>
			<div id="content">
				<!-- 내용 -->
				<form name='frmMedia' method='post' action="proc_Live_Add.jsp" enctype="multipart/form-data">
				<input type="hidden" name="rflag" value="<%=rflag%>" />  
				<input type="hidden" name="rstart_time" value="" />
				<input type="hidden" name="rend_time" value="" />
				<input type="hidden" name="inoutflag" value="Y">
				<table cellspacing="0" class="board_view" summary="추천VOD">
				<caption>추천VOD</caption>
				<colgroup>
					<col width="15%"/>
					<col/>
				</colgroup>
				<tbody class="bor_top03">
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>제목</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="rtitle" maxlength="200" value="" class="input01" style="width:500px;" onkeyup="checkLength(this,200)" /></td>
					</tr>
					<%--
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>내외부용</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio" name="inoutflag"  value="Y" checked="checked" /> 내부용&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="inoutflag"  value="N" /> 내외부용</td>
					</tr>
					--%>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>내용</strong></th>
						<td class="bor_bottom01 pa_left"><textarea name="rcontents" class="input01" style="width:600px;height:50px;" cols="100" rows="100" onkeyup="checkLength(this,2000)" ></textarea></td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7" rowspan="2"><strong>채널</strong></th>
						<td class="bor_bottom01 pa_left">WEB <input type="text" name="ralias" maxlength="100" value="" class="input01" style="width:350px;" onkeyup="checkLength(this,100)"/> <br/> 예) /live/live.stream</td>
					</tr>
					<tr>
						<td class="bor_bottom01 pa_left">MOBILE <input type="text" name="mobile_stream" maxlength="100" value="" class="input01" style="width:350px;" onkeyup="checkLength(this,100)"/> <br/> 예) /live/live.stream </td>
					</tr>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>시작일시</strong></th>
						<td class="bor_bottom01 pa_left">
						<input type="text" name="rstime1" maxlength='4' value="" class="input01" style="width:30px;" onFocus="this.select();" onKeyUp="return autoTab(this, 4, event);" readonly="readonly"/>년&nbsp;
						<input type="text" name="rstime2" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" readonly="readonly"/>월&nbsp;
						<input type="text" name="rstime3" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" readonly="readonly"/>일&nbsp;
						<input type="text" name="rstime4" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);"  onKeyDown="onlyNumber(this);" onblur="maxNumber(this,1);" />시&nbsp;
						<input type="text" name="rstime5" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);"  onKeyDown="onlyNumber(this);" onblur="maxNumber(this,2);" />분&nbsp;
						<img src="/vodman/include/images/but_seek.gif" alt="찾아보기" onClick="window.open('calendar.jsp?mode=1','','width=200,height=180,scrollbars=0,statusbar=0')" />
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>종료일시</strong></th>
						<td class="bor_bottom01 pa_left">
						<input type="text" name="retime1" maxlength='4' value="" class="input01" style="width:30px;" onFocus="this.select();" onKeyUp="return autoTab(this, 4, event);" readonly="readonly"/>년&nbsp;
						<input type="text" name="retime2" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" readonly="readonly"/>월&nbsp;
						<input type="text" name="retime3" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" readonly="readonly"/>일&nbsp;
						<input type="text" name="retime4" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);"  onKeyDown="onlyNumber(this);" onblur="maxNumber(this,1);" />시&nbsp;
						<input type="text" name="retime5" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();"  onKeyDown="onlyNumber(this);" onblur="maxNumber(this,2);" />분&nbsp;
						<img src="/vodman/include/images/but_seek.gif" alt="찾아보기" onClick="window.open('calendar.jsp?mode=2','','width=200,height=180,scrollbars=0,statusbar=0')" />
						</td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>방송시간</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="rbcast_time" maxlength="30" value="" class="input01" style="width:500px;"  onkeyup="checkLength(this,30)" /></td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>공개구분</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio" name="openflag"  value="Y" checked="checked" /> 공개&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="openflag"  value="N" /> 비공개</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>접근권한</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="rlevel" class="sec01" style="width:130px;">
								<option value="0">전체</option>
								<option value="1">로그인 회원</option>
							</select>
						</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>강사명</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="rid" maxlength="14" value="" class="input01" style="width:300px;" onkeyup="checkLength(this,14)" /></td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>이미지파일</strong></th>
						<td class="bor_bottom01 pa_left">
							<input type="file" id="rimagefile" name="rimagefile" class="sec01" size="30" value="" />
						</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>첨부파일</strong></th>
						<td class="bor_bottom01 pa_left"><input type="file" id="rfilename" name="rfilename" class="sec01" size="30" value="" onchange="javascript:limitFile()" /></td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="but01">
							<a href="javascript:javascript:chkForm(document.frmMedia);"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
							<a href="mng_vodRealList.jsp?mcode=<%=mcode%>"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="height_25"></td>
					</tr>
				</tbody>
			</table>
			</form>
			</div>
		</div>

<%@ include file="/vodman/include/footer.jsp"%>	
		