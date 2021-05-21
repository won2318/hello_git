<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.yundara.util.*"%>

<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="bliBean" class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" />
 
 <%@ include file = "/include/chkLogin.jsp"%>
 <%

//request.setCharacterEncoding("EUC-KR");
 
MediaManager mgr = MediaManager.getInstance();
Hashtable result_ht = null; 

 String ccode ="";
 if (request.getParameter("ccode") != null && request.getParameter("ccode").length() > 0  && !request.getParameter("ccode").equals("null")) {
 	ccode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ccode"));
 } 
 int board_id = 0;   

 if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0 && !request.getParameter("board_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id")))
 {
 	 board_id = Integer.parseInt(TextUtil.nvl(request.getParameter("board_id")));
 	 
 } 

	CategoryManager cmgr = CategoryManager.getInstance();
	Vector cate_x = cmgr.getCategoryListALL2("X","A");
	
	
	String search_ccode = "";
	if(request.getParameter("search_ccode") != null && request.getParameter("search_ccode").length() > 0 && !request.getParameter("search_ccode").equals("null")){
		search_ccode = request.getParameter("search_ccode").replaceAll("<","").replaceAll(">","");
	}
	String search_ycode = "";
	if(request.getParameter("search_ycode") != null && request.getParameter("search_ycode").length() > 0 && !request.getParameter("search_ycode").equals("null")){
		search_ycode = request.getParameter("search_ycode").replaceAll("<","").replaceAll(">","");
	}
	
	String searchField = "";
	if(request.getParameter("searchField") != null && request.getParameter("searchField").length() > 0 && !request.getParameter("searchField").equals("null")){
		searchField = request.getParameter("searchField").replaceAll("<","").replaceAll(">","");
	} 
	
	String searchString = "";
	if(request.getParameter("searchString") != null && request.getParameter("searchString").length() > 0 && !request.getParameter("searchString").equals("null")){
		//searchString = request.getParameter("searchString");
		searchString =  CharacterSet.toKorean(request.getParameter("searchString").replaceAll("<","").replaceAll(">",""));
	}
  
	String[] xcodes = request.getParameterValues("xcode");
	String xcode ="";
	if (xcodes != null && xcodes.length > 0) {
		for (int i = 0 ; xcodes != null && i < xcodes.length ; i++ ) {
			xcode += xcodes[i]+"/";				
		}
	}  
 

int pg = 0;
if(request.getParameter("_page_")==null || !com.yundara.util.TextUtil.isNumeric(request.getParameter("_page_"))){
    pg = 1;
}else{
	try{
		pg = Integer.parseInt(request.getParameter("_page_"));
	}catch(Exception ex){
		pg = 1;
	}
}

String order = StringUtils.defaultIfEmpty(request.getParameter("order"), "mk_date");
String direction = StringUtils.defaultIfEmpty(request.getParameter("direction"), "desc");

int listCnt = 10;				//������ ��� ����
int totalArticle =0; //�� ���ڵ� ����

if ( (searchString != null && searchString.length() > 0) || (search_ccode != null && search_ccode.length() > 0) ||  (search_ycode != null && search_ycode.length() > 0) || (xcode != null && xcode.length() > 0) ) {
	result_ht = mgr.getOMediaListAllSearch(search_ccode, xcode, search_ycode, order ,searchField,  searchString, pg, listCnt, direction, Integer.parseInt(vod_level));
}
	Vector ibt = null;
	com.yundara.util.PageBean pageBean = null;
	int iTotalPage = 0;
	int iTotalRecord = 0;
	if(result_ht != null && !result_ht.isEmpty() && result_ht.size() > 0){
		ibt = (Vector)result_ht.get("LIST");
		if(ibt != null && ibt.size()>0){
			pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
			iTotalRecord = pageBean.getTotalRecord();
			iTotalPage = pageBean.getTotalPage();
			totalArticle = pageBean.getTotalRecord();

		}
	} 
	 
%>
    <%@ include file = "../include/html_head.jsp"%> 
    <script language="javascript" src="../include/js/ajax_category_select2.js"></script>
    
