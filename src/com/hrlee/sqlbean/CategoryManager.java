/*
 * Created on 2009. 7. 17
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.hrlee.sqlbean;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
/**
 * @author Jong-Sung Park
 *
 * VOD카테고리 관리 클래스
 */
public class CategoryManager {
	private static CategoryManager instance;
	
	private CategorySqlBean sqlbean = null;
	
	private CategoryManager() {
		sqlbean = new CategorySqlBean();
		//System.err.println("CategoryManager 인스턴스 생성");
	}
	
	public static CategoryManager getInstance() {
		if(instance == null) {
			synchronized(CategoryManager.class) {
				if(instance == null) {
					instance = new CategoryManager();
				}
			}
		}
		return instance;
	}

/************************************************  SELECT  ************************************************/

	/*****************************************************
		검색된 카테고리 전체 리스트 출력<p>
		<b>작성자</b> : 최희성<br>
		@return 검색된 카테고리 리스트(order by clevel,ctitle,ccode)<br>
		@param ctype(분류), cinfo(레벨)
		@see /admin/category/frm_categoryUpdate.jsp
	******************************************************/
	public Vector getCategoryListALL2(String type, String info) {
		type = com.vodcaster.utils.TextUtil.getValue(type);
		info = com.vodcaster.utils.TextUtil.getValue(info);
		String query = "";
		
		if(type != null && type.length() > 0 && info != null && info.length()> 0 && !type.equals("") && !info.equals("")) {
			query = "select * from category where del_flag='N' and ctype='" +type+ "' and cinfo='" +info+ "' order by ccode,clevel,ctitle";
		
			return sqlbean.selectCategoryListAll(query);

		} else
			return null;
	}
	public Vector getCategoryListALL3(String type, String info) {
		type = com.vodcaster.utils.TextUtil.getValue(type);
		info = com.vodcaster.utils.TextUtil.getValue(info);
		String query = "";
		
		if(type != null && type.length() > 0 && info != null && info.length()> 0 && !type.equals("") && !info.equals("")) {
			query = "select * from category where del_flag='N' and openflag='Y' and ctype='" +type+ "' and cinfo='" +info+ "' order by ccode,clevel,ctitle";
		
			return sqlbean.selectCategoryListAll(query);

		} else
			return null;
	}

	/*****************************************************
		카테고리정보 리턴<p>
		<b>작성자</b> : 박종성<br>
		@return 카테고리 백터<br>
		@param 카테고리코드
		@see
	******************************************************/
	public Vector getCategoryInfo(String cuid) {
		cuid = com.vodcaster.utils.TextUtil.getValue(cuid);
		 if (cuid != null && cuid.length() > 0) {
		return sqlbean.selectCategoryAll(cuid);
		 } else {
			 return null;
		 }
	}


	/*****************************************************
		검색된 카테고리 전체 리스트 출력<p>
		<b>작성자</b> : 박종성<br>
		@return 검색된 카테고리 리스트(order by clevel,ctitle,ccode,cinfo)<br>
		@param type(분류), info(레벨), category(카테고리코드)
	******************************************************/
	public Vector getCategoryListALL2(String type, String info, String category) {
		type = com.vodcaster.utils.TextUtil.getValue(type);
		info = com.vodcaster.utils.TextUtil.getValue(info);
		category = com.vodcaster.utils.TextUtil.getValue(category);
		String query = "";
		
		if(info != null && info.length() > 0 && info.equals("B") && category != null && category.length() >= 3)
			category = category.substring(0,3);
		else if(info != null && info.length() > 0 && info.equals("C") && category != null && category.length() >= 6)
			category = category.substring(0,6);
		else if(info != null && info.length() > 0 && info.equals("D") && category != null && category.length() >= 9)
			category = category.substring(0,9);
		
		if(type != null && type.length() > 0 && info != null && info.length()> 0 && category != null && category.length() > 0 && !type.equals("") && !info.equals("") && !category.equals("")) {
			query = "select * from category where del_flag='N' and ctype='" +type+ "' and cinfo='" +info+ "' and ccode like '" +
					category + "%' order by ccode,clevel,ctitle,cinfo";
			return sqlbean.selectCategoryListAll(query);
		} else
			return null;
	}
	
