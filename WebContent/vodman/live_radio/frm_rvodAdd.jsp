<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>

<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "r_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
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
	  
	   alert("�Է��Ͻ� ������ ���ε� �� �� �����ϴ�!");
	    document.frmMedia.rfilename.outerHTML = document.frmMedia.rfilename.outerHTML;
	   return;
	  }
 }



    function chkForm(form) {

		if(form.rtitle.value == "") {
			alert("������ �Է����ּ���.");
			form.rtitle.focus();
			return ;
		}
		if(form.ralias.value == "") {
			alert("����� ��û ä���� �Է����ּ���.");
			form.ralias.focus();
			return ;
		} 
		if(!form.rstime1.value || !form.rstime2.value ||!form.rstime3.value || !form.rstime4.value || !form.rstime5.value) {
			alert("�����Ͻø� �Է����ּ���.");
			form.rstime1.focus();
			return ;
		} else {
			var rstime = form.rstime1.value +"-" + form.rstime2.value +"-"+ form.rstime3.value +" "+ form.rstime4.value +":"+ form.rstime5.value;
			form.rstart_time.value=rstime;
		}
	
		if(!form.retime1.value || !form.retime2.value ||!form.retime3.value || !form.retime4.value || !form.retime5.value) {
			alert("�����Ͻø� �Է����ּ���.");
			form.retime1.focus();
			return ;
		} else {
			var retime = form.retime1.value  +"-" + form.retime2.value  +"-" +form.retime3.value  +" " + form.retime4.value  +":" + form.retime5.value;
			form.rend_time.value=retime;
		}

		var start_date = form.rstime1.value*12*31*24*60 +form.rstime2.value* 31 *24*60 + form.rstime3.value* 24*60 + form.rstime4.value*60 + form.rstime5.value ;
		var end_date = form.retime1.value*12*31*24*60 + form.retime2.value* 31 *24*60 + form.retime3.value* 24*60 + form.retime4.value*60 + form.retime5.value ;

		if (start_date > end_date) {
			alert("�����Ͻð� �����Ͻú��� �۾ƾ� �մϴ�.");
			return;
		 }
		 
		if(form.rbcast_time.value == "") {
			alert("��۽ð��� �Է����ּ���.");
			form.rbcast_time.focus();
			return ;
		}

		if(confirm("�����Ͻðڽ��ϱ�?")) {
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
			alert('�����Ͻ� ������ �뷮�� 1Mbyte �� �ѽ��ϴ� \n 1Mbyte ���Ϸ� �����ϼ���.');
			
				document.frmMedia.rimagefile.outerHTML = document.frmMedia.rimagefile.outerHTML;
		}
	}

