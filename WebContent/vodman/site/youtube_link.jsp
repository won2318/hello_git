<%@page import="com.yundara.beans.BeanUtils"%>
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
<%@ include file="/vodman/include/top.jsp"%>
<LINK REL="STYLESHEET" TYPE="text/css" HREF="/vodman/include/calendar/calendar.css">
<script language="JavaScript" src="/vodman/include/calendar/calendar.js" type="text/JavaScript"></script>

<script language="javascript">



function limitFile()
 {
	 var file = document.frmYtb.rfilename.value;
	 
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
	    document.frmYtb.rfilename.outerHTML = document.frmYtb.rfilename.outerHTML;
	   return;
	  }
 }



    function chkForm() {
    	
    	var f = document.frmYtb;
    	
   /*  	var title = document.getElementById("title").value;
		var link = document.getElementById("link").value;
		var img = "abcdef";
		 */
		if(f.title.value == "") {
			alert("Ÿ��Ʋ�� �Է����ּ���.");
			form.title.focus();
			return ;
		}
		if(f.link.value == "") {
			alert("url�� �Է��ϼ���.");
			form.link.focus();
			return ;
		}
		
		if(confirm("�����Ͻðڽ��ϱ�?") == false) {
			alert("������ ����ϼ̽��ϴ�.");
			location.href='youtube_link.jsp?mcode=0208&flag=G';
			return;
		}
		f.action='youtube_link_update.jsp?mcode=0207&flag=A';
	/* 	f.action='youtube_link_update.jsp?title='+title+'&link='+link+'&img='+img;  */
		f.submit();
		
		

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
			
				document.frmYtb.rimagefile.outerHTML = document.frmYtb.rimagefile.outerHTML;
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
	        document.frmYtb.reset();
	        return;
	    } 
	
	    //�̹��� ������ ���� 
	    document.all.imgWidth.value = imgWidth;
	    document.all.imgHeight.value = imgHeight;
	
	}



		
//////////////////////////////////////////////////////
//�޷� open window event 
//////////////////////////////////////////////////////

	</script>
	
	<%
 
	com.vodcaster.sqlbean.YoutubeeManager ytm = com.vodcaster.sqlbean.YoutubeeManager.getInstance();
	
	Vector youTb = ytm.getYoutubeeLink();

	String title ="";
	String img ="";
	String link ="";
 
	if (youTb != null && youTb.size() > 0) {
		 title = youTb.get(0).toString();
		 img =youTb.get(1).toString();
		 link = youTb.get(2).toString();
	}
 
	%>

<%@ include file="/vodman/best/best_left.jsp"%>
		<!-- ������ -->
		
		<div id="contents">
			<h3><span>��Ʃ�� ��ũ</h3>
			<p class="location">������������ &gt; ����ȭ����� &gt; <span>��Ʃ�� ��ũ</span></p>
			<div id="content">
				<!-- ���� -->
				<form name='frmYtb' method='post' enctype="multipart/form-data">
				<table cellspacing="0" class="board_view" >
				<input type="hidden" name="mcode" value="<%=mcode%>">
				<tbody class="bor_top03">
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>����</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" id ="title" name="title" maxlength="100" value="<%=title %>" class="input01" style="width:500px;"  onkeyup="checkLength(this,100)" /></td>
					</tr>
					
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>URL</strong></th>
						<td class="bor_bottom01 pa_left">https://<input type="text" id="link" name="link" maxlength="100" value="<%=link %>" class="input01" style="width:500px;"  onkeyup="checkLength(this,80)" /></td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>�̹�������</strong></th>
						<td class="bor_bottom01 pa_left">
							<input type="file"  id="img" name="img" class="sec01" size="30" value="" onchange="javascript:limitFile('img')" />
							<input type="hidden" name="old_imgName" value="<%=img%>"/>
							<br/>
							&nbsp;&nbsp;&nbsp;���� <input type='checkbox' id='image_del' name='image_del' value='Y' />
							<%=img%>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="but01">
							<a href="javascript:chkForm();"><img src="/vodman/include/images/but_save.gif" alt="����"/></a>
							<a href="/vodman/best/mng_best_topView.jsp?mcode=0207&flag=A"><img src="/vodman/include/images/but_cancel.gif" alt="���"/></a>
							</div>
						</td>
					</tr>
					 
				</tbody>
			</table>
			</form>
			</div>
		</div>

<%@ include file="/vodman/include/footer.jsp"%>	
		