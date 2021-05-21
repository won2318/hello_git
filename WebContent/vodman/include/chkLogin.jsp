<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="euc-kr" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%!
    public boolean chk_login(String vod_id, String vod_level) {

        if(vod_id==null || vod_level==null) {
            return false;
        }

        if(vod_id.equals("") || vod_level.equals("")) {
            return false;
        }
        return true;
    }


    public boolean chk_auth(String vod_id, String vod_level, String area) {
        if(vod_level==null || vod_level.equals("")) {
            vod_level = "1";
        }
        int auth_v = com.vodcaster.sqlbean.AuthManager.getInstance().getAuthLevel(area);
        if(Integer.parseInt(vod_level) >= auth_v) {
            return true;
        }else{
            return false;
        }
    }
%>
<%!
/**
   * BASE64 Encoder
   * 
   * @param str
   * @return
   * @throws java.io.IOException
   */
  public  String base64Encode(String str) {
    String result = "";
    sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
    byte[] b1 = str.getBytes();
    result = encoder.encode(b1);
    return result;
  }

  /**
   * BASE64 Decoder
   * 
   * @param str
   * @return
   * @throws java.io.IOException
   */
  public  String base64Decode(String str) {
    String result = "";
    try {
      sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
      byte[] b1 = decoder.decodeBuffer(str);
      result = new String(b1);
    } catch (IOException ex) {
    }
    return result;
  } 


%>

<%
	String data = request.getParameter("data");	
	if(data != null && data.length()>0){
		java.util.Date day = new java.util.Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String cur_time = sdf.format(day);
	
		String orgData = "";	//�Ѱܹ��� ȸ������
		String sosok_name = "";	//�ҼӸ�
		String buseo_name = "";	//�μ���
		String gray_name = "";	//���޸�
		String sosok_code = "";	//�Ҽ��ڵ�
		String buseo_code = "";	//�μ��ڵ�
		String gray_code = "";	//�����ڵ�
		String user_id = "";	//����� 
		String user_name = "";	//����ڸ�
		String user_time = "";	//�α��� �ð�
		data = data.replaceAll(" ","+");	//:�� ���ڿ� �и�
		try{
			if(data != null && data.length()>0){
				orgData =base64Decode(data);
//				out.println(orgData);
//				out.println("<br>");
				String[] temp2 = new String[9]; //�迭 ����
				temp2 = orgData.split(":"); //�ɰ� �ֱ�
				if(temp2.length >= 9){
					for(int i=0;i<temp2.length;i++){
//						out.println(temp2[i]);
//						out.println("<br>");
					}
					sosok_code = temp2[0];	//�Ҽ��ڵ�
					sosok_name = temp2[1];	//�ҼӸ�
					buseo_code = temp2[2];	//�μ��ڵ�
					buseo_name = temp2[3];	//�μ���
					gray_code = temp2[4];	//�����ڵ�
					gray_name = temp2[5];	//���޸�
					user_id = temp2[6];		//����� ID
					user_name = temp2[7];	//����� �̸�
					user_time = temp2[8];	//�α��� ��û �ð�
					
					//������ ����ð��� ������� �ð��븦 ���Ѵ�.
					if(user_time == null || user_time.equals("")){
						//�α��� ������ �ùٸ��� �ʽ��ϴ�.
					}else{
						//�� + �� + �� + �� ���� ���Ѵ�.
						//2007 08 02 09

//						if(user_time.length()>10 && user_time.substring(0,10).equals(cur_time.substring(0,10))){
							//�ùٸ� �α��� ����
							pageContext.setAttribute("vod_id", user_id);
					        pageContext.setAttribute("vod_name", user_name);
					        pageContext.setAttribute("vod_sosok", sosok_name);
					        pageContext.setAttribute("vod_buseo", buseo_name);
					        pageContext.setAttribute("vod_gray", gray_name);
					        pageContext.setAttribute("gray_code", gray_code);
					        pageContext.setAttribute("sosok_code", sosok_code);
					        pageContext.setAttribute("buseo_code", buseo_code);
					        String vod_id = (String)session.getValue("vod_id");

					        //null�϶�, ���� ������, guest�϶� session ���� 
					        if(vod_id == null || (vod_id != null &&  vod_id.length()<=0) || (vod_id != null &&  vod_id.equals("guest"))){
					        	//���� ���� 
					        	session.putValue("vod_id", user_id);
				                session.putValue("vod_name", user_name);
				                session.putValue("vod_sosok", sosok_name);
				                session.putValue("vod_buseo", buseo_name);
				                session.putValue("vod_gray", gray_name);
				                session.putValue("gray_code", gray_code);
				                session.putValue("sosok_code", sosok_code);
				                session.putValue("buseo_code", buseo_code);
				                session.putValue("vod_level", String.valueOf(1));
				                session.setMaxInactiveInterval(3600);
					        }
//						}
					}
				}
			}
		}catch(Exception ex){
			 out.println("������ �߻� �Ͽ����ϴ�. �����ڿ��� ���� �ּ���");
		}
	}
%>

<%
	String vod_id = (String)session.getValue("vod_id");
	String vod_pwd = (String)session.getValue("vod_pwd");    
	String vod_name = (String)session.getValue("vod_name");
    String vod_level = (String)session.getValue("vod_level");
    String vod_sosok = (String)session.getValue("vod_sosok");
//    vod_sosok = "withustech";
    String vod_buseo = (String)session.getValue("vod_buseo");
//    vod_buseo = "develope";
    String vod_gray = (String)session.getValue("vod_gray");
//    vod_gray = "number1";
	if (vod_level == null) {
		vod_level = "1";
	}
    java.util.Vector vod_mylist = (java.util.Vector)session.getValue("vod_mylist");


    
    if (chk_login(vod_id, vod_level)) {
        pageContext.setAttribute("vod_id", vod_id);
        pageContext.setAttribute("vod_name", vod_name);
        pageContext.setAttribute("vod_sosok", vod_sosok);
        pageContext.setAttribute("vod_buseo", vod_buseo);
        pageContext.setAttribute("vod_gray", vod_gray);
    }
%>