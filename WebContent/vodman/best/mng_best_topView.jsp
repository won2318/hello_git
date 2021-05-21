<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,org.apache.commons.lang.StringUtils,com.vodcaster.utils.TextUtil"%>

<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "be_list")) {
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

	
	/**
	 * @author 최희성
	 *
	 * description : 베스트 VOD정보 수정.
	 * date : 2005-01-25
	 */
	 int bti_num = 2;

	 String flag =   com.vodcaster.utils.TextUtil.getValue(request.getParameter("flag"));
	String str_bti_num = com.vodcaster.utils.TextUtil.getValue(request.getParameter("bti_num"));
	if(com.yundara.util.TextUtil.isNumeric( str_bti_num)){
		try{
			bti_num = Integer.parseInt(str_bti_num);
		}catch(Exception ex){
			
		}
	}
	String menu_title="화제의 영상";
	if(flag == null || flag.length() == 0 || flag.equals("null")) {
		flag = "B";
	}
 
	if(flag.equals("A")){
    	bti_num=1;
		menu_title="오늘의 영상";
    }else if(flag.equals("B")){
    	bti_num=2;
		menu_title="화제의 영상";
    }else if(flag.equals("C")){
    	bti_num=3;
		menu_title="명예의 전당";
    }else if(flag.equals("D")){
    	bti_num=4;
		menu_title="HOT 뉴스";
    } 
//	out.println(flag);
//	out.println(bti_num);
	BestMediaManager mgr = BestMediaManager.getInstance();
	Vector vt = mgr.getBestTopInfo(bti_num);
    BestTopInfoBean btiBean = new BestTopInfoBean();

    
   MediaManager mMgr = MediaManager.getInstance();
   com.hrlee.silver.OrderMediaInfoBean oinfo = new com.hrlee.silver.OrderMediaInfoBean();
	if (vt != null && vt.size() > 0) {
	    Enumeration e = vt.elements();
	    com.yundara.beans.BeanUtils.fill(btiBean, (Hashtable)e.nextElement());
	}

    StringBuffer strHit = new StringBuffer("");
    StringBuffer strMng = new StringBuffer("");
	 
%>

<%@ include file="/vodman/include/top.jsp"%>
<%
mcode = "0202";
if (request.getParameter("mcode") != null && request.getParameter("mcode").length() > 0 ) {
	mcode = request.getParameter("mcode") ;
}
%>
<script language="javascript" src="/vodman/include/js/script.js"></script>
<script language="javascript" src="/vodman/include/js/ajax_category_select2.js"></script>
<script language="javascript">
    function chkForm(form) {
 
    //    if (form.bti_mng_num.value == "" || isNaN(form.bti_mng_num.value) || form.bti_mng_num.value <= 0) {
    //        alert("관리자 선택 DISPLAY 개수는 숫자로 1 이상 입력해야 합니다.");
    //        form.bti_mng_num.focus();
    //        return false;
    //    }
        for (var i=0; i < form.bts_order.length; i++) {
            if (form.bts_title[i].value != "" && form.bts_ocode[i].value != "" && form.bts_order[i].options[form.bts_order[i].selectedIndex].value == "") {
                if (form.bts_order[i].options[form.bts_order[i].selectedIndex].value == "") {
                    alert("VOD 출력순서 " + (i+1) + " 를 선택하세요");
                    form.bts_order[i].focus();
                    return false;
                }
            }
        }
		
        return confirm("<%=menu_title%> 관리를 저장하시겠습니까");
    }

    function sel_vod(num,ccode) {	
        if(num != "") {
            window.open("pop_best_topList.jsp?num=" + num+"&ccode="+ccode, "", "width=670,height=600,scrollbars=yes");
        }
    }

	function play_v(ocode){
		//sv_wm_viewer = window.open("view_media.jsp?mid="+mid,"sv_wm_viewer","toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no,width=512,height=384\"");		
		sv_wm_viewer = window.open("/vodman/vod_aod/pop_vod_viewer.jsp?ocode="+ocode,"sv_wm_viewer","toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no,width=480,height=630\"");
		 
		return;
	}

	function go_url(mypage) {
		ComPopWin(mypage,"url_player",600,400);
	}

	function cateSearch()
	{		
		document.frmMedia.action = "mng_best_topView.jsp";
		document.frmMedia.submit();
	}
	

	function UItest(tableID){		
	var key = document.getElementsByName("bts_title");	
	var frm = document.frmMedia;	
	var result = frm.bti_mng_num.value;		
	var c = key.length;
	var p = result - c;
	
	if(c < result){
	
		for (var i=0; i <p; i++) {
		var table = document.getElementById(tableID);   
		
		var key1 = document.getElementsByName("bts_ocode");
		var m = key1.length;
		var cnt = key1.length;
		var  N = m+1;
		
		var tableTr = document.createElement('tr');    
		
		var td1 = document.createElement('td');
		
		var tb1 = document.createElement('table');
		tb1.width="100%";
		tb1.border = "0";
		tb1.cellSpacing="0";
		tb1.cellPadding="0";
		
		var tr1 = document.createElement('tr');
		
		var tableTd = document.createElement('td');
		tableTd.rowSpan = "3";	
		tableTd.width= "100";
		tableTd.className = 'bor_bottom01 right_border back_f7';
		tableTd.align = "center";
		tableTd.innerHTML = '<select name="bts_order'+N+'" class="sec01" id="bts_order'+N+'"><option value="" selected>선택</option></select>';
		
		var tableTd1 = document.createElement('td');
		tableTd1.rowSpan = "3";
		tableTd1.width= "120";
		tableTd1.className = 'bor_bottom01 right_border back_f7';	
		tableTd1.align = "center";
		
		var tableTd2 = document.createElement('td');
		tableTd2.className = 'right_border bor_bottom01';
		
		var tableTd3 = document.createElement('td');
		tableTd3.className = 'bor_bottom01 pa_left';
		tableTd3.height = "28";
		tableTd3.innerHTML = '<input type="text" name="bts_title" size="40" class="inputG"/>';
		
		
		var  up = c+i+1;
		var tableTr2 = document.createElement('tr');
		var tableTd4 = document.createElement('td');
		tableTd4.className= "right_border bor_bottom01";
		var tableTd5 = document.createElement('td');
		tableTd5.className = 'bor_bottom01 pa_left';
		tableTd5.height = "28";
		if(up == 1){
			tableTd5.innerHTML = "<input type='text' name='bts_ocode' size='20' class='inputG' readonly /> <a href=\"javascript:sel_vod('"+up+"','002000000000');\" /><img src='/vodman/include/images/but_vodok.gif' style='cursor:pointer;' alt='vod선택'/></a>";		
		}else if(up == 2){
			tableTd5.innerHTML = "<input type='text' name='bts_ocode' size='20' class='inputG' readonly /> <a href=\"javascript:sel_vod('"+up+"','007000000000');\" /><img src='/vodman/include/images/but_vodok.gif' style='cursor:pointer;' alt='vod선택'/></a>";		
		}else{
			tableTd5.innerHTML = "<input type='text' name='bts_ocode' size='20' class='inputG' readonly /> <a href=\"javascript:sel_vod('"+up+"','');\" /><img src='/vodman/include/images/but_vodok.gif' style='cursor:pointer;' alt='vod선택'/></a>";		
		}
		
		
		var tableTr3 = document.createElement('tr');
		var tableTd6 = document.createElement('td');
		tableTd6.width= "100";
		tableTd6.className = 'right_border bor_bottom01';
		
		var tableTd7 = document.createElement('td');
		tableTd7.className = 'bor_bottom01 pa_left';
		tableTd7.height = "28";
		tableTd7.innerHTML = '<select name="bts_type" class="sec01"><option value="A" selected>썸네일</option><option value="B">텍스트</option></select>';
		
		var abv1= document.createElement("text");
		abv1.innerHTML = "NO IMAGE";
		
		var abv2= document.createElement("td");
		abv2.innerHTML = "제&nbsp;&nbsp;&nbsp;목";
		
		var abv4= document.createElement("td");
		
		var abv6= document.createElement("div");	
		abv6.innerHTML = "목록 타입";
		
		tableTd1.appendChild(abv1);
		tableTd2.appendChild(abv2);		
		tableTd4.appendChild(abv4);			
		tableTd6.appendChild(abv6);
			
		var tbody = document.createElement("tbody");
					
		
		tableTr.appendChild(tableTd);
		tableTr.appendChild(tableTd1);	
		tableTr.appendChild(tableTd2);
		tableTr.appendChild(tableTd3);
		
		tableTr2.appendChild(tableTd4);
		tableTr2.appendChild(tableTd5);

		tableTr3.appendChild(tableTd6);
		tableTr3.appendChild(tableTd7);
				
		tbody.appendChild(tableTr);
		tbody.appendChild(tableTr2);
		tbody.appendChild(tableTr3);		
		
		tb1.appendChild(tbody);
		td1.appendChild(tb1);
		tr1.appendChild(td1);
		
		tr1.setAttribute('id','subjectrow1');	
		table.tBodies[0].appendChild(tr1);		
		}
	}else{	
		var frm1 = document.frmMedia;
		var cnt = document.getElementsByName("bts_title").length;
		var table =document.getElementById(tableID);
		
		//c = 총갯수 - display 갯수
		//m= 뺄갯수
		var m = c - result;
		
		if(result != 0 ){
			for (var i=0; i <m; i++) {
				var tableRef = document.getElementById(tableID);
				var delRow = tableRef.deleteRow(-1);
			}	
		}
	}	
	
	
	// 순번 리셋 후 값 설정
	
	if(result >= 1){
	
	for(a=1;a<=result;a++){
		
		var aa="bts_order"+a
		var selectaa = document.getElementById(aa);	
		var abc = selectaa.value;			
		
		if(abc != 0){
		var nbon = document.getElementById(aa).value;			
		}			
			for(var j=0; j<result; j++){				
			selectaa.options[ j ] = new Option(j+1,j+1);		
			}		
			selectaa.options.length = result;
		if(abc != 0){
		selectaa.options[ nbon-1].selected = true;
		}
	}
	}
	
	
}


	function set_form(){

		var aa = document.getElementById('bti_mng_num').value;  // 대상 갯수
		var bb = document.getElementById('bti_hit_num').value;  // 사용자 선택 갯수

		var min = aa;
		if (min > bb) {
			min = bb;
		}

		for ( var i = 0 ; i < min ; i++) {

			document.frmMedia.bts_ocode[i].value = document.frmMedia.hit_ocode[i].value;
			document.frmMedia.bts_title[i].value = document.frmMedia.hit_title[i].value;
			
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
			calendar = window.open('/vodman/include/calendar/calendar.html','cal','WIDTH=200,HEIGHT=250,scrollbars=no,resizable=no,status=yes');
		} else if (!calendar.closed) {
			calendar.focus();
		} else {
			calendar = window.open('/vodman/include/calendar/calendar.html','cal','WIDTH=200,HEIGHT=250,scrollbars=no,resizable=no,status=yes');
		}
	}
	
</script>

<%@ include file="/vodman/best/best_left.jsp"%>
		<div id="contents">
			<h3><span><%=menu_title%> </span> </h3>
			<p class="location">관리자페이지 &gt; 메인화면관리 &gt; <span><%=menu_title%></span></p>			
			<div id="content">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="recom_vod" summary="추천 VOD" >
				<caption>추천 VOD</caption>
                                      <form name='frmMedia' method='post' action="proc_best_topSave.jsp" onSubmit="return chkForm(document.frmMedia);">
                                      	<input type="hidden" name="gubun" value="<%=flag %>" >
                                        <input type="hidden" name="bti_id" value="<%= btiBean.getBti_id() %>">
                                        <input type="hidden" name="mcode" value="<%=mcode%>" />
                                        <input type="hidden" name="bti_num" value="<%=bti_num%>" />
                                        <input type="hidden" name="flag" value="<%=flag%>" />
                                        <tr>
                                          <td>
                                            <table  width="100%" border="0" cellpadding="5" cellspacing="0" >
                                              <tr>
                                                <td colspan="2">
                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%"  >
                                                    <tr>
                                                       
                                                         <td  class="bor_bottom01" width="100%" valign="top">
                                                            <table cellpadding="0" cellspacing="0" border="0" width="100%"  class="recom_vod" >
                                                            <tr>
                                                                <td class="bor_bottom01"  height="28" align="left">
                                                                *  <%=menu_title%> 설정<br>
                                                                <font color="blue">
                                                                 <% if (flag != null && flag.equals("A")) {
                                                                
                                                                	//out.println("- 재생 일자를 선택 하세요.<br>");
                                                                	// out.println("-등록된 영상은 랜덤으로 재생 됩니다.<br>");
                                                                }%></font>
                                                                
                                                                1. DISPLAY 하고자 하는 개수 선택-최소 2개 이상<br>
                                                                2. 검색 버튼을 눌러 동영상 선택<br>
                                                                3. 영상별 목록 타입 선택<br>
                                                                4. 저장<br>
                                                               
                                                                * 미리보기 기능을 이용해서 선택 한 동영상을 확인하실 수 있습니다.<br>
                                                                
                                                                </td>
                                                            </tr>
                                                            
<!--////////////////////////////////  -->
<% if (flag != null && flag.equals("C")) { %>
<tr>
   <td class="bor_bottom01" >
<table cellpadding="0" cellspacing="0" border="0" width="100%"  >
                                                           
                                                            <tr>
                                                                <td class="bor_bottom01"  height="28" align="center"><b>사용자 검색 리스트</b></td>
                                                            </tr>
                                                            
                                                            <tr>
                                                                <td class="bor_bottom01" >
                                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                                    <tr>
                                                                        <td align="center" width="145" height="28">DISPLAY 개수</td>
                                                                        <td> <input name="bti_hit_num" id="bti_hit_num" type="text" size="10" class="input01" value="<%= btiBean.getBti_hit_num() %>">
                                                                        <a href="javascript:set_form();">[기본 셋팅]</a>
                                                                        </td>
                                                                    </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            
                                                            <%
                                                                Vector vtHit = mgr.getBestHitList(btiBean.getBti_hit_num());
                                                            
                                                                int cntHit = 1;

                                                                for(Enumeration e = vtHit.elements(); e.hasMoreElements() ; cntHit++) {
                                                                    
                                                                    com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)e.nextElement());
                                                                    String temp_img_src = "";
                                                                    temp_img_src = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/"+oinfo.getModelimage();
                                                                    if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
                                                                    	temp_img_src = "/upload/vod_file/"+oinfo.getThumbnail_file();
                                                					}
                                                                    
                                                            %>
                                                            <tr>
                                                                <td>
                                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%"  >
                                                                    
                                                                    <tr>
                                                                        <td class="bor_bottom01 right_border back_f7"  align="center" width="100" rowspan="3"><%= cntHit %>위</td>
                                                                        <td class="right_border bor_bottom01" align="center" width="125"  rowspan="3" align="left" > <img src='<%=temp_img_src %>' border='0' alt="<%= oinfo.getTitle() %>" width="120"/></td>
                                                                        <td class="right_border bor_bottom01" align="left" width="100" height="28">제&nbsp;&nbsp;&nbsp;목</td>
                                                                        <td class="right_border bor_bottom01 pa_left"  align="left" height="28"> <%= oinfo.getTitle() %></td>
                                                                    </tr>
                                                                    
                                                                    <tr>
                                                                        <td class="right_border bor_bottom01"  align="left" width="100" height="28">재생 횟수</td>
                                                                        <td class="right_border bor_bottom01 pa_left"   align="left"  height="28">
                                                                        <%= oinfo.getHitcount()%> 회
                                                                        <input type="hidden" name="hit_ocode" value="<%= oinfo.getOcode()%>" />
                                                                        <input type="hidden" name="hit_title" value="<%= oinfo.getTitle()%>" />
                                                                        <img src="/vodman/include/images/but_view.gif" onClick="play_v('<%= oinfo.getOcode()%>')" style="cursor:pointer;" alt="미리보기" >
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <%
                                                                }
                                                              
                                                            %>
                                                           
                                                            </table>