<script type="text/javascript">
// ��з� ī�װ� �ҷ����� (ajax_category_select.js)
		window.onload = function() {
	
			refreshCategoryList_A('V', '', 'A', '<%=search_ccode%>');
			refreshCategoryList_B('V', '', 'B', '<%=search_ccode%>');
 	
<%-- 			refreshCategoryList_AV('Y', '', 'A', '<%=search_ycode%>'); --%>
<%-- 			refreshCategoryList_BV('Y', '', 'B', '<%=search_ycode%>');  --%>
		} 
		
		function setCcode(form, val) {
			form.search_ccode.value = val;
		}
		function setCcodeY(form, val) {
			form.search_ycode.value = val;
		}

		
</script>    
 
	<!-- container::���������� --><!-- containerS::���������� -->
	<section id="body">
			<div id="container_out">
				<div id="container_inner">
				
				<div class="totalSearch">
 
					<form name="form1" action="search.jsp" method="post">
					<input type="hidden" name="_page_" value="<%=pg%>" />

					<input type="hidden" name="search_ycode" value="<%=search_ycode%>" />
					<input type="hidden" name="search_ccode" value="<%=search_ccode%>" />
						<fieldset>
						<legend>����˻�</legend>
							<div class="searchTop">
							
								<select name="searchField">
								<option value="title" <% if (searchField == null ||searchField.equals("title") ) {out.println(" selected='selected' ");}%>>����</option>
								<option value="tag_kwd" <% if (searchField != null &&  searchField.equals("tag_kwd") ) {out.println(" selected='selected' ");}%>>Ű����</option>
								<option value="description" <% if (searchField != null && searchField.equals("description") ) {out.println(" selected='selected' ");}%>>����</option>
								<option value="all" <% if (searchField != null &&  searchField.equals("all") ) {out.println(" selected='selected' ");}%>>����+����+Ű����</option>
								
								</select>
								<input type="text" title="�˻���" name="searchString" value="<%=searchString %>" class="input_text"/> 
								<input type="image" src="../include/images/icon_search.png" alt="�˻�"/>
							</div>
							<dl>
								<dt><label for="search_ccode">ī�װ�</label></dt>
								<dd>
								<select id="ccategory1" name="ccategory1" class="select1" style="width:125px;" onchange="javascript:setCcode(document.form1, this.value); refreshCategoryList('V', this.value, 'B', 'ccategory2');">
									<option value="">--- ��з� ���� ---</option>
								</select>
			
								<select id="ccategory2" name="ccategory2" class="select1" style="width:125px;" onchange="javascript:setCcode(document.form1, this.value)">
									<option value="">--- �ߺз� ���� ---</option>
								</select> 
								 
								</dd>
							</dl>
							<dl>
								<dt><label for="field1">�о�</label></dt>
								<dd>
									<ul>
						<%
						if(cate_x != null && cate_x.size()>0)
						{
						int cntx = 0;
						CategoryInfoBean xinfo = new CategoryInfoBean();
						for(Enumeration e = cate_x.elements(); e.hasMoreElements();) {
							com.yundara.beans.BeanUtils.fill(xinfo, (Hashtable)e.nextElement());
						%>
	 								<li><input type="checkbox" name="xcode" title="��ü" class="checktype1" value="<%=xinfo.getCcode()%>" <%if (xcode.contains(xinfo.getCcode())) {out.println("checked='checked'");} %>/><label for="field3"><%=xinfo.getCtitle()%></label></li>
									
	 					<% 
							} 
						}%>
 									</ul>
								</dd>
							</dl>
							<%if(totalArticle <= 0){%>
							<dl>
								<dt><label for="searchPro1">���α׷�</label></dt>
								<dd>
								<div id="searchproFull">
										<ul class="searchproView"> 
<% 		 
Vector vt = cmgr.getCategoryListALL2("Y","A");
										
if(vt != null && vt.size()>0) {
						CategoryInfoBean info = new CategoryInfoBean();
						
						for(Enumeration e = vt.elements(); e.hasMoreElements();) {
						
							com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
%>
				<li class="pro"><a href="/2017/info/search.jsp?search_ycode=<%=info.getCcode()%>"><%=info.getCtitle()%></a>
				<ul>

 
<%
		Vector vtB = cmgr.getCategoryListALL2("Y","B",info.getCcode());
		if(vtB != null && vtB.size()>0)
		{
			for (Enumeration eb = vtB.elements(); eb.hasMoreElements();)
			{
				com.yundara.beans.BeanUtils.fill(info, (Hashtable)eb.nextElement());
	%>
  
						<li><a href="/2017/info/search.jsp?search_ycode=<%=info.getCcode()%>"><%=info.getCtitle()%></a></li>
						
	<%

			 
			}
		}
		%>
		</ul>
		</li>
<% 
	}

}
%> 
									</ul>
									</div>
								</dd>
							</dl>
							<%}%>
						</fieldset>
					</form>
				</div>
				<div class="searchVod">
					<h4>��<span><%=totalArticle %></span>���� �˻��Ǿ����ϴ�.</h4>
					<ul>
