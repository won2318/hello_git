<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%
	/**
	 * @author lee heerak
	 *
	 * @description : ������ �Խ��ǵ��� ������ �����ִ� ������
	 * date : 2010-10-19
	 */

%>
<%

	Vector v_list1 = null;

	try{
		v_list1 = BoardInfoSQLBean.getAllBoardInfoList();
	}catch(ArrayIndexOutOfBoundsException e){
		System.out.println("No search Date");
	}
	int iLeftMenuCnt = 1;
	String mcode_right = iLeftMenuCnt <9?"0"+iLeftMenuCnt:iLeftMenuCnt+"";
	String tmp = "1";
	String visible = "";
	if(mcode != null && mcode.length()>3){
		visible = mcode.substring(2,4).equals(mcode_right)?"class='visible' ":"";
	}
	
%>
<script charset="utf-8" src="/vodman/include/js/Menu_Roll.js" type="text/javascript"></script>
		<!-- ����޴� -->
		<div id="menu">
		<h2><img src="/vodman/include/images/a_menu08_title.gif" alt="�Խ��ǰ���"/></h2>
			 

			<ul class="s_menu_bg">
			
			<li><a href="/vodman/board/mng_boardList.jsp?mcode=0901" title="�Խ��� ����" <%if(mcode.equals("0901")) {out.println("class='visible'");}%>>�Խ��� ����</a></li>
			</ul>
			<ul class="s_menu_bg2">
				<!-- list start -->
					<%if(v_list1 != null && v_list1.size()>0){%>
					<%
						int board_id_ = 0;
						String title = "";

						for(int i=0; i < v_list1.size(); i++){
							iLeftMenuCnt++;
							try{
								board_id_ = Integer.parseInt(String.valueOf(((Vector)(v_list1.elementAt(i))).elementAt(0)));
							}catch(Exception e){
								board_id_ = 0;
							}
							try{
								title = String.valueOf(((Vector)(v_list1.elementAt(i))).elementAt(1));
							}catch(Exception e){
								title = "";
							}
							

							if(iLeftMenuCnt+1 > 10){
								mcode_right = iLeftMenuCnt + "";
							}else{
								mcode_right = "0"+iLeftMenuCnt;
							}
							if(mcode != null && mcode.length()>3)
							{
								
								tmp = mcode.substring(2,4).equals(mcode_right)?"class='visible'":"";
					%>
					<li class="height_20 title_dot03" ><a href="mng_boardListList.jsp?board_id=<%=board_id_%>&mcode=09<%=iLeftMenuCnt <10?"0"+iLeftMenuCnt:iLeftMenuCnt+""%>" title="<%=title%>" <%=tmp%> /><b><%=title%></b></a></li>
					<%		}	%>
						<%}//end for%>
					<%}//end if%>
				<!-- list end -->
			</ul>
			<ul class="s_menu_bg">
				<%
			if(iLeftMenuCnt+1 > 9){
				mcode_right = (iLeftMenuCnt+1) + "";
			}else{
				mcode_right = "0"+(iLeftMenuCnt+1);
			}
			if(mcode != null && mcode.length()>3){
				visible = mcode.substring(2,4).equals(mcode_right)?"class='visible' ":"";
			}
			String mcode_right2 = "";
			String visible2 = "";
			if(iLeftMenuCnt+2 > 9){
				mcode_right2 = (iLeftMenuCnt+2) + "";
			}else{
				mcode_right2 = "0"+(iLeftMenuCnt+2);
			}
			if(mcode != null && mcode.length()>3){
				visible2 = mcode.substring(2,4).equals(mcode_right2)?"class='visible' ":"";
			}

			//visible = mcode.substring(2,4).equals(mcode_right)?"class='visible'":"";
			%>
			<li><a href="/vodman/board/frm_boardAdd.jsp?mcode=09<%=iLeftMenuCnt+1 <10?"0"+(iLeftMenuCnt+1):(iLeftMenuCnt+1)+""%>" title="�Խ��� ���" <%=visible%>>�Խ��� ���</a></li>
			<li><a href="/vodman/board/mng_boardListComment.jsp?mcode=09<%=iLeftMenuCnt+2 <10?"0"+(iLeftMenuCnt+2):(iLeftMenuCnt+2)+""%>" title="�Խù� ���" <%=visible2%>>�Խù� ���</a></li>
			</ul>
			<p class="menu_bottom"></p>
		</div>

		