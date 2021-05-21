<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
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
	String rcode = "";
	if(request.getParameter("rcode") == null || request.getParameter("rcode").length()<=0 || request.getParameter("rcode").equals("null")) {
		//out.println("<script lanauage='javascript'>alert('����� ������ �������� �ʽ��ϴ�. ���� �������� �̵��մϴ�.'); history.go(-1); </script>");
		String mcode= request.getParameter("mcode").replaceAll("<","").replaceAll(">","");
		if(mcode == null || mcode.length()<=0 || mcode.equals("null")){
			mcode = "0601";
		}
		out.println("<script lanauage='javascript'>alert('����� ������ �������� �ʽ��ϴ�. ���� �������� �̵��մϴ�.');  </script>");
			String REF_URL="mng_vodRealList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	} else{
		rcode = request.getParameter("rcode").replaceAll("<","").replaceAll(">","");
	}

	String rflag = "L";
	if (request.getParameter("rflag") != null) {
		rflag =request.getParameter("rflag").replaceAll("<","").replaceAll(">","");
	} 

    com.hrlee.sqlbean.LiveManager mgr = com.hrlee.sqlbean.LiveManager.getInstance();
	Vector vt = mgr.getLive(rcode,rflag);
    com.hrlee.sqlbean.LiveInfoBean linfo = new com.hrlee.sqlbean.LiveInfoBean();
	if(vt != null && vt.size()>0){
		try {
			Enumeration e = vt.elements();
			Hashtable ht = (Hashtable)e.nextElement();

			com.yundara.beans.BeanUtils.fill(linfo, ht);

			if(linfo.getRstart_time() != null && linfo.getRstart_time().length()>= 16){
				linfo.setRstime1(linfo.getRstart_time().substring(0,4));
				linfo.setRstime2(linfo.getRstart_time().substring(5,7));
				linfo.setRstime3(linfo.getRstart_time().substring(8,10));
				linfo.setRstime4(linfo.getRstart_time().substring(11,13));
				linfo.setRstime5(linfo.getRstart_time().substring(14,16));
			}
			
			if(linfo.getRend_time() != null && linfo.getRend_time().length()>= 16){
				linfo.setRetime1(linfo.getRend_time().substring(0,4));
				linfo.setRetime2(linfo.getRend_time().substring(5,7));
				linfo.setRetime3(linfo.getRend_time().substring(8,10));
				linfo.setRetime4(linfo.getRend_time().substring(11,13));
				linfo.setRetime5(linfo.getRend_time().substring(14,16));
			}

		} catch (Exception e) {
		out.println("<script lanauage='javascript'>alert('����� ����/���� �Ͻ� �Է��� �ùٸ��� �ʽ��ϴ�. \\n��Ȯ�� �Ͻ� �Է��� ���ֽñ� �ٶ��ϴ�.'); </script>");
		}
	}else{
		String mcode= request.getParameter("mcode").replaceAll("<","").replaceAll(">","");
		if(mcode == null || mcode.length()<=0 || mcode.equals("null")){
			mcode = "0601";
		}
		out.println("<script lanauage='javascript'>alert('����� ������ �������� �ʽ��ϴ�. ���� �������� �̵��մϴ�.');  </script>");
			String REF_URL="mng_vodRealList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	
	String imgFile = "/upload/reserve/"+linfo.getRimagefile();
	DirectoryNameManager Dmanager = new DirectoryNameManager();
	File file = new File(Dmanager.VODROOT+imgFile);
	if(!file.exists()) {
		imgFile = "";
	}
	
	
%>

<%@ include file="/vodman/include/top.jsp"%>

<script language="javascript" src="/vodman/include/script.js"></script>
<LINK REL=STYLESHEET TYPE="text/css" HREF="/vodman/include/calendar/calendar.css">
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

		form.action="proc_Live_update.jsp?mcode=<%=mcode%>&rcode=<%=rcode%>";
	
        form.submit();
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
	function fileDown(){
			document.down.action="download.jsp"
			document.down.submit();
	}
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
	
	
	function img_Load()
	{
	    var imgSrc, imgWidth, imgHeight, imgFileSize;
	    var maxFileSize; 
	    maxFileSize = 20*1024*1024;
	    imgSrc = this.src;
	    imgWidth = this.width;
	    imgHeight = this.height;
	    imgFileSize = this.fileSize;
	
	    if (imgSrc == "" || imgWidth <= 0 || imgHeight <= 0)
	    {
	        alert('�׸������� ������ �� �����ϴ�.');
	        return;
	    } 

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

		
	function del_file(rcode,flag) {
	    if(rcode == "") {
	        alert("�߸��� ��û�Դϴ�.");
	        return false;
	    }
	    window.open("proc_Live_filedel.jsp?mcode=<%=mcode%>&flag=" +flag+ "&rcode=" + rcode, "", "width=400,height=200,scrollbars=0,status=0");
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
	function play_v(ocode){
		//sv_wm_viewer = window.open("view_media.jsp?mid="+mid,"sv_wm_viewer","toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no,width=512,height=384\"");		
		sv_wm_viewer = window.open("/vodman/vod_aod/pop_vod_viewer.jsp?ocode="+ocode,"sv_wm_viewer","toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no,width=480,height=630\"");
		 
		return;
	}

    function sel_vod(ocode, title ,ccode) {	
        if(ocode != "") {
            window.open("pop_best_topList.jsp?target=" + ocode+"&target2="+title+"&ccode="+ccode, "", "width=670,height=600,scrollbars=yes,status=yes");
        }
    }
	function memo_comment(ocode) {
		window.open("/vodman/comment/comment.jsp?ocode="+ocode+"&flag=L","admin_commnet","width=540,height=250,scrolling=none");
	}
	</script>

<%@ include file="/vodman/live/live_left.jsp"%>
		<!-- ������ -->
		<div id="contents">
			<h3><span>�����</span> ����</h3>
			<p class="location">������������ &gt; ����۰��� &gt; <span>����� ����</span></p>
			<div id="content">
				<!-- ���� -->
				<form name='frmMedia' method='post' action="proc_Live_update.jsp" enctype="multipart/form-data">
				<input type="hidden" name="rflag" value="<%=rflag%>">  
				<input type="hidden" name="rstart_time" value="">
				<input type="hidden" name="rend_time" value="">
				<input type="hidden" name="rcode" value="<%=linfo.getRcode()%>">
				 
				<table cellspacing="0" class="board_view" summary="����� ����">
				<caption>����� ����</caption>
				<colgroup>
					<col width="15%"/>
					<col/>
				</colgroup>
				<tbody class="bor_top03">
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>����</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="rtitle" maxlength="200" value="<%=linfo.getRtitle()%>" class="input01" style="width:500px;"  onkeyup="checkLength(this,200)" /></td>
					</tr>
 
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>���ܺο�</strong></th>
						<td class="bor_bottom01 pa_left">
						<input type="radio"  name="inoutflag"  value="Y" <% if (linfo.getInoutflag().equals("Y")) {out.println("checked");} %> /> ���ο�&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio"  name="inoutflag"  value="N" <% if (linfo.getInoutflag().equals("N")) {out.println("checked");} %>/> ���ܺο�&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio"  name="inoutflag"  value="X" <% if (linfo.getInoutflag().equals("X")) {out.println("checked");} %>/> �ܺο�</td>
					</tr>
 
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>����</strong></th>
						<td class="bor_bottom01 pa_left"><textarea name="rcontents" class="input01" style="width:600px;height:50px;" cols="100" rows="100"  onKeyUp="return checkLength(this,2000);" maxlength="2000" ><%=linfo.getRcontents()%></textarea></td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7" rowspan="2"><strong>ä��</strong></th>
						<td class="bor_bottom01 pa_left">WEB <input type="text" name="ralias" maxlength="100" value="<%=linfo.getRalias()%>" class="input01" style="width:350px;" onkeyup="checkLength(this,100)"/> <br/> ��) /live/live.stream</td>
					</tr>
					<tr>
						<td class="bor_bottom01 pa_left">MOBILE <input type="text" name="mobile_stream" maxlength="100" value="<%=linfo.getMobile_stream()%>" class="input01" style="width:350px;" onkeyup="checkLength(this,100)"/> <br/> ��) live/live.stream </td>
					</tr>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>�����Ͻ�</strong></th>
						<td class="bor_bottom01 pa_left">
						<input type="text" name="rstime1" value="<%=linfo.getRstime1()%>" class="input01" style="width:30px;" onFocus="this.select();" onKeyUp="return autoTab(this, 4, event);" onKeyDown="onlyNumber(this);" readonly="readonly"/>��&nbsp;
						<input type="text" name="rstime2" value="<%=linfo.getRstime2()%>" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onKeyDown="onlyNumber(this);" readonly="readonly"/>��&nbsp;
						<input type="text" name="rstime3" value="<%=linfo.getRstime3()%>" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onKeyDown="onlyNumber(this);" readonly="readonly"/>��&nbsp;
						<input type="text" name="rstime4" value="<%=linfo.getRstime4()%>" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);"  onKeyDown="onlyNumber(this);" onblur="maxNumber(this,1);" />��&nbsp;
						<input type="text" name="rstime5" value="<%=linfo.getRstime5()%>" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);"  onKeyDown="onlyNumber(this);" onblur="maxNumber(this,2);" />��&nbsp;
						<img src="/vodman/include/images/but_seek.gif" alt="ã�ƺ���"  onClick="window.open('calendar.jsp?mode=1','','width=200,height=180,scrollbars=0,statusbar=0')" />
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>�����Ͻ�</strong></th>
						<td class="bor_bottom01 pa_left">
						<input type="text" name="retime1" value="<%=linfo.getRetime1()%>" class="input01" style="width:30px;" onFocus="this.select();" onKeyUp="return autoTab(this, 4, event);" onKeyDown="onlyNumber(this);" readonly="readonly"/>��&nbsp;
						<input type="text" name="retime2" value="<%=linfo.getRetime2()%>" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onKeyDown="onlyNumber(this);" readonly="readonly"/>��&nbsp;
						<input type="text" name="retime3" value="<%=linfo.getRetime3()%>" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onKeyDown="onlyNumber(this);" readonly="readonly"/>��&nbsp;
						<input type="text" name="retime4" value="<%=linfo.getRetime4()%>" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onKeyDown="onlyNumber(this);" onblur="maxNumber(this,1);" />��&nbsp;
						<input type="text" name="retime5" value="<%=linfo.getRetime5()%>" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onKeyDown="onlyNumber(this);" onblur="maxNumber(this,2);" />��&nbsp;
						<img src="/vodman/include/images/but_seek.gif" alt="ã�ƺ���" onClick="window.open('calendar.jsp?mode=2','','width=200,height=180,scrollbars=0,statusbar=0')" />
						</td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>��۽ð�</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="rbcast_time" maxlength="30" value="<%=linfo.getRbcast_time()%>" class="input01" style="width:500px;"  onkeyup="checkLength(this,30)" /></td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>��������</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio"  name="openflag"  value="Y" <% if (linfo.getOpenflag().equals("Y")) {out.println("checked");} %> /> ����&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio"  name="openflag"  value="N" <% if (linfo.getOpenflag().equals("N")) {out.println("checked");} %>/> �����</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>���ٱ���</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="rlevel" class="sec01" style="width:130px;">
								<option value="0" <%if(linfo.getRlevel() == 0) {out.println("selected='selected'");}%>>��ü</option>
								<option value="1" <%if(linfo.getRlevel() == 1) {out.println("selected='selected'");}%>>�α��� ȸ��</option>
				 