	public Vector getCategoryListALL3(String type, String info, String category) {
		type = com.vodcaster.utils.TextUtil.getValue(type);
		info = com.vodcaster.utils.TextUtil.getValue(info);
		category = com.vodcaster.utils.TextUtil.getValue(category);
		String query = "";
		
		if(info != null && info.length() > 0 && info.equals("B") && category != null && category.length() >= 3)
			category = category.substring(0,3);
		else if(info != null && info.length() > 0 && info.equals("C") && category != null && category.length() >= 6)
			category = category.substring(0,6);
		else if(info != null && info.length() > 0 && info.equals("D") && category != null && category.length() >= 9)
			category = category.substring(0,9);
		
		if(type != null && type.length() > 0 && info != null && info.length()> 0 && category != null && category.length() > 0 && !type.equals("") && !info.equals("") && !category.equals("")) {
			query = "select * from category where del_flag='N' and openflag='Y' and ctype='" +type+ "' and cinfo='" +info+ "' and ccode like '" +
					category + "%' order by ccode,clevel,ctitle,cinfo";
			return sqlbean.selectCategoryListAll(query);
		} else
			return null;
	}

		/*****************************************************
		카테고리코드를 특정형식으로 분리<p>
		<b>작성자</b> : 박종성<br>
		@return분리된 대,중,소 카테고리 코드 3개를 벡터로 반환<br>
		@param 카테고리코드, 카테고리분류
		@see
	******************************************************/
	public Vector separateCode(String ccode, String info) {
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		info = com.vodcaster.utils.TextUtil.getValue(info);
		Vector v = new Vector();
		String strtmp1 = "";
		String strtmp2 = "";
		String strtmp3 = "";
		String strtmp4 = "";
		
		try {
			
			if(info != null && info.equals("A")) {
				strtmp1 = ccode;
				strtmp2 = "";
				strtmp3 = "";
			}else if(info != null && info.equals("B") && ccode != null && ccode.length() >= 3) {
				strtmp1 = ccode.substring(0,3);
				strtmp1 = TextUtil.zeroFill(0,12,strtmp1); //뒤로 12번째까지 설정
				strtmp2 = ccode;
				strtmp3 = "";  
			}else if(info != null && info.equals("C")&& ccode != null && ccode.length() >= 6) {
				strtmp1 = ccode.substring(0,3);
				strtmp1 = TextUtil.zeroFill(0,12,strtmp1); //뒤로 12번째까지 설정
				strtmp2 = ccode.substring(0,6);
				strtmp2 = TextUtil.zeroFill(0,12,strtmp2); //뒤로 12번째까지 설정
				strtmp3 = ccode;	 
			}else if(info != null && info.equals("D")&& ccode != null && ccode.length() >= 9) {
				strtmp1 = ccode.substring(0,3);
				strtmp1 = TextUtil.zeroFill(0,12,strtmp1); //뒤로 12번째까지 설정
				strtmp2 = ccode.substring(0,6);
				strtmp2 = TextUtil.zeroFill(0,12,strtmp2); //뒤로 12번째까지 설정
				strtmp3 = ccode.substring(0,9);
				strtmp3 = TextUtil.zeroFill(0,12,strtmp3); //뒤로 12번째까지 설정
				strtmp4 = ccode;	 
			}
		
		}catch(Exception e) {}
		
		v.add(strtmp1);
		v.add(strtmp2);
		v.add(strtmp3);
		v.add(strtmp4);
		
		
		return v;
		
	}

	/*****************************************************
		 카테고리코드 제목 리턴<p>
		<b>작성자</b> : 박종성<br>
		@return 카테고리타이틀을 문자열로 반환 (예: 영화 > 액션 > 무협)<br>
		@param code(카테고리코드), ctype(카테고리타입:대중소)
		@see
	******************************************************/
	public String getCategoryName(String ccode, String ctype) {
		
		String strtmp = "";
		Vector rt1, rt2, rt3, rt4 = null;
		String category1, category2,category3 = "";
		Vector rtnV = null;
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		ctype = com.vodcaster.utils.TextUtil.getValue(ctype);
		
		try {

			if(ccode != null && !ccode.equals("") && ccode.length() == 12 ) {

				Vector v = sqlbean.selectCategoryInfo(ccode, ctype);
				String cinfo = String.valueOf(v.elementAt(0));

				// 대분류 카테고리명 추출
				if(cinfo.equals("A") || cinfo.equals("B") || cinfo.equals("C") || cinfo.equals("D")) {
					category1 = ccode.substring(0,3);
					category1 = TextUtil.zeroFill(0,12,category1); //뒤로 9번째까지 설정
					rt1 = sqlbean.selectCategoryTitle(category1, ctype);
					strtmp = String.valueOf(rt1.elementAt(0));
				}

				// 중분류 카테고리명 추출
				if(cinfo.equals("B") || cinfo.equals("C") || cinfo.equals("D")) {
					category2 = ccode.substring(0,6);
					category2 = TextUtil.zeroFill(0,12,category2); //뒤로 9번째까지 설정
					rt2 = sqlbean.selectCategoryTitle(category2, ctype);
					strtmp = strtmp + " > " + String.valueOf(rt2.elementAt(0));
				}


				// 소분류 카테고리명 추출
				if(cinfo.equals("C") || cinfo.equals("D")) {
					category3 = ccode.substring(0,9);
					category3 = TextUtil.zeroFill(0,12,category3); //뒤로 9번째까지 설정
					rt3 = sqlbean.selectCategoryTitle(category3, ctype);
					strtmp = strtmp + " > " + String.valueOf(rt3.elementAt(0));
				}
				
			 // 세분류 카테고리명 추출
				if(cinfo.equals("D")) {
					rt4 = sqlbean.selectCategoryTitle(ccode, ctype);
					strtmp = strtmp + " > " + String.valueOf(rt4.elementAt(0));
				}


			}
			
		}catch(Exception e) {}
			
		
		return strtmp;
			
	}
	