<%
	double dFrom = Double.parseDouble("20171226102100000");
	//com.hrlee.silver.OrderMediaInfoBean oinfo = new com.hrlee.silver.OrderMediaInfoBean();
	int list = 0;
	if ( ibt != null && ibt.size() > 0){

		for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<ibt.size()) ; i++, list++)
		{
			com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)ibt.elementAt(list));
			//String ocontents = oinfo.getDescription();
			String ocontents = oinfo.getContent_simple();
			String imgurl ="/2017/include/images/noimg_small.gif";
			String imgTmp = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/_medium/"+oinfo.getModelimage();
			String strTitle = com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(),false);
		 	
			if(oinfo.getModelimage()== null || oinfo.getModelimage().length() <=0 ||oinfo.getModelimage().equals("null")) {
				imgTmp = imgurl;
			}else{
				double dA = Double.parseDouble(oinfo.getOcode());
				if(dA > dFrom){
					 imgTmp = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/_medium/"+oinfo.getModelimage();
				}  
			}
			if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
				imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
				
			}
     		if((ocontents != null) &&   !ocontents.equals("")) {
				ocontents = ocontents.length() <= 100 ? ocontents : ocontents.substring(0, 98) + "..";
				ocontents = ocontents.replaceAll("<p>","").replaceAll("</p>","").replaceAll("<P>","").replaceAll("</P>","");
			}
 			String wdate = "";
			if(oinfo.getOcode() != null && oinfo.getOcode().length()>0){
				
				wdate = oinfo.getMk_date();
				String temp_ocode = oinfo.getOcode().substring(0,8);
				String temp_ctitle = oinfo.getCtitle(); 
				if (oinfo.getCcode().contains("004001")) {
					temp_ctitle = "����PD";
				} 
			
%>					
						<li>
							<span class="img"><a href="../video/video_list.jsp?ocode=<%=oinfo.getOcode()%>&ccode=<%=oinfo.getCcode()%>"><img src="<%=imgTmp %>" alt='<%=strTitle %>'/></a></span>
							<span class="info">
								<span class="day"><%=wdate %></span>
								<span class="cate1"><%=temp_ctitle %> </span>
								<span class="title"><a  href="../video/video_list.jsp?ocode=<%=oinfo.getOcode()%>&ccode=<%=oinfo.getCcode()%>"><%=oinfo.getTitle() %></a></span>
								<span class="cate2"><%=oinfo.getContent_simple() %></span>
								<span class="info2">
									<span class="time"><%=oinfo.getPlaytime() %></span>
									<span class="recom"><%=oinfo.getRecomcount() %></span>
									<span class="view"><%=oinfo.getHitcount() %></span>
									<span class="reply"><%=oinfo.getMemo_cnt() %></span>
								</span>
							</span>
						</li>
					 
<%
			}
		}
	}else{
		if (searchString != null && searchString.length() > 0) {
		%> 
		<li>��ϵ� ������ �����ϴ�.</li>
		<%
		} 
	}
%>						 
					</ul>
				</div>
 
<%if(ibt != null && ibt.size()>0){ %>	
 
				<%@ include file = "./search_pageing.jsp"%>
<%} 
  %>				 
 
			</div><!--//container_inner-->
				<aside class="container_right">
				 
					<div class="NewTab list5 list3">
						<ul >
						<%@ include file = "../include/right_new_video.jsp"%>   
							
						</ul>
					</div><!--//NewTab list3-->
						<%@ include file = "../include/right_best_video.jsp"%>   

				</aside><!--//container_right-->
			</div><!--//container_out-->
		</section><!--�������κ�:section-->    
		
	 <%@ include file="../include/html_foot.jsp"%>