<!--
	 							<option value="0" <%=(linfo.getRlevel() == 0) ? "selected" : ""%>>��ü</option>
								<option value="1" <%=(linfo.getRlevel() == 1) ? "selected" : ""%>>����1 ȸ�� �̻�</option>
								<option value="2" <%=(linfo.getRlevel() == 2) ? "selected" : ""%>>����2 ȸ�� �̻�</option>
								<option value="3" <%=(linfo.getRlevel() == 3) ? "selected" : ""%>>����3 ȸ�� �̻�</option>
								<option value="4" <%=(linfo.getRlevel() == 4) ? "selected" : ""%>>����4 ȸ�� �̻�</option>
								<option value="5" <%=(linfo.getRlevel() == 5) ? "selected" : ""%>>����5 ȸ�� �̻�</option>
								<option value="6" <%=(linfo.getRlevel() == 6) ? "selected" : ""%>>����6 ȸ�� �̻�</option>
								<option value="7" <%=(linfo.getRlevel() == 7) ? "selected" : ""%>>����7 ȸ�� �̻�</option>
								<option value="8" <%=(linfo.getRlevel() == 8) ? "selected" : ""%>>����8 ȸ�� �̻�</option>
								<option value="9" <%=(linfo.getRlevel() == 9) ? "selected" : ""%>>����9 ȸ�� �̻�</option>
 -->									
							</select>
						</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>�����</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="rid" maxlength="14" value="<%=linfo.getRid()%>" class="input01" style="width:300px;"  onkeyup="checkLength(this,14)" /></td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>�̹�������</strong></th>
						<td class="bor_bottom01 pa_left">
						<% if(linfo.getRimagefile().length()<=0 ||  linfo.getRimagefile().equals("") || linfo.getRimagefile().equals("null")) { %>
							<input type="file" name="rimagefile" class="sec01" size="30" >
							&nbsp;&nbsp;
						<%	}else{	%>
								<img src="<%=imgFile%>" border="0" width="160"><br>
								<img src="/vodman/include/images/but_imgdel.gif" alt="�̹�������" onClick="javascript:del_file('<%=linfo.getRcode()%>','img');" />
						<%	} %>
						</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>÷������</strong></th>
						<td class="bor_bottom01 pa_left"><input type="file" id="rfilename" name="rfilename" class="sec01" size="30" value="" onchange="javascript:limitFile()" />
						<%if(linfo.getRfilename() != null && linfo.getRfilename().length()>0 && !linfo.getRfilename().equals("null")){ %>
						  <br>
						  <font color="red"><a href="javascript:fileDown('<%=linfo.getRcode()%>');" title="÷������ �ٿ�ε�">
						  <% if (linfo.getOrg_rfilename() != null && linfo.getOrg_rfilename().length() > 0 ) { out.println(linfo.getOrg_rfilename()); } else {out.println(linfo.getRfilename());} %>
						  </a></font> �� ����Ǿ� �ֽ��ϴ�.<img src="/vodman/include/images/but_filedel.gif" alt="÷�����ϻ���" onClick="javascript:del_file('<%=linfo.getRcode()%>','file');" />
						  <%} %>
						</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>���ÿ���1</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="otitle" id="otitle" value="<%=linfo.getOtitle()%>" class="input01" style="width:400px;"/>&nbsp;
						  <input type="checkbox" name="vod_del" value="Y" />����
							 
							<input type="hidden" value="<%=linfo.getOcode()%>" name="ocode" id="ocode">
							<img src="/vodman/include/images/but_vodok.gif" onClick="sel_vod('ocode','otitle','')" style="cursor:pointer;" alt="vod����">
							<%
							if(linfo.getOcode() != null && linfo.getOcode().length()>0){
							%>
							<img src="/vodman/include/images/but_view.gif" onClick="play_v('<%= linfo.getOcode()%>')" style="cursor:pointer;" alt="�̸�����" >
							<%
							}
							%>
						</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>���ÿ���2</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="otitle2" id="otitle2" value="<%=linfo.getOtitle2()%>" class="input01" style="width:400px;"/>&nbsp;
						<input type="checkbox" name="vod_del2" value="Y" />����
							 
							<input type="hidden" value="<%=linfo.getOcode2()%>" name="ocode2" id="ocode2">
							<img src="/vodman/include/images/but_vodok.gif" onClick="sel_vod('ocode2','otitle2','')" style="cursor:pointer;" alt="vod����">
							<%
							if(linfo.getOcode2() != null && linfo.getOcode2().length()>0){
							%>
							<img src="/vodman/include/images/but_view.gif" onClick="play_v('<%= linfo.getOcode2()%>')" style="cursor:pointer;" alt="�̸�����" >
							<%
							}
							%>
						</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>���ÿ���3</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="otitle3" id="otitle3" value="<%=linfo.getOtitle3()%>" class="input01" style="width:400px;"/>&nbsp;
						<input type="checkbox" name="vod_del3" value="Y" />����
							 
							<input type="hidden" value="<%=linfo.getOcode3()%>" name="ocode3" id="ocode3">
							<img src="/vodman/include/images/but_vodok.gif" onClick="sel_vod('ocode3','otitle3','')" style="cursor:pointer;" alt="vod����">
							<%
							if(linfo.getOcode3() != null && linfo.getOcode3().length()>0){
							%>
							<img src="/vodman/include/images/but_view.gif" onClick="play_v('<%= linfo.getOcode3()%>')" style="cursor:pointer;" alt="�̸�����" >
							<%
							}
							%>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="but01">
							  <a href="javascript:memo_comment('<%=rcode%>');"><img src="/vodman/include/images/but_reply.gif" border="0"></a>
				
							<a href="javascript:chkForm(document.frmMedia);"><img src="/vodman/include/images/but_save.gif" alt="����"/></a>
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
<form name="down" method="post" action="download.jsp">
				<input type="hidden" name = "rcode" value="<%=rcode%>" >
			  </form>
<%@ include file="/vodman/include/footer.jsp"%>	
		