	/*****************************************************
		 카테고리코드 제목 리턴<p>
		<b>작성자</b> : 최희성<br>
		@return 카테고리타이틀을 문자열로 반환 (예: 무협)<br>
		@param code(카테고리코드), ctype(카테고리타입:대중소)
		@see
	******************************************************/
	public String getCategoryOneName(String ccode, String ctype) {

	    String strtmp = "";
	    ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		ctype = com.vodcaster.utils.TextUtil.getValue(ctype);
	    try {

	        if(ctype != null && ctype.length() > 0 && ccode != null && !ccode.equals("") && ccode.length() == 12) {

               Vector v = sqlbean.selectCategoryTitle(ccode, ctype);
               if(v != null && v.size()>0){
               	strtmp = String.valueOf(v.elementAt(0));
               }
           }

	    }catch(Exception e) {
	    	System.err.println("getCategoryOneName ex : " + e);
	    }
       return strtmp;
   }

	
	public String getCategoryOneName_like(String ccode, String ctype) {

	    String strtmp = "";
	    ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		ctype = com.vodcaster.utils.TextUtil.getValue(ctype);
	    try {
	    	 if (ccode != null && !ccode.equals("") && ccode.length() < 12) {
	    		 for (int i =ccode.length(); i < 12; i ++) {
	    			 ccode +="0";
	    		 }
	    	 }

	        if(ctype != null && ctype.length() > 0 && ccode != null && !ccode.equals("") && ccode.length() == 12) {

               Vector v = sqlbean.selectCategoryTitle(ccode, ctype);
               if(v != null && v.size()>0){
               	strtmp = String.valueOf(v.elementAt(0));
               }
           }

	    }catch(Exception e) {
	    	System.err.println("getCategoryOneName ex : " + e);
	    }
       return strtmp;
   }
	
	public String getCategoryMemo(String ccode, String ctype) {

	    String strtmp = "";
	    ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		ctype = com.vodcaster.utils.TextUtil.getValue(ctype);
	    try {
	    	 if (ccode != null && !ccode.equals("") && ccode.length() < 12) {
	    		 for (int i =ccode.length(); i < 12; i ++) {
	    			 ccode +="0";
	    		 }
	    	 }

	        if(ctype != null && ctype.length() > 0 && ccode != null && !ccode.equals("") && ccode.length() == 12) {

               Vector v = sqlbean.selectCategoryMemo(ccode, ctype);
               if(v != null && v.size()>0){
               	strtmp = String.valueOf(v.elementAt(0));
               }
           }

	    }catch(Exception e) {
	    	System.err.println("getCategoryOneName ex : " + e);
	    }
       return strtmp;
   }
	
/************************************************  INSERT  ************************************************/

	/*****************************************************
		카테고리 생성<p>
		<b>작성자</b> : 박종성<br>
		@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
		@param HttpServletRequest
		@see /admin/category/proc_catregoryAdd.jsp
	******************************************************/
		public int createCategory(HttpServletRequest req) throws Exception {
			
			CategoryInfoBean bean = new CategoryInfoBean();
			com.yundara.util.WebUtils.fill(bean, req);
			
			if(bean.getCcategory1() != null && bean.getCcategory1().equals("")) {
				bean.setCinfo("A");
			}else if(bean.getCcategory1() != null && bean.getCcategory2() != null && !bean.getCcategory1().equals("") && bean.getCcategory2().equals("")){
				bean.setCinfo("B");
			}else if(bean.getCcategory1() != null && bean.getCcategory2() != null && !bean.getCcategory1().equals("") && !bean.getCcategory2().equals("") && bean.getCcategory3().equals("")){
				bean.setCinfo("C");
			}else if(bean.getCcategory1() != null && bean.getCcategory2() != null &&  bean.getCcategory3() != null &&
					!bean.getCcategory1().equals("") && !bean.getCcategory2().equals("") && !bean.getCcategory3().equals("")){
				bean.setCinfo("D");
			}
			
			bean.setCtitle(bean.getCtitle());
			
			//parent_code 추출
			// ccode값 추출 
			
			String strtmp = "";		
			if(bean.getCinfo() != null && bean.getCinfo().equals("D")){
				bean.setCparent_code(bean.getCcategory3());
				strtmp = String.valueOf(bean.getCcategory3());
				
			}else if(bean.getCinfo() != null && bean.getCinfo().equals("C")){
				bean.setCparent_code(bean.getCcategory2());
				strtmp = String.valueOf(bean.getCcategory2());
				
			}else if(bean.getCinfo() != null && bean.getCinfo().equals("B")){
				bean.setCparent_code(bean.getCcategory1());
				strtmp = String.valueOf(bean.getCcategory1());
			}
			
			bean.setCcode(strtmp);
			 

			return sqlbean.insertCategory(bean);
		}
/************************************************  UPDATE  ************************************************/