</td>
</tr>

<%} %>
 															 
                                                                
<!--////////////////////////////////  -->                                                           
														   
                                                            <tr>
                                                                <td class="bor_bottom01" >
                                                                    <table cellspacing="0" cellpadding="0" border="0" >
                                                                    <tr>
                                                                        <td align="center" width="145" height="28"  align="center" >DISPLAY 개수</td>
                                                                        <td>
                                                                        <select name="bti_mng_num" id="bti_mng_num" class="sec01" onchange="UItest('tablea')" >
                                                                                <option value="0" >순서</option>
                                                                        <%
                                                                            for (int i=1; i <= 10; i++) {
                                                                        %>
                                                                                <option value="<%= i %>" <%= i== btiBean.getBti_mng_num() ? "selected" : "" %>><%= i %></option>
                                                                        <%
                                                                            }
                                                                        %>
                                                                                </select>
                                                                        
                                                                        </td>
                                                                    </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>															
															 <table cellpadding="0" cellspacing="0" border="0" width="100%" id ="tablea">																			 															
                                                            <%
                                                                Vector vtBts = new Vector();
                                                                if (btiBean.getBti_id() != 0) {
																//bti_num
                                                                        vtBts = mgr.getBestTopSubList(String.valueOf(btiBean.getBti_id()), String.valueOf(btiBean.getBti_mng_num()));
                                                                }
                                                                BestTopSubBean btsBean = new BestTopSubBean();
                                                                int cntMng = 0;
																String a_ocode = "";
																String a_ccode = "";
                                                                if (vtBts != null && vtBts.size() != 0) {
                                                                 
                                                                    for (Enumeration e = vtBts.elements(); e.hasMoreElements();) {
                                                                        cntMng++;
                                                                        
                                                                        com.yundara.beans.BeanUtils.fill(btsBean, (Hashtable)e.nextElement());

                                                                        String title = btsBean.getBts_title();
                                                                        if(title!=null && !title.equals("")) {
                                                                            if(title.length() > 29) {
                                                                                title = title.substring(0,30) + "...";
                                                                            }
                                                                        }
																		
                                                                       a_ocode = String.valueOf(btsBean.getBts_ocode());
																		
                                                                       String temp_img_src = "";
                                                                       String temp_vod_content = "";
                                                                       Vector vo = mMgr.getOMediaInfo(a_ocode);
                                                                   	if (vo != null && vo.size() > 0) {
                                                                   		try {
                                                                   			Enumeration e2 = vo.elements();
                                                                   			com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)e2.nextElement());
                                                                   		  
                                                                   			//temp_vod_content = oinfo.getDescription();
                                                                   			//temp_img_src = SilverLightPath + "/"+oinfo.getSubfolder()+"/"+a_ocode+"/thumbnail/"+oinfo.getModelimage();
																			temp_img_src = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/"+oinfo.getModelimage();
																               if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
			                                                                    	temp_img_src = "/upload/vod_file/"+oinfo.getThumbnail_file();
			                                                					}
                                                                   			 

                                                                   		} catch (Exception e2){
                                                                   			System.err.println(e2.getMessage());
                                                                   			 
                                                                   		}
                                                                   	}else{  
                                                                   		//out.println("error");
                                                                   	}
                                                                   	 
                                                            %>					
															<tr>
																<td>	
																	<table cellpadding="0" cellspacing="0" border="0" width="100%" >																	
															
                                                                        <tr>
                                                                            <td class="bor_bottom01 right_border back_f7"  align="center" width="100" rowspan="3">
                                                                                <select name="bts_order<%=cntMng%>" class="sec01" id="bts_order<%=cntMng%>" >
                                                                                <option value="">순서</option>
                                                                        <%
                                                                            for (int i=1; i <= btiBean.getBti_mng_num(); i++) {
                                                                        %>
                                                                                <option value="<%= i %>" <%= i== btsBean.getBts_order() ? "selected" : "" %>><%= i %></option>
                                                                        <%
                                                                            }
                                                                        %>
                                                                                </select>
                                                                            </td>
                                                                            <td class="bor_bottom01 right_border back_f7"  align="center" width="125" rowspan="3"><img src='<%=temp_img_src %>' border='0' alt="<%= btsBean.getBts_title() %>" width="120"/></td>
                                                                            <td class="right_border bor_bottom01"  align="left" width="60" height="28">제&nbsp;&nbsp;&nbsp;목</td>
                                                                            <td class="bor_bottom01 pa_left"  align="left" height="28"> <input name="bts_title" type="text" size="40" class="inputG" value="<%= btsBean.getBts_title() %>" maxlength="100"  onkeyup="checkLength(this,100)" readonly="readonly" ></td>
                                                                        </tr>
                                                                        
                                                                        <tr>
                                                                            <td class="right_border bor_bottom01"  align="left" width="100" height="28">
                                                                            <% if (flag.equals("AA")) { // 재생일자 선택
                                                                            	if (cntMng == 1) { %>
                                                                            		<input name="bts_uid"  type="text" size="12" class="inputG" readonly="readonly" value="default">
                                                                            	<%	} else{
                                                                            %>
                                                                            <input name="bts_uid" id="bts_uid<%=cntMng %>" type="text" size="12" class="inputG" readonly="readonly" value="<%= btsBean.getBts_uid() %>">
                                                                            <a href="javascript:openCalendarWindow(document.getElementById('bts_uid<%=cntMng %>'));" title="찾아보기"><img src="/vodman/include/images/icon_calender.gif" alt="찾아보기"/></a>
                                                                            <%		}
                                                                            	} else {
                                                                            		 %>
                                                                                 	vod코드
                                                                                 	 <input name="bts_uid" id="bts_uid<%=cntMng %>" type="hidden" size="12" class="inputG" readonly="readonly" value="<%= btsBean.getBts_uid() %>">
                                                                                 <%
                                                                            		
                                                                            		} %>
                                                                             &nbsp;</td>
                                                                            <td class="bor_bottom01 pa_left"  height="28"  align="left"> 
																							<input name="bts_ocode" type="text" size="20" class="inputG" readonly="readonly" value="<%= btsBean.getBts_ocode() %>"> 
																							
																							<img src="/vodman/include/images/but_vodok.gif" onClick="sel_vod('<%= cntMng %>','')" style="cursor:pointer;" alt="vod선택">
																							<%
																							if(a_ocode != null && a_ocode.length()>0){
																							%>
																							<img src="/vodman/include/images/but_view.gif" onClick="play_v('<%= a_ocode%>')" style="cursor:pointer;" alt="미리보기" >
																							<%
																							}
																							%>
																							 
																							</td>
                                                                        </tr>
                                                                        <input type="hidden" name="bts_type" value="A" />
 
 
																			</table>	
															</td>																
															</tr>														
																
                                                            <%
                                                                    }
                                                                }
															%>		
			
															
															<%
                                                                if (cntMng < btiBean.getBti_mng_num()) {
                                                                    int k = cntMng;
                                                             %>
															 
															 <%
                                                                    for (int j=0; j < btiBean.getBti_mng_num() - cntMng; j++) {
                                                                        k++;
                                                                        
                                                            %>															
																	<tr>
																		<td>
																			<table cellpadding="0" cellspacing="0" border="0" width="100%"  >
                                                                                <tr>
                                                                                    <td class="bor_bottom01 right_border back_f7"  align="center" width="100" rowspan="3">
                                                                                        <select name="bts_order<%=k%>" class="sec01"  name="bts_order<%=k%>">
                                                                                        <option value="">-선택-</option>
                                                                      <%
                                                                                    for (int i=1; i <= btiBean.getBti_mng_num(); i++) {
                                                                                %>
                                                                                        <option value="<%= i %>" <%= i==k ? "selected" : "" %>><%= i %></option>
                                                                                <%
                                                                                    }
                                                                                %>
                                                                                        </select>
                                                                                    </td>
																					<td class="bor_bottom01 right_border back_f7"  align="center" width="125" rowspan="3">NO IMAGE</td>
                                                                                    <td class="right_border bor_bottom01"  align="left" width="100" height="28">제&nbsp;&nbsp;&nbsp;목</td>
                                                                                    <td class="bor_bottom01 pa_left"  height="28"> <input name="bts_title" type="text" size="40" class="inputG" value=""></td>
																							</tr>
                                                                               
                                                                                <tr>
                                                                                    <td class="right_border bor_bottom01"  align="left" width="100" height="28">
                                                                                    <% if (flag.equals("AA")) { //재생 일자 선택 %>
                                                                            <input name="bts_uid" id="bts_uid<%=k %>" type="text" size="12" class="inputG" readonly="readonly" value="">
                                                                            <a href="javascript:openCalendarWindow(document.getElementById('bts_uid<%=k %>'));" title="찾아보기"><img src="/vodman/include/images/icon_calender.gif" alt="찾아보기"/></a>
                                                                            <%} else {
                                                                            %>
                                                                            	vod코드
                                                                            	 <input name="bts_uid" id="bts_uid<%=k %>" type="hidden" size="12" class="inputG" readonly="readonly" value="">
                                                                            <%
                                                                            } %></td>
                                                                                    <td class="bor_bottom01 pa_left"  height="28"> <input name="bts_ocode" type="text" size="20" class="inputG" readonly> 
																									<img src="/vodman/include/images/but_vodok.gif" onClick="sel_vod('<%=k %>','')" style="cursor:pointer;" alt="vod선택">
																									
																								</td>
                                                                                </tr>
                                                                                <input type="hidden" name="bts_type" value="A" />
 
 
																		</table>
																		</td>
                                                            </tr>																		
                                                            <%
                                                            
                                                                    }
															%>																	
															<%
                                                                }
                                                             %>                                                      
															</table>														                                                               												
                                                        </td>
                                                        
                                                        </tr>
                                                    </table>
                                                </td>
                                              </tr>                                              
                                            </table>
                                          </td>
                                        </tr>									
                                        <tr height="35" >
                                          <td colspan="2" align="center">
											<table border="0" cellspacing="0" cellpadding="5">
                                              <tr>
                                                <td><input type="image" src="/vodman/include/images/but_ok3.gif"  border="0"></td>
                                                <td><span style="cursor:hand" onClick="document.frmMedia.reset();"><img src="/vodman/include/images/but_cancel.gif"  border="0"></span></td>
                                              </tr>
                                            </table>

                                          </td>
                                        </tr>
                                      </form>
                                    </table>		
			
			
			</div>
		</div>
<%@ include file="/vodman/include/footer.jsp"%>