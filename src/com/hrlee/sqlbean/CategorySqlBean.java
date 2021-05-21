/*
 * Created on 2009. 7. 17
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.hrlee.sqlbean;

import dbcp.SQLBeanExt;
import java.util.*;
import javax.servlet.http.*;
import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
import com.vodcaster.multpart.MultipartRequest;
import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;
import com.vodcaster.sqlbean.DirectoryNameManager;

/**
 * @author Jong-Sung Park
 *
 * 카테고리관련 DB컨트롤 클래스
 */
public class CategorySqlBean  extends SQLBeanExt {
	
	public CategorySqlBean() {
		super();
	}


/************************************************  SELECT  ************************************************/

	/*****************************************************
		특정 검색에 의해 카테고리 전체 리스트 리턴.<p>
		<b>작성자</b> : 박종성<br>
		@return 검색된 카테고리 리스트<br>
		@param 검색 Query문
	******************************************************/
	public Vector selectCategoryListAll(String query){
 
		return querymanager.selectHashEntities(query);
		 
	}

	/*****************************************************
		카테고리정보 리턴<p>
		<b>작성자</b> : 박종성<br>
		@return 카테고리 정보<br>
		@param 카테고리 코드
		@see
	******************************************************/
	public Vector selectCategoryAll(String cuid){
		if (cuid != null && cuid.length() > 0 ) {
			String query = "select * from category where del_flag='N' and cuid=" +cuid;
			return 	querymanager.selectHashEntity(query);
		} else {
			return null;
		}
	}

	/*****************************************************
		카테고리 검색<p>
		<b>작성자</b> : 박종성<br>
		@return 검색된 카테고리정보를 백터로 반환<br>
		@param type(카테고리분류), code(카테고리코드)
	******************************************************/
	public Vector chkDuplicate(String type, String code){
		if (type != null && type.length() > 0 && code != null && code.length() > 0 ) {
		    String query = "select cuid from category where del_flag='N' and ctype='" +type+ "' and ccode='" +code+ "'";
		    return querymanager.selectEntity(query);
		} else {
			return null;
		}
	}

	/*****************************************************
		카테고리제목 리턴<p>
		<b>작성자</b> : 박종성<br>
		@return 카테고리 제목<br>
		@param ccode(카테고리코드), ctype(카테고리 타입)
		@see
	******************************************************/
	public Vector selectCategoryTitle(String ccode, String ctype) {
		if (ctype != null && ctype.length() > 0 && ccode != null && ccode.length() > 0 ) {
			String query = "select ctitle from category where del_flag='N' and ctype='" + ctype+ "' and ccode='" +ccode+ "'";
			return querymanager.selectEntity(query);
		} else {
			return null;
		}
	}

	
	public Vector selectCategoryMemo(String ccode, String ctype) {
		if (ctype != null && ctype.length() > 0 && ccode != null && ccode.length() > 0 ) {
			String query = "select memo from category where del_flag='N' and ctype='" + ctype+ "' and ccode='" +ccode+ "'";
			return querymanager.selectEntity(query);
		} else {
			return null;
		}
	}
	
	/*****************************************************
		카테고리 분류정보 리턴<p>
		<b>작성자</b> : 박종성<br>
		@return 카테고리 분류정보<br>
		@param ccode(카테고리코드), ctype(카테고리 타입)
		@see
	******************************************************/
	public Vector selectCategoryInfo(String ccode, String ctype) {
		if (ctype != null && ctype.length() > 0 && ccode != null && ccode.length() > 0 ) {
	        String query = "select cinfo from category where del_flag='N' and ctype='" + ctype+ "' and ccode='" +ccode+ "'";
	        return querymanager.selectEntity(query);
		} else {
			return null;
		}
	}


/************************************************  INSERT  ************************************************/

