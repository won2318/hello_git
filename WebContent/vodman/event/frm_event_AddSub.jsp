<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.yundara.util.*, com.vodcaster.sqlbean.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%

if(!chk_auth(vod_id, vod_level, "p_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author ����
	 *
	 * description : ��Ʈ ���.
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
            alert("������ �Է����ּ���.");
            form.title.focus();
            return ;
        }

		if(!form.rstime1.value || !form.rstime2.value ||!form.rstime3.value || !form.rstime4.value || !form.rstime5.value) {
			alert("�����Ͻø� �Է����ּ���.");
			form.rstime1.focus();
			return ;
		} else {
			var rstime = form.rstime1.value +"-" + form.rstime2.value +"-"+ form.rstime3.value +" "+ form.rstime4.value +":"+ form.rstime5.value;
			form.sdate.value=rstime;
		}
	
		if(!form.retime1.value || !form.retime2.value ||!form.retime3.value || !form.retime4.value || !form.retime5.value) {
			alert("�����Ͻø� �Է����ּ���.");
			form.retime1.focus();
			return ;
		} else {
			var retime = form.retime1.value  +"-" + form.retime2.value  +"-" +form.retime3.value  +" " + form.retime4.value  +":" + form.retime5.value;
			form.edate.value=retime;
		}

		if(!form.pubtime1.value || !form.pubtime2.value ||!form.pubtime3.value ) {
			alert("��ǥ�Ͻø� �Է����ּ���.");
			form.pubtime1.focus();
			return ;
		} else {
			var pubtime = form.pubtime1.value  +"-" + form.pubtime2.value  +"-" +form.pubtime3.value;
			form.pubdate.value=pubtime;
		}
		
 
 		
		if(confirm("�����Ͻðڽ��ϱ�?")) {
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

function getFileSize(path,name) {
		var img = new Image();
		img.dynsrc = path;
		var filesize =img.fileSize;
		if (filesize > 1024*1024*10) {
			alert('�����Ͻ� ������ �뷮�� 1Mbyte �� �ѽ��ϴ� \n 1Mbyte ���Ϸ� �����ϼ���.');
			
				document.frmMedia.oimagefile1.outerHTML = document.frmMedia.oimagefile1.outerHTML;
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
	    } else if ( !((src.toLowerCase() == "bmp") ||(src.toLowerCase() == "gif") || (src.toLowerCase() == "jpg") || (src.toLowerCase() == "jpeg")) ) {
	        alert('gif, jpg, bmp ���ϸ� �����մϴ�.');
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

		  var re=true; //�⺻�� true

		  for(i=0;i<ojbstrlen;i++){
		   //�������� �� �ʿ��� ����������

		  //�ѱ�&�Ϻ���� +2   
		   onechar=objstr.charAt(i);
		   if(escape(onechar).length>4){
		    bytesize+=2;//�ѱ� �Ϻ��� 2����Ʈ
		   }else{
		    bytesize++;
		   }
		   if(bytesize<=maxlen){

		    strlen=i+1; 
		   }
		   //Ư����������

		 // var keyCode; 
		   //keyCode = objstr.charCodeAt(i);
		   //if((keyCode>=32 && keyCode<48) || (keyCode>57 && keyCode <65) || (keyCode>90 &&   keyCode<96) ||keyCode == 124 ||keyCode == 96 ||keyCode==123 || keyCode==125)
		  // {
		    //alert("??");   
		    //re=false;
		    //objname.value=''; //�ʱ�ȭ

		     //break; // break�� ���ϸ� Ư�����ڰ� 3�������� alertâ�� 3���� ��

		    //   }


		  }//for����

		 if(bytesize>maxlen){
		   alert("�ؽ�Ʈ �Է� ���� �ʰ� �ѱ�"+maxlength/2+"��, ����"+maxlength+"�� ���Ϸ� �����ּ���.");
		   objstr2=objstr.substr(0,strlen);
		   objname.value=objstr2;   
		   re = false;
		  }
		  objname.focus();
		  return re;
		 }	
	</script>
<%@ include file="/vodman/event/event_left.jsp"%>
		<!-- ������ -->
		<div id="contents">
			<h3><span>�̺�Ʈ</span> ����</h3>
			<p class="location">������������ &gt; �̺�Ʈ���� &gt; <span>�̺�Ʈ ����</span></p>
			<div id="content">
			<form name='frmMedia' method='post' action="proc_event_AddSub.jsp"  enctype="multipart/form-data">
			<input type="hidden" name="sdate" value="" />
			<input type="hidden" name="edate" value="" />
			<input type="hidden" name="pubdate" value="" />
			

				<table cellspacing="0" class="board_view" summary="�̺�Ʈ ����">
				<caption>�̺�Ʈ ����</caption>
				<colgroup>
					<col width="15%" class="back_f7"/>
					<col/>
				</colgroup>
				<tbody class="bor_top03" >
				 
					
					<tr>
						<th class="bor_bottom01"><strong>����</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="title" maxlength="100" value="" class="input01" style="width:500px;"  onkeyup="checkLength(this,100)"/></td>
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

					<tr>
						<th class="bor_bottom01 back_f7"><strong>��÷�ڹ�ǥ</strong></th>
						<td class="bor_bottom01 pa_left">
						<input type="text" name="pubtime1" maxlength='4' value="" class="input01" style="width:30px;" onFocus="this.select();" onKeyUp="return autoTab(this, 4, event);" readonly="readonly"/>��&nbsp;
						<input type="text" name="pubtime2" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" readonly="readonly"/>��&nbsp;
						<input type="text" name="pubtime3" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" readonly="readonly"/>��&nbsp;
					 
						<img src="/vodman/include/images/but_seek.gif" alt="ã�ƺ���" onClick="window.open('calendar.jsp?mode=3','','width=200,height=180,scrollbars=0,statusbar=0')" />
						</td>
					</tr>

 
					<tr>
						<th class="bor_bottom01"><strong>�����ڼ�</strong></th>
						<td class="bor_bottom01 pa_left">
						<input type="text" name="people_cnt" maxlength="5" value="" class="input01" style="width:50px;" onkeyup="checkLength(this,50)" onKeyDown="onlyNumber(this);" onblur="maxNumber(this,2);" />
						* �̺�Ʈ ������ ���� �Է��ϼ��� 0 �ϰ�� �ο� ������ �����ϴ�.</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>��������</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio"  name="open_flag"  value="Y" checked="checked" /> ����&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="open_flag"  value="N"/> �����</td>
					</tr>
				
					<tr>
						<th class="bor_bottom01"><strong>�̺�Ʈ ����</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio"  name="event_type"  value="U" checked="checked" /> UCC&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="event_type"  value="P"/> ����&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="event_type"  value="A"/> UCC+����</td>
					</tr>
				 
					<tr>
						<th class="bor_bottom01"><strong>����</strong></th>
						<td class="bor_bottom01 pa_left"><textarea name="content" class="input01" style="width:500px;height:50px;" cols="100" rows="100"></textarea></td>
					</tr>
					 
					<tr>
						<th><strong>�̹�������</strong></th>
						<td class="pa_left"><input type="file" name="event_img" class="sec01" size="50" onchange="uploadImg_Change( this.value )" >
						</td>
					</tr>
					<tr>
						<th><strong>÷������</strong></th>
						<td class="pa_left"><input type="file" name="list_data_file" class="sec01" size="50" onchange="javascript:limitFile(this)" >
						</td>
					</tr>
					
				 
				</tbody>
				</table>
				</form>
				<p class="height_5"></p>
				
				<div class="but01">
					 
					<a href="javascript:chkForm(document.frmMedia);" title="����"><img src="/vodman/include/images/but_save.gif" alt="����"/></a>
					<a href="javascript:frmMedia.reset();" title="���"><img src="/vodman/include/images/but_cancel.gif" alt="���"/></a>
					 
				</div>	
				<br/><br/>
			</div>
		</div>	
<%@ include file="/vodman/include/footer.jsp"%>