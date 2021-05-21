package com.vodcaster.sqlbean;


import java.util.Vector;
import java.util.Hashtable;
import javax.servlet.http.HttpServletRequest;

import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;
import com.vodcaster.multpart.MultipartRequest;
import com.yundara.util.CharacterSet;
public class FixedUserManager {

	private static FixedUserManager instance;
	private FixedUserSql sqlbean = null;
    
	private FixedUserManager() {
        sqlbean = new FixedUserSql();
    }
    
	public static FixedUserManager getInstance() {
		if(instance == null) {
			synchronized(FixedUserManager.class) {
				if(instance == null) {
					instance = new FixedUserManager();
				}
			}
		}
		return instance;
	}
	
	/*****************************************************
	아이디, ocode 입력으로 시청대상자의 정보 리턴.<p>
	<b>작성자</b> : 이희락<br>
	@return 시청대상자 정보<br>
	@param 아이디, ocode
******************************************************/
	public Vector getFixedUser(String vod_id, int ocode, String gubun) {
		gubun = com.vodcaster.utils.TextUtil.getValue(gubun);
		return sqlbean.selectFixedUserEntity(vod_id,ocode, gubun);
	}
	

	/*****************************************************
		ocode 대상 시청 전체 리스트를 이름순으로 출력.<p>
		<b>작성자</b> : 이희락<br>
		@return 시청 대상자 리스트<br>
		@param ocode, page
	******************************************************/
		public Hashtable getAlphaListALL(int ocode, int page, String gubun) {
			gubun = com.vodcaster.utils.TextUtil.getValue(gubun);
		    return sqlbean.selectUserListAll(ocode,page, gubun);
		}
		
		/*****************************************************
		아이디, ocode 입력으로 시청대상자의 정보 리턴.<p>
		<b>작성자</b> : 이희락<br>
		@return 시청대상자 정보<br>
		@param 아이디, ocode
	******************************************************/
		public FixedUserInfo getFixedUserInfo(String vod_id, int ocode,String gubun) {
//			String query = "select * from media_alpha where property_id = "+propertyID;
			vod_id = com.vodcaster.utils.TextUtil.getValue(vod_id);
			gubun = com.vodcaster.utils.TextUtil.getValue(gubun);
			FixedUserInfo bean = new FixedUserInfo();
			Vector vt = null;
			try{
				vt = sqlbean.selectFixedUserEntity(vod_id, ocode, gubun);
				//System.err.println(query);
				
				//System.err.println(vt);
				if(vt != null && vt.size()>0){
					//com.yundara.beans.BeanUtils.fill(bean, (Hashtable)vt.elementAt(0));
					try {
						String seq = String.valueOf(vt.elementAt(0));
			            String ocode2 = String.valueOf(vt.elementAt(1));
			            String id = String.valueOf(vt.elementAt(2));
			            String yn = String.valueOf(vt.elementAt(3));
			            String view_date = String.valueOf(vt.elementAt(4));
			            String gubun2 = String.valueOf(vt.elementAt(5));
			            	            
							
						bean.setSeq(Integer.parseInt(seq));
						bean.setOcode(Integer.parseInt(ocode2));
						bean.setVod_id(id);
						bean.setYn(yn);
						bean.setView_date(view_date);
						bean.setGubun(gubun2);
						
						
					} catch (Exception e) {
						System.err.println("get fixedUserinfo  : fill error"+e.getMessage());
						bean = null;
					}
				}else{
					//sqlbean.printLog("getAlpha : query result = null");
					bean = null;
				}
				
		    }catch(Exception ex){
		    	System.err.println("getAlpha error"+ex.getMessage());
				bean = null;
			}
		    return bean;
		}


		/*****************************************************
			아이디 입력받아 시청 대상자 정보 삭제.<p>
			<b>작성자</b> : 이희락<br>
			@return <br> 결과값 faile=-1, success= >0
			@param 아이디 
		******************************************************/
			public int deleteFixedUser(String id, int ocode, String gubun) {
				id = com.vodcaster.utils.TextUtil.getValue(id);
				gubun = com.vodcaster.utils.TextUtil.getValue(gubun);
				return sqlbean.deleteFixedUser(id, ocode, gubun);
			}
			
			/*****************************************************
			아이디 입력받아 시청 대상자 정보 삭제.<p>
			<b>작성자</b> : 이희락<br>
			@return <br> 결과값 faile=-1, success= >0
			@param 아이디 
		******************************************************/
			public int deleteFixedUser( int ocode, String gubun) {
				gubun = com.vodcaster.utils.TextUtil.getValue(gubun);
				return sqlbean.deleteFixedUser(ocode, gubun);
			}


			/*****************************************************
				시청 대상자 정보 수정.<p>
				<b>작성자</b> : 이희락<br>
				@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
				@param HttpServletRequest
			******************************************************/
				public int editFixedUser(HttpServletRequest req) throws Exception{
					
					FixedUserInfo bean = new FixedUserInfo();
					com.yundara.util.WebUtils.fill(bean, req);
					return sqlbean.modifyFixedUser(bean);
				}
}