	/*****************************************************
		카테고리정보를 입력.<p>
		<b>작성자</b> : 박종성<br>
		@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
		@param CategoryInfoBean 빈즈
	******************************************************/
	public int insertCategory(CategoryInfoBean bean) throws Exception {
		
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_MEDIA;		//미디어화일 업로드경로
		if(String.valueOf(bean.getCtype()).equals("A"))
			UPLOAD_PATH += "/AOD";
		else if (String.valueOf(bean.getCtype()).equals("P"))
			UPLOAD_PATH += "/PHOTO";
		else if (String.valueOf(bean.getCtype()).equals("C"))
			UPLOAD_PATH += "/CONTENT";
		else 
			UPLOAD_PATH += "/VOD";
		
		
		String part_info = bean.getCinfo();
		String strtmp = "";
		int intInfo = 0;
		String query = "";
		
		if(part_info.equals("A")){
			
			try {
				Vector vr = null;
				
				//query = "select substring(ccode,1,3) from category where del_flag='N' and ctype='" + bean.getCtype()+ "' and cinfo='A' order by ccode desc";
				query = "select substring(ccode,1,3) from category where ctype='" + bean.getCtype()+ "' and cinfo='A' order by ccode desc";
				Vector v = querymanager.selectEntity(query);
				if(v != null  && v.size() > 0) {
					intInfo = Integer.parseInt(String.valueOf(v.elementAt(0)));
				}
				
				do {
					strtmp = "";
					intInfo++;
					strtmp += intInfo;
					strtmp = TextUtil.zeroFill(1,3,strtmp);	//앞에서 3번째까지 설정
					strtmp = TextUtil.zeroFill(0,12,strtmp); //뒤로 9번째까지 설정
					
					vr = this.chkDuplicate(bean.getCtype(), strtmp);

				}while (vr != null && vr.size() > 0);
				
			}catch(Exception e) {}

			java.io.File fPath = new java.io.File(UPLOAD_PATH + "/" + strtmp);
			if( !fPath.exists())  {
				fPath.mkdir();
				if (String.valueOf(bean.getCtype()).equals("P")){
					java.io.File fPath1 = new java.io.File(UPLOAD_PATH + "/" + strtmp+"/middle");
					java.io.File fPath2 = new java.io.File(UPLOAD_PATH + "/" + strtmp+"/small");
					fPath1.mkdir();
					fPath2.mkdir();
				} else {
						java.io.File fPath1 = new java.io.File(UPLOAD_PATH + "/" + strtmp+"/html");
						fPath1.mkdir();
				}
			}
			
		} else if(part_info.equals("B")) {
			
			try {
				Vector vr = null;
				String strFirst = (String.valueOf(bean.getCcode())).substring(0,3);
				
				query = "select substring(ccode,4,3) from category where del_flag='N' and ctype='" + bean.getCtype()+
						"' and cinfo='B' and ccode like '" +strFirst+ "%' order by ccode desc";
				Vector v = querymanager.selectEntity(query);
				if(v != null && v.size() > 0) {
					intInfo = Integer.parseInt(String.valueOf(v.elementAt(0)));
				}
				
				do {
					strtmp = "";
					intInfo++;
					strtmp += intInfo;
					strtmp = TextUtil.zeroFill(1,3,strtmp);
					strtmp = strFirst + strtmp;
					strtmp = TextUtil.zeroFill(0,12,strtmp);
					
					vr = this.chkDuplicate(bean.getCtype(), strtmp);
					
				}while (vr != null && vr.size() > 0);
				
			}catch(Exception e) {}
			
			
			String str = strtmp.substring(0,3);
			str = TextUtil.zeroFill(0,12,str);
			String strPath = UPLOAD_PATH + "/" + str;

			java.io.File fPathTmp = new java.io.File(strPath);
			if( !fPathTmp.exists())  {
				fPathTmp.mkdir();
				if (String.valueOf(bean.getCtype()).equals("P")){
					java.io.File fPath1 = new java.io.File(strPath+"/middle");
					fPath1.mkdir();
					java.io.File fPath2 = new java.io.File(strPath+"/small");
					fPath2.mkdir();
				}else { 
					java.io.File fPath1 = new java.io.File(UPLOAD_PATH + "/" + strtmp+"/html");
					fPath1.mkdir();
				}
			}
			
			
			java.io.File fPath = new java.io.File(strPath + "/" + strtmp);
			if( !fPath.exists())  {
				fPath.mkdir();
				if (String.valueOf(bean.getCtype()).equals("P")){
					java.io.File fPath1 = new java.io.File(strPath + "/" + strtmp+"/middle");
					fPath1.mkdir();
					java.io.File fPath2 = new java.io.File(strPath + "/" + strtmp+"/small");
					fPath2.mkdir();
				}else { 
					java.io.File fPath1 = new java.io.File(UPLOAD_PATH + "/" + strtmp+"/html");
					fPath1.mkdir();
				}
			}			
			
			
		} else if(part_info.equals("C")) {
			
			try {
				Vector vr = null;
				String strFirst = (String.valueOf(bean.getCcode())).substring(0,6);
				
				query = "select substring(ccode,7,3) from category where del_flag='N' and ctype='" + bean.getCtype()+
						"' and cinfo='C' and ccode like '" +strFirst+ "%' order by ccode desc";
				Vector v = querymanager.selectEntity(query);
				if(v != null && v.size() > 0) {
					intInfo = Integer.parseInt(String.valueOf(v.elementAt(0)));
				}
				
				do {
					strtmp = "";
					intInfo++;
					strtmp += intInfo;
					strtmp = TextUtil.zeroFill(1,3,strtmp);
					strtmp = strFirst + strtmp;
			   
					strtmp = TextUtil.zeroFill(0,12,strtmp);
					
//					System.out.println(strtmp);
					vr = this.chkDuplicate(bean.getCtype(), strtmp);

				}while (vr != null && vr.size() > 0);
				
			}catch(Exception e) {}
			
			
			String str = strtmp.substring(0,3);
			str = TextUtil.zeroFill(0,12,str);
			String strPath = UPLOAD_PATH + "/" + str;

			java.io.File fPathTmp = new java.io.File(strPath);
			if( !fPathTmp.exists())  {
				fPathTmp.mkdir();
				if (String.valueOf(bean.getCtype()).equals("P")){
					java.io.File fPath1 = new java.io.File(strPath+"/middle");
					 fPath1.mkdir();
					 java.io.File fPath2 = new java.io.File(strPath+"/small");
					 fPath2.mkdir();
				}else { 
					java.io.File fPath1 = new java.io.File(UPLOAD_PATH + "/" + strtmp+"/html");
					 fPath1.mkdir();
				}
			}
			
			
			String str2 = strtmp.substring(0,6);
			str2 = TextUtil.zeroFill(0,12,str2);
			strPath = strPath + "/" + str2;

			java.io.File fPathTmp2 = new java.io.File(strPath);
			if( !fPathTmp2.exists())  {
				fPathTmp2.mkdir();
				if (String.valueOf(bean.getCtype()).equals("P")){
					java.io.File fPath1 = new java.io.File(strPath+"/middle");
					 fPath1.mkdir();
					 java.io.File fPath2 = new java.io.File(strPath+"/small");
					 fPath2.mkdir();
				}else { 
					java.io.File fPath1 = new java.io.File(UPLOAD_PATH + "/" + strtmp+"/html");
					 fPath1.mkdir();
				}
			}
			
			
			java.io.File fPath = new java.io.File(strPath + "/" + strtmp);
			if( !fPath.exists())  {
				fPath.mkdir();
				if (String.valueOf(bean.getCtype()).equals("P")){
					java.io.File fPath1 = new java.io.File(strPath + "/" + strtmp+"/middle");
					 fPath1.mkdir();
					 java.io.File fPath2 = new java.io.File(strPath + "/" + strtmp+"/small");
					 fPath2.mkdir();
				}else { 
					java.io.File fPath1 = new java.io.File(UPLOAD_PATH + "/" + strtmp+"/html");
					 fPath1.mkdir();
				}
			}				 
			
		}else if(part_info.equals("D")) {
			
			try {
				Vector vr = null;
				String strFirst = (String.valueOf(bean.getCcode())).substring(0,9);
				
				query = "select substring(ccode,10,3) from category where del_flag='N' and ctype='" + bean.getCtype()+
						"' and cinfo='D' and ccode like '" +strFirst+ "%' order by ccode desc";
				Vector v = querymanager.selectEntity(query);
				if(v != null && v.size() > 0) {
					intInfo = Integer.parseInt(String.valueOf(v.elementAt(0)));
				}
				
				do {
					strtmp = "";
					intInfo++;
					strtmp += intInfo;
					strtmp = TextUtil.zeroFill(1,3,strtmp);
					strtmp = strFirst + strtmp;
					
					strtmp = TextUtil.zeroFill(0,12,strtmp);
					
//					System.out.println(strtmp);
					
					vr = this.chkDuplicate(bean.getCtype(), strtmp);

				}while (vr != null && vr.size() > 0);
				
			}catch(Exception e) {}					
			
			
			String str = strtmp.substring(0,3);
			str = TextUtil.zeroFill(0,12,str);
			String strPath = UPLOAD_PATH + "/" + str;

			java.io.File fPathTmp = new java.io.File(strPath);
			if( !fPathTmp.exists())  {
				fPathTmp.mkdir();
				if (String.valueOf(bean.getCtype()).equals("P")){
					java.io.File fPath1 = new java.io.File(strPath+"/middle");
					 fPath1.mkdir();
					 java.io.File fPath2 = new java.io.File(strPath+"/small");
					 fPath2.mkdir();
				}else { 
					java.io.File fPath1 = new java.io.File(UPLOAD_PATH + "/" + strtmp+"/html");
					 fPath1.mkdir();
				}
			}
			
			String str2 = strtmp.substring(0,6);
			str2 = TextUtil.zeroFill(0,12,str2);
			strPath = strPath + "/" + str2;

			java.io.File fPathTmp2 = new java.io.File(strPath);
			if( !fPathTmp2.exists())  {
				fPathTmp2.mkdir();
				if (String.valueOf(bean.getCtype()).equals("P")){
					java.io.File fPath1 = new java.io.File(strPath+"/middle");
					 fPath1.mkdir();
					 java.io.File fPath2 = new java.io.File(strPath+"/small");
					 fPath2.mkdir();
				}else { 
					java.io.File fPath1 = new java.io.File(UPLOAD_PATH + "/" + strtmp+"/html");
					 fPath1.mkdir();
				}
			}
			
			String str3 = strtmp.substring(0,9);
			str3 = TextUtil.zeroFill(0,12,str3);
			strPath = strPath + "/" + str3;

			java.io.File fPathTmp3 = new java.io.File(strPath);
			if( !fPathTmp3.exists())  {
				fPathTmp3.mkdir();
				if (String.valueOf(bean.getCtype()).equals("P")){
					java.io.File fPath1 = new java.io.File(strPath+"/middle");
					 fPath1.mkdir();
					 java.io.File fPath2 = new java.io.File(strPath+"/small");
					 fPath2.mkdir();
				}else { 
					java.io.File fPath1 = new java.io.File(UPLOAD_PATH + "/" + strtmp+"/html");
					 fPath1.mkdir();
				}
			}
			
			
			java.io.File fPath = new java.io.File(strPath + "/" + strtmp);
			if( !fPath.exists())  {
				fPath.mkdir();
				if (String.valueOf(bean.getCtype()).equals("P")){
					java.io.File fPath1 = new java.io.File(strPath + "/" + strtmp+"/middle");
					 fPath1.mkdir();
					 java.io.File fPath2 = new java.io.File(strPath + "/" + strtmp+"/small");
					 fPath2.mkdir();
				}else { 
					java.io.File fPath1 = new java.io.File(UPLOAD_PATH + "/" + strtmp+"/html");
					 fPath1.mkdir();
				}
			}				 
			
		}
		
		query = "insert into category (ctype,ccode,cparent_code,ctitle,clevel,cinfo,openflag, memo) values ('" +
				bean.getCtype()				+ "','" +
				strtmp						+ "',";
				if(part_info.equals("A")){				
					query +=    "null,'" ;
				}else {
					query +=	"'"  +bean.getCparent_code()		+ "','" ;
				}
				query +=	bean.getCtitle().replace("'","''")		+ "',"	+
				bean.getClevel()			+ ",'"	+
				bean.getCinfo()				+ "','" +
				bean.getOpenflag()				+ "','" +
				bean.getMemo()			+ "')";
		
	
		return querymanager.updateEntities(query);

	}


/************************************************  UPDATE  ************************************************/