</script>
<script>
	
	//������ Ȯ���ڸ� ������
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
	
	
	//������ ���� �� ��Ŀ�� �̵��� ȣ��
	function uploadImg_Change( value )
	{
	
	    var src = getFileExtension(value);
	    if (src == "") {
	        alert('�ùٸ� ������ �Է��ϼ���');
	        return;
	    } else if ( !((src.toLowerCase() == "gif") || (src.toLowerCase() == "jpg") || (src.toLowerCase() == "jpeg")) ) {
	        alert('gif �� jpg ���ϸ� �����մϴ�.');
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
	        alert('�׸������� ������ �� �����ϴ�.');
	        return;
	    } 
//	 alert(imgFileSize);
//	     alert(imgWidth);
//	      alert(imgHeight);
	    if (imgFileSize > maxFileSize)
	    {
	        alert('�����Ͻ� �׸� ������ ��� �ִ�ũ���� ' + maxFileSize/1024 + ' KB �� �ʰ��Ͽ����ϴ�.');
	        document.frmMedia.reset();
	        return;
	    } 
	
	    //�̹��� ������ ���� 
	    document.all.imgWidth.value = imgWidth;
	    document.all.imgHeight.value = imgHeight;
	
	}

	function maxNumber(obj,flag) {
		if(flag == 1) {
			if(obj.value >= 24 ||obj.value < 0) {
				alert("�ð��� 00�ú��� 23�ñ����� �Է��� �� �ֽ��ϴ�.")
				obj.value="";
				obj.focus();
				return;
			}
		}
		if(flag == 2) {
			if(obj.value >= 60 ||obj.value < 0) {
				alert("���� 00�к��� 59�б����� �Է��� �� �ֽ��ϴ�.")
				obj.value="";
				obj.focus();
				return;
			}
		}
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

	</script>

<%@ include file="/vodman/live_radio/radio_left.jsp"%>
		<!-- ������ -->
		<div id="contents">
			<h3><span>���̴� ����</span> ���</h3>
			<p class="location">������������ &gt; ���̴� ����  &gt; <span>���̴� ���� ���</span></p>
			<div id="content">
				<!-- ���� -->
				<form name='frmMedia' method='post' action="proc_Live_Add.jsp" enctype="multipart/form-data">
				<input type="hidden" name="rflag" value="<%=rflag%>" />  
				<input type="hidden" name="rstart_time" value="" />
				<input type="hidden" name="rend_time" value="" />
				<input type="hidden" name="inoutflag" value="Y">
				<table cellspacing="0" class="board_view" summary="��õVOD">
				<caption>��õVOD</caption>
				<colgroup>
					<col width="15%"/>
					<col/>
				</colgroup>
				<tbody class="bor_top03">
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>����</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="rtitle" maxlength="200" value="" class="input01" style="width:500px;" onkeyup="checkLength(this,200)" /></td>
					</tr>
					<%--
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>���ܺο�</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio" name="inoutflag"  value="Y" checked="checked" /> ���ο�&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="inoutflag"  value="N" /> ���ܺο�</td>
					</tr>
					--%>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>����</strong></th>
						<td class="bor_bottom01 pa_left"><textarea name="rcontents" class="input01" style="width:600px;height:50px;" cols="100" rows="100" onkeyup="checkLength(this,2000)" ></textarea></td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7" rowspan="2"><strong>ä��</strong></th>
						<td class="bor_bottom01 pa_left">WEB <input type="text" name="ralias" maxlength="100" value="" class="input01" style="width:350px;" onkeyup="checkLength(this,100)"/> <br/> ��) /live/live.stream</td>
					</tr>
					<tr>
						<td class="bor_bottom01 pa_left">MOBILE <input type="text" name="mobile_stream" maxlength="100" value="" class="input01" style="width:350px;" onkeyup="checkLength(this,100)"/> <br/> ��) /live/live.stream </td>
					</tr>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>�����Ͻ�</strong></th>
						<td class="bor_bottom01 pa_left">
						<input type="text" name="rstime1" maxlength='4' value="" class="input01" style="width:30px;" onFocus="this.select();" onKeyUp="return autoTab(this, 4, event);" readonly="readonly"/>��&nbsp;
						<input type="text" name="rstime2" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" readonly="readonly"/>��&nbsp;
						<input type="text" name="rstime3" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" readonly="readonly"/>��&nbsp;
						<input type="text" name="rstime4" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);"  onKeyDown="onlyNumber(this);" onblur="maxNumber(this,1);" />��&nbsp;
						<input type="text" name="rstime5" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);"  onKeyDown="onlyNumber(this);" onblur="maxNumber(this,2);" />��&nbsp;
						<img src="/vodman/include/images/but_seek.gif" alt="ã�ƺ���" onClick="window.open('calendar.jsp?mode=1','','width=200,height=180,scrollbars=0,statusbar=0')" />
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>�����Ͻ�</strong></th>
						<td class="bor_bottom01 pa_left">
						<input type="text" name="retime1" maxlength='4' value="" class="input01" style="width:30px;" onFocus="this.select();" onKeyUp="return autoTab(this, 4, event);" readonly="readonly"/>��&nbsp;
						<input type="text" name="retime2" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" readonly="readonly"/>��&nbsp;
						<input type="text" name="retime3" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" readonly="readonly"/>��&nbsp;
						<input type="text" name="retime4" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);"  onKeyDown="onlyNumber(this);" onblur="maxNumber(this,1);" />��&nbsp;
						<input type="text" name="retime5" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();"  onKeyDown="onlyNumber(this);" onblur="maxNumber(this,2);" />��&nbsp;
						<img src="/vodman/include/images/but_seek.gif" alt="ã�ƺ���" onClick="window.open('calendar.jsp?mode=2','','width=200,height=180,scrollbars=0,statusbar=0')" />
						</td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>��۽ð�</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="rbcast_time" maxlength="30" value="" class="input01" style="width:500px;"  onkeyup="checkLength(this,30)" /></td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>��������</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio" name="openflag"  value="Y" checked="checked" /> ����&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="openflag"  value="N" /> �����</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>���ٱ���</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="rlevel" class="sec01" style="width:130px;">
								<option value="0">��ü</option>
								<option value="1">�α��� ȸ��</option>
							</select>
						</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>�����</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="rid" maxlength="14" value="" class="input01" style="width:300px;" onkeyup="checkLength(this,14)" /></td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>�̹�������</strong></th>
						<td class="bor_bottom01 pa_left">
							<input type="file" id="rimagefile" name="rimagefile" class="sec01" size="30" value="" />
						</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>÷������</strong></th>
						<td class="bor_bottom01 pa_left"><input type="file" id="rfilename" name="rfilename" class="sec01" size="30" value="" onchange="javascript:limitFile()" /></td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="but01">
							<a href="javascript:javascript:chkForm(document.frmMedia);"><img src="/vodman/include/images/but_save.gif" alt="����"/></a>
							<a href="mng_vodRealList.jsp?mcode=<%=mcode%>"><img src="/vodman/include/images/but_cancel.gif" alt="���"/></a>
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
		