	/*****************************************************
		카테고리 수정<p>
		<b>작성자</b> : 최희성<br>
		@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
		@param HttpServletRequest
		@see /admin/category/proc_catregoryUpdate.jsp
	******************************************************/
	public int updateCategory(HttpServletRequest req) throws Exception {
		
		CategoryInfoBean bean = new CategoryInfoBean();
		com.yundara.util.WebUtils.fill(bean, req);
		if(bean.getCcategory1()!= null && bean.getCcategory2()!= null && bean.getCcategory3()!= null  && bean.getCcategory4()!= null
				&& !bean.getCcategory1().equals("") && !bean.getCcategory2().equals("") && !bean.getCcategory3().equals("") && bean.getCcategory4().equals("")) {
			bean.setCinfo("D");
		}else if(bean.getCcategory1()!= null && bean.getCcategory2()!= null && bean.getCcategory3()!= null 
				&& !bean.getCcategory1().equals("") && bean.getCcategory2().equals("") && bean.getCcategory3().equals("")) {
			bean.setCinfo("B");
		}else if(bean.getCcategory1()!= null && bean.getCcategory2()!= null && bean.getCcategory3()!= null 
				&& !bean.getCcategory1().equals("") && !bean.getCcategory2().equals("") && bean.getCcategory3().equals("")){
			bean.setCinfo("C");
		}else 
			bean.setCinfo("A");
		
		bean.setCtitle(bean.getCtitle());
		
		//parent_code 추출
		// ccode값 추출 
		if(bean.getCinfo() != null && bean.getCinfo().equals("D")){
			bean.setCparent_code(bean.getCcategory3());
			
		}else if(bean.getCinfo() != null && bean.getCinfo().equals("C")){
			bean.setCparent_code(bean.getCcategory2());
			
		}else if(bean.getCinfo() != null && bean.getCinfo().equals("B")){
			bean.setCparent_code(bean.getCcategory1());
		}else {
			bean.setCparent_code("");
		}
		if(sqlbean.updateCategory(bean) >0){
			CategoryOpenflagUpdate(bean.getCcode(), bean.getOpenflag());
			return 1;
		}else{
			return -1;
		}
		//return sqlbean.updateCategory(bean);
	}
	
	public int CategoryOpenflagUpdate(String ccode, String openflag) {
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		openflag = com.vodcaster.utils.TextUtil.getValue(openflag);
		
		if (openflag != null && openflag.length() > 0) {
		
			String code="999999999999";
			if (ccode != null && ccode.length() >= 12) {
				if(ccode.substring(3,12).equals("000000000")) {
					code = ccode.substring(0,3);
				} else if(ccode.substring(6,12).equals("000000")) {
					code = ccode.substring(0,6);
				} else if(ccode.substring(9,12).equals("000")) {
					code = ccode.substring(0,9);
				} else {
					code = ccode;
				}
			}
			
			String query = "update category set openflag='"+openflag+"' where ccode like '"+code+"%' ";
	//		System.out.println(query);
			if(sqlbean.updateQuery(query) >0){
				return 1;
			}else{
				return -1;
			}
		} else {
			return -1;
		}
	}
	
	


/************************************************  DELETE  ************************************************/

	/*****************************************************
		카테고리 삭제<p>
		<b>작성자</b> : 박종성<br>
		@return 성공:vector, 실패:null<br>
		@param 카테고리 코드번호
	******************************************************/
	public Vector deleteCategory(String cuid) {
		cuid = com.vodcaster.utils.TextUtil.getValue(cuid);
		if (cuid != null && cuid.length() > 0) {
			return sqlbean.deleteCategory(cuid);
		} else {
			return null;
		}
	}
	
	

}