	/*****************************************************
		카테고리정보 수정<p>
		<b>작성자</b> : 박종성<br>
		@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
		@param CategoryInfoBean 빈즈
		@see
	******************************************************/
	public int updateCategory(CategoryInfoBean bean) throws Exception{
	    
	    String query = "";
	    String sub_query = "";
	    int intInfo = 0;
	    String strtmp = "";
	    
	    if(String.valueOf(bean.getCinfo()).equals("A")) {
	        
	        query = "update category set " +
	        		" ctitle='" +bean.getCtitle()+ "', " +
	        		" clevel=" +bean.getClevel()+ ", " +
	        		" openflag='"+bean.getOpenflag()+"', " +
	        		" memo ='"+bean.getMemo()+"' " +
    				" where cuid=" + bean.getCuid();
	        
			//System.err.println("query == " + query);	        
	        
	    }else if(String.valueOf(bean.getCinfo()).equals("B")) {
	        
	        strtmp = "";
	        
	        try {
	            
	            if(!( bean.getCcode().equals( bean.getOrg_category2() ) ) && !( bean.getCcategory1().equals( bean.getOrg_category1() ) )) {
	                
	                Vector vr = new Vector();
	                
	                String strFirst = String.valueOf(bean.getCparent_code()).substring(0,3);
	                
	                sub_query = "select substring(ccode,4,3) from category where del_flag='N' and ctype='" + bean.getCtype()+
	                			"' and cinfo='B' and ccode like '" +strFirst+ "%' order by ccode desc";
	                
	                Vector v = querymanager.selectEntity(query);
	                
	                if(v != null && v.size() > 0) {
	                    intInfo = Integer.parseInt(String.valueOf(v.elementAt(0)));
	                }
	                
	                do {
	                    strtmp = "";
	                    intInfo++;
	                    strtmp += intInfo;
	                    strtmp = TextUtil.zeroFill(1,3,strtmp);
	                    strtmp = strFirst + strtmp;
	                    strtmp = TextUtil.zeroFill(0,9,strtmp);
	                    
	                    vr = this.chkDuplicate(bean.getCtype(), strtmp);
	                
	                }while (vr !=  null && vr.size() > 0);
	             
	                
	     	       query = "update category set" +
	     	       		" ccode='" +strtmp+ "', " +
	     	       		" cparent_code='" +bean.getCparent_code()+"', " +
 	       				" ctitle='" +bean.getCtitle().replace("'","''")+ "', " +
 	       				" memo ='" +bean.getMemo().replace("'","''")+ "', " +
						" clevel=" +bean.getClevel()+ ", " +
						" openflag='"+bean.getOpenflag()+"'" +
						" where cuid=" + bean.getCuid();
	     	       
	            } else {
	                
	                query = "update category set " +
	                		" ctitle='" +bean.getCtitle().replace("'","''")+ "', " +
	                		" memo='" +bean.getMemo().replace("'","''")+ "', " +
	                		" clevel=" +bean.getClevel()+ ", " +
	                		" openflag='"+bean.getOpenflag()+"' " +
	                		" where cuid=" + bean.getCuid();
	                
	            }
	       
	       }catch(Exception e) {
	    	   System.out.println(e);
	       }
	       
			//System.err.println("query2 == " + query);
			
	    }else if(String.valueOf(bean.getCinfo()).equals("C")) {
	        
	        strtmp = "";
	        
	        try {
	            
	            if(!( bean.getCcode().equals( bean.getOrg_category3() ) ) && !( bean.getCcategory1().equals( bean.getOrg_category1() ) ) && !( bean.getCcategory1().equals( bean.getOrg_category1() ) )) {
	                
		            
		            Vector vr = new Vector();

		            String strFirst = String.valueOf(bean.getCparent_code()).substring(0,6);
		            
		            sub_query = "select substring(ccode,7,3) from category where del_flag='N' and ctype='" + bean.getCtype()+
			            		"' and cinfo='C' and ccode like '" +strFirst+ "%' order by ccode desc";
		            
		            
		          //  System.err.println("sub_query ===> " + sub_query);
		                
		           Vector v = querymanager.selectEntity(query);
		           
		           if(v != null && v.size() > 0) {
		               intInfo = Integer.parseInt(String.valueOf(v.elementAt(0)));
		           }
		           
		           do {
		               strtmp = "";
		               intInfo++;
		               strtmp += intInfo;
		               strtmp = TextUtil.zeroFill(1,3,strtmp);
		               strtmp = strFirst + strtmp;
		               
		               vr = this.chkDuplicate(bean.getCtype(), strtmp);
		           
		           }while (vr != null && vr.size() > 0);
	                
			       query = "update category set " +
			       		" ccode='" +strtmp+ "', " +
			       		" cparent_code='" +bean.getCparent_code()+"', " +
			       		" ctitle='" +bean.getCtitle().replace("'","''")+ "', " +
			       		" memo='" +bean.getMemo().replace("'","''")+ "', " +
	       				" clevel=" +bean.getClevel()+ ", " +
	       				" openflag='"+bean.getOpenflag()+"' " +
	       				" where cuid=" + bean.getCuid();
	                
	            } else {
	                
	                query = "update category set " +
	                		" ctitle='" +bean.getCtitle().replace("'","''")+ "', " +
	                		" memo='" +bean.getMemo().replace("'","''")+ "', " +
            				" clevel=" +bean.getClevel()+ ", " +
    						" openflag='"+bean.getOpenflag()+"' " +
    						" where cuid=" + bean.getCuid();
	            }
	            
	            
	       }catch(Exception e) {
	    	   System.out.println(e);
	       }
	       

	    }else if(String.valueOf(bean.getCinfo()).equals("D")) {
	        
	        strtmp = "";
	        
	        try {
	            
	            if(!( bean.getCcode().equals( bean.getOrg_category4() ) ) 
	            		&& !( bean.getCcategory1().equals( bean.getOrg_category1() ) ) 
	            		&& !( bean.getCcategory1().equals( bean.getOrg_category1() ) )) {
	                
		            
		            Vector vr = new Vector();

		            String strFirst = String.valueOf(bean.getCparent_code()).substring(0,9);
		            
		            sub_query = "select substring(ccode,10,3) from category where del_flag='N' and ctype='" + bean.getCtype()+
			            		"' and cinfo='C' and ccode like '" +strFirst+ "%' order by ccode desc";
		            
		            
		          //  System.err.println("sub_query ===> " + sub_query);
		                
		           Vector v = querymanager.selectEntity(query);
		           
		           if(v != null && v.size() > 0) {
		               intInfo = Integer.parseInt(String.valueOf(v.elementAt(0)));
		           }
		           
		           do {
		               strtmp = "";
		               intInfo++;
		               strtmp += intInfo;
		               strtmp = TextUtil.zeroFill(1,3,strtmp);
		               strtmp = strFirst + strtmp;
		               
		               vr = this.chkDuplicate(bean.getCtype(), strtmp);
		           
		           }while (vr != null && vr.size() > 0);
	                
			       query = "update category set " +
			       		" ccode='" +strtmp+ "', " +
						" cparent_code='" +bean.getCparent_code()+"', " +
						" ctitle='" +bean.getCtitle().replace("'","''")+ "', " +
						" memo='" +bean.getMemo().replace("'","''")+ "', " +
						" clevel=" +bean.getClevel()+ ", " +
   						" openflag='"+bean.getOpenflag()+"' " +
   						" where cuid=" + bean.getCuid();
            
	            } else {
	                
	                query = "update category set " +
	                		" ctitle='" +bean.getCtitle().replace("'","''")+ "', " +
	                		" memo='" +bean.getMemo().replace("'","''")+ "', " +
            				" clevel=" +bean.getClevel()+ ", " +
    						" openflag='"+bean.getOpenflag()+"' " +
    						" where cuid=" + bean.getCuid();
	            }
	            
	            
	       }catch(Exception e) {
	    	   System.out.println(e);
	       }
	       

	    }
//		System.out.println(query);

		return querymanager.updateEntities(query);
	}
	
