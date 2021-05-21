<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.yundara.util.*, com.vodcaster.sqlbean.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%

if(!chk_auth(vod_id, vod_level, "p_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author 주현
	 *
	 * description : 포트 등록.
	 * date : 2009-10-19
	 */
		String ctype = request.getParameter("ctype");
		if(ctype == null || (ctype != null && ctype.length()<=0))
				ctype = "P";

%>
<%@ include file="/vodman/include/top.jsp"%>
 
<LINK REL="STYLESHEET" TYPE="text/css" HREF="/vodman/include/calendar/calendar.css">
<script language="JavaScript" src="/vodman/include/calendar/calendar.js" type="text/JavaScript"></script>
  
<script language="javascript">

    function chkForm(form) {
 
		if(form.title.value == "") {
            alert("제목을 입력해주세요.");
            form.title.focus();
            return ;
        }

		if(!form.rstime1.value || !form.rstime2.value ||!form.rstime3.value || !form.rstime4.value || !form.rstime5.value) {
			alert("시작일시를 입력해주세요.");
			form.rstime1.focus();
			return ;
		} else {
			var rstime = form.rstime1.value +"-" + form.rstime2.value +"-"+ form.rstime3.value +" "+ form.rstime4.value +":"+ form.rstime5.value;
			form.sdate.value=rstime;
		}
	
		if(!form.retime1.value || !form.retime2.value ||!form.retime3.value || !form.retime4.value || !form.retime5.value) {
			alert("종료일시를 입력해주세요.");
			form.retime1.focus();
			return ;
		} else {
			var retime = form.retime1.value  +"-" + form.retime2.value  +"-" +form.retime3.value  +" " + form.retime4.value  +":" + form.retime5.value;
			form.edate.value=retime;
		}

		if(!form.pubtime1.value || !form.pubtime2.value ||!form.pubtime3.value ) {
			alert("발표일시를 입력해주세요.");
			form.pubtime1.focus();
			return ;
		} else {
			var pubtime = form.pubtime1.value  +"-" + form.pubtime2.value  +"-" +form.pubtime3.value;
			form.pubdate.value=pubtime;
		}
		
 
 		
		if(confirm("저장하시겠습니까?")) {
			form.action="proc_event_AddSub.jsp";
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

function getFileSize(path,name) {
		var img = new Image();
		img.dynsrc = path;
		var filesize =img.fileSize;
		if (filesize > 1024*1024*10) {
			alert('선택하신 파일은 용량이 1Mbyte 가 넘습니다 \n 1Mbyte 이하로 선택하세요.');
			
				document.frmMedia.oimagefile1.outerHTML = document.frmMedia.oimagefile1.outerHTML;
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
	    } else if ( !((src.toLowerCase() == "bmp") ||(src.toLowerCase() == "gif") || (src.toLowerCase() == "jpg") || (src.toLowerCase() == "jpeg")) ) {
	        alert('gif, jpg, bmp 파일만 지원합니다.');
	        return;
	    }
 
	
	}
	  
	function limitFile(object) {
		var file_flag = object.name;
		var file_name = object.value;
	
		document.getElementById('fileFrame').src = "/vodman/board/file_check.jsp?file_flag="+file_flag+"&file_name=" + file_name;
	}
	
	function checkLength(objname,maxlength){
		  var objstr=objname.value;
		  var ojbstrlen=objstr.length;

		  var maxlen=maxlength;
		  var i=0;
		  var bytesize=0;
		  var strlen=0;
		  var onechar="";
		  var objstr2="";

		  var re=true; //기본값 true

		  for(i=0;i<ojbstrlen;i++){
		   //길이제한 이 필요한 사이즈저장

		  //한글&일본어시 +2   
		   onechar=objstr.charAt(i);
		   if(escape(onechar).length>4){
		    bytesize+=2;//한글 일본어 2바이트
		   }else{
		    bytesize++;
		   }
		   if(bytesize<=maxlen){

		    strlen=i+1; 
		   }
		   //특수문자제한

		 // var keyCode; 
		   //keyCode = objstr.charCodeAt(i);
		   //if((keyCode>=32 && keyCode<48) || (keyCode>57 && keyCode <65) || (keyCode>90 &&   keyCode<96) ||keyCode == 124 ||keyCode == 96 ||keyCode==123 || keyCode==125)
		  // {
		    //alert("??");   
		    //re=false;
		    //objname.value=''; //초기화

		     //break; // break을 안하면 특수문자가 3개있으면 alert창이 3개가 뜸

		    //   }


		  }//for문끝

		 if(bytesize>maxlen){
		   alert("텍스트 입력 범위 초과 한글"+maxlength/2+"자, 영문"+maxlength+"자 이하로 적어주세요.");
		   objstr2=objstr.substr(0,strlen);
		   objname.value=objstr2;   
		   re = false;
		  }
		  objname.focus();
		  return re;
		 }	
	</script>
<%@ include file="/vodman/event/event_left.jsp"%>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>이벤트</span> 생성</h3>
			<p class="location">관리자페이지 &gt; 이벤트관리 &gt; <span>이벤트 생성</span></p>
			<div id="content">
			<form name='frmMedia' method='post' action="proc_event_AddSub.jsp"  enctype="multipart/form-data">
			<input type="hidden" name="sdate" value="" />
			<input type="hidden" name="edate" value="" />
			<input type="hidden" name="pubdate" value="" />
			

				<table cellspacing="0" class="board_view" summary="이벤트 생성">
				<caption>이벤트 생성</caption>
				<colgroup>
					<col width="15%" class="back_f7"/>
					<col/>
				</colgroup>
				<tbody class="bor_top03" >
				 
					
					<tr>
						<th class="bor_bottom01"><strong>제목</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="title" maxlength="100" value="" class="input01" style="width:500px;"  onkeyup="checkLength(this,100)"/></td>
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

					<tr>
						<th class="bor_bottom01 back_f7"><strong>당첨자발표</strong></th>
						<td class="bor_bottom01 pa_left">
						<input type="text" name="pubtime1" maxlength='4' value="" class="input01" style="width:30px;" onFocus="this.select();" onKeyUp="return autoTab(this, 4, event);" readonly="readonly"/>년&nbsp;
						<input type="text" name="pubtime2" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" readonly="readonly"/>월&nbsp;
						<input type="text" name="pubtime3" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" readonly="readonly"/>일&nbsp;
					 
						<img src="/vodman/include/images/but_seek.gif" alt="찾아보기" onClick="window.open('calendar.jsp?mode=3','','width=200,height=180,scrollbars=0,statusbar=0')" />
						</td>
					</tr>

 
					<tr>
						<th class="bor_bottom01"><strong>참여자수</strong></th>
						<td class="bor_bottom01 pa_left">
						<input type="text" name="people_cnt" maxlength="5" value="" class="input01" style="width:50px;" onkeyup="checkLength(this,50)" onKeyDown="onlyNumber(this);" onblur="maxNumber(this,2);" />
						* 이벤트 참여자 수를 입력하세요 0 일경우 인원 제한이 없습니다.</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>공개구분</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio"  name="open_flag"  value="Y" checked="checked" /> 공개&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="open_flag"  value="N"/> 비공개</td>
					</tr>
				
					<tr>
						<th class="bor_bottom01"><strong>이벤트 구분</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio"  name="event_type"  value="U" checked="checked" /> UCC&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="event_type"  value="P"/> 사진&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="event_type"  value="A"/> UCC+사진</td>
					</tr>
				 
					<tr>
						<th class="bor_bottom01"><strong>설명</strong></th>
						<td class="bor_bottom01 pa_left"><textarea name="content" class="input01" style="width:500px;height:50px;" cols="100" rows="100"></textarea></td>
					</tr>
					 
					<tr>
						<th><strong>이미지파일</strong></th>
						<td class="pa_left"><input type="file" name="event_img" class="sec01" size="50" onchange="uploadImg_Change( this.value )" >
						</td>
					</tr>
					<tr>
						<th><strong>첨부파일</strong></th>
						<td class="pa_left"><input type="file" name="list_data_file" class="sec01" size="50" onchange="javascript:limitFile(this)" >
						</td>
					</tr>
					
				 
				</tbody>
				</table>
				</form>
				<p class="height_5"></p>
				
				<div class="but01">
					 
					<a href="javascript:chkForm(document.frmMedia);" title="저장"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
					<a href="javascript:frmMedia.reset();" title="취소"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
					 
				</div>	
				<br/><br/>
			</div>
		</div>	
<%@ include file="/vodman/include/footer.jsp"%>