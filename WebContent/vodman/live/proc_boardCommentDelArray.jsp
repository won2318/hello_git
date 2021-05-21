<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.vodcaster.sqlbean.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth_pop.jsp"%>
<%
   // request.setCharacterEncoding("EUC-KR");
    
    String pg = StringUtils.defaultString(request.getParameter("mpage"), "1");
    String mcode = request.getParameter("mcode");
    String jaction = request.getParameter("jaction");
    String muid = request.getParameter("muid");
    
	String flag = request.getParameter("flag");
    
    String memoId = vod_id;
 
    String memoName = vod_name;

	String[] v_chk = null;
	  int iSuccess = 0;

    if (StringUtils.isEmpty(jaction) 
        || !StringUtils.equals(jaction,"delete")) 
        {
		
%>
        <script type="text/javascript" language="javascript">
            alert("필수 파라미터가 맞지 않습니다.");
            history.go(-1);
        </script>
<%
    }
	
	
%>
<%    
	com.vodcaster.sqlbean.MemoInfoBean memoBean = new com.vodcaster.sqlbean.MemoInfoBean();
	StringBuffer param = new StringBuffer("");
    param.append("mpage=").append(pg);
    param.append("&flag=").append(flag);
    param.append("&mcode=").append(mcode);
	MemoManager memoMgr = MemoManager.getInstance();
	String result_msg = "";
	try 
	{
            if(request.getParameterValues("v_chk") != null) 
			{
                v_chk = request.getParameterValues("v_chk");
                int iReuslt = -1;
                if(v_chk != null && v_chk.length > 0)
				{
	                for(int i=0; i < v_chk.length;i++)
					{
	                    if( v_chk[i] !=null && !v_chk[i].equals("") ) 
						{
								try{
									memoBean.setMuid(Integer.parseInt(v_chk[i]));
									memoMgr.saveMemo(memoBean, jaction);
									 iSuccess = 1;
								}catch(Exception ex){
									 iSuccess = 0;
									 result_msg += "error : " + v_chk[i] + " : " + ex.getMessage();
								}
							}else{
								result_msg += " 잘 못된 요청입니다.  ";
							}
	                }// end for
                }else{
					result_msg += " 잘 못된 요청입니다.  ";
				}
            }else{
     			 result_msg += " 잘 못된 요청입니다.  ";
            }
        }catch(Exception e) {
            System.out.println(e.getMessage());
			 result_msg += " error : " + e.getMessage();
        }

	out.println("<script type=\"text/javascript\" language=\"javascript\">");
		if(result_msg.equals("")){
 			out.println("alert('성공적으로 삭제 되었습니다.');");
		}else{
			out.println("alert('처리 중 오류가 발생하였습니다. 이전 페이지로 이동합니다.')");
		}

	 
		out.println("location.href='/vodman/live/mng_boardListComment.jsp?"+param.toString()+"';");
	 
	out.println("</script>");     
	%>

	