	public int updateQuery(String query) {
		return querymanager.updateEntities(query);
	}

/************************************************  DELETE  ************************************************/

	/*****************************************************
		카테고리 삭제<p>
		<b>작성자</b> : 박종성<br>
		@return 성공:삭제된 벡터, 실패:null<br>
		@param 카테고리코드
	******************************************************/
	public Vector deleteCategory(String uid) {
		
		if (uid != null && uid.length()  > 0) {
	    
	    String ccode = "";
	    String cinfo = "";
	    String ctype = "";
	    String cond = "";
	    String query = "select cinfo, ccode, ctype from category where del_flag='N' and cuid=" +uid;
	    Vector v = querymanager.selectEntity(query);

	    try {
	        
	        if(v != null && v.size() > 0) {
		        cinfo = String.valueOf(v.elementAt(0));
		        ccode = String.valueOf(v.elementAt(1));
		        ctype = String.valueOf(v.elementAt(2));
		        
		    //    System.err.println("Category INFO cinfo : " +cinfo);
		    //    System.err.println("Category CODE ccode : " +ccode);
		        
		        
		        // 대분류시 서브카테고리가 있는지 검사.
		        if(cinfo.equals("A")) {
		            cond = " and ccode like '" +ccode.substring(0,3)+ "%'";
		        }else if(cinfo.equals("B")) {
		            cond = " and ccode like '" +ccode.substring(0,6)+ "%'";
		        }else if(cinfo.equals("C")) {
		            cond = " and ccode like '" +ccode.substring(0,9)+ "%'";
	        	}else if(cinfo.equals("D")) {
		            cond = " and ccode like '" +ccode+ "%'";
	        	}
		        
		        String query2 = "select * from category where del_flag='N' and ccode!='" +ccode+ "' and ctype='" +ctype+ "'" + cond;
		        
		        Vector v2 = querymanager.selectEntities(query2);
		        
		        if(v2 != null && v2.size() > 0) {
		            //System.err.println("서브가 존재하는 경우 삭제 하려함 ");
		            
		            return null;
		        } else
		            query = "update category set del_flag='Y' where cuid=" + uid;
		        
		    } else
		        return null;
		    
	    } catch(Exception e) {
	        
	        System.err.println("deleteCategory ex : " + e);
	    }
	    
		return querymanager.executeQuery(query, "");
		} else {
			return null;
		}
	}
}
