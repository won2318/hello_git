/*
 * Created on 2005. 1. 13
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.hrlee.sqlbean;


import javax.servlet.http.*;
import dbcp.SQLBeanExt;

import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
import com.yundara.util.FileUtil;
import com.yundara.util.PageBean;
import com.vodcaster.sqlbean.DirectoryNameManager;
import com.vodcaster.multpart.MultipartRequest;
import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
import java.io.*;
import java.util.*;



/**
 * @author Choi Hee-Sung
 *
 * �̵�� DB QUERY Ŭ����
 */
public class AddContentSqlBean  extends SQLBeanExt {

    public AddContentSqlBean() {
		super();
	}




	///////////
	//  ����
	//  vod ���� ����
	//////////

public int updateVod(HttpServletRequest req, String ctype) throws Exception 
	{

		// �⺻�������� �ʱ�ȭ �Ѵ�.
		int ocode    	=  0;
		String otitle  = "";

		String oplay_time    =  "";
		String ccode = "";
		String ocontents  = "";
//		int ohit  = 0;
		String oquality  = "";
		int olevel  = 0;
		String oflag  = "";
		String ofilename  = "";
//		String owdate  = "";

		String ohtml_flag  = "2";
//		String oimagefile1  = "";

//		String attach_file  = "";
		String omedia_type  = "";
 
		String ofilename2  = "";
		String omedianame  = "";
		String omedianame2  = "";
//		int property_id  = 0;
		String user_id  = "";
		String user_pwd  = "";
		String openflag  = "";
		String group_id = "";
		String mk_date  = "";
//		int point = 0;
//		String file_pdf="";
//		String file_html="";


		String query = "";
		int rtn = 0;
		
		//�Ķ��Ÿ ���� �������� üũ�Ѵ�.
		
		if(req.getParameter("otitle") !=null && req.getParameter("otitle").length()>0) {
			otitle = req.getParameter("otitle").replace("'","''");
			otitle = otitle.replace("#","&#35;").replace("&","&#38;").replace("<","&lt;").replace(">","&gt;").replace("(","&#40;").replace(")","&#41;");
		}
		if(req.getParameter("oplay_time") !=null && req.getParameter("oplay_time").length()>0 ) 
			oplay_time	=  req.getParameter("oplay_time").trim().replace("'","''");

		if(req.getParameter("ccode") !=null && req.getParameter("ccode").length()>0) {
			ccode = req.getParameter("ccode").replace("'","''");
		}
		if(req.getParameter("ocontents") !=null && req.getParameter("ocontents").length()>0) {
			ocontents = req.getParameter("ocontents").replace("'","''");
			ocontents = ocontents.replace("#","&#35;").replace("&","&#38;").replace("<","&lt;").replace(">","&gt;").replace("(","&#40;").replace(")","&#41;");
		}

 
					
		if ( req.getParameter("ocode") !=null && req.getParameter("ocode").length()>0 )
		{
			ocode	=  Integer.parseInt(String.valueOf(req.getParameter("ocode")));
		}

			 query ="update vod_media set "+
							"otitle 			= '" + otitle + "', "+
							"oplay_time 		= '" + oplay_time + "', "+
							"ccode 			= '" + ccode +"', "+
							"ocontents 			= '" + ocontents +"' " ;

			if(req.getParameter("oquality") !=null && req.getParameter("oquality").length()>0 )  {
					oquality	=  req.getParameter("oquality").trim().replace("'","''");
					query = query+	",oquality 			= '" + oquality +"' " ;
			}
				if(req.getParameter("oflag") !=null && req.getParameter("oflag").length()>0 ) {
					oflag	=  req.getParameter("oflag").trim().replace("'","''");
					query = query+	",oflag				= '" + oflag +"' ";
			}
				if(req.getParameter("ofilename") !=null && req.getParameter("ofilename").length()>0 ) {
					ofilename	=  req.getParameter("ofilename").trim().replace("'","''");
					query = query+	",ofilename 			= '" + ofilename +"' ";
			}
				if(req.getParameter("oview_flag") !=null && req.getParameter("oview_flag").length()>0 ) {

				if(req.getParameter("ohtml_flag") !=null && req.getParameter("ohtml_flag").length()>0 ) {
					ohtml_flag	=  req.getParameter("ohtml_flag").trim().replace("'","''");
					query = query+	",ohtml_flag 		=  '" + ohtml_flag + "' " ;
				}
				if(req.getParameter("omedia_type") !=null && req.getParameter("omedia_type").length()>0 ) {
					omedia_type	=  req.getParameter("omedia_type").trim().replace("'","''");
					query = query+	",omedia_type        =  '" + omedia_type + "' " ;
				}
				if(req.getParameter("ofilename2") !=null && req.getParameter("ofilename2").length()>0 ) {
					ofilename2	=  req.getParameter("ofilename2").trim().replace("'","''");
					query = query+	",ofilename2         =  '" + ofilename2 + "' " ;
				}
				if(req.getParameter("omedianame") !=null && req.getParameter("omedianame").length()>0 ) {
					omedianame	=  req.getParameter("omedianame").trim().replace("'","''");
					query = query+	",omedianame					= '" + omedianame + "' " ;
				}
				if(req.getParameter("omedianame2") !=null && req.getParameter("omedianame2").length()>0 ) {
					omedianame2	=  req.getParameter("omedianame2").trim().replace("'","''");
					query = query+	",omedianame2				= '" + omedianame2 + "' " ;
				}
				if(req.getParameter("user_id") !=null && req.getParameter("user_id").length()>0 ) {
					user_id	=  req.getParameter("user_id").trim().replace("'","''");
					query = query+	",user_id					= '" + user_id + "' " ;
				}
				if(req.getParameter("user_pwd") !=null && req.getParameter("user_pwd").length()>0 ) {
					user_pwd	=  req.getParameter("user_pwd").trim().replace("'","''");
					query = query+	",user_pwd					= '" + user_pwd + "' " ;
				}
				if(req.getParameter("openflag") !=null && req.getParameter("openflag").length()>0 ) {
					openflag	=  req.getParameter("openflag").trim().replace("'","''");
					query = query+	",openflag					= '" + openflag + "' " ;
				}

				if(req.getParameter("group_id") !=null && req.getParameter("group_id").length()>0 ) {
					group_id	=  req.getParameter("group_id").trim().replace("'","''");
					query = query+	",group_id					= '" + group_id + "' " ;
				}
				if(req.getParameter("mk_date") !=null && req.getParameter("mk_date").length()>0 ) {
					mk_date	=  req.getParameter("mk_date").trim().replace("'","''");
					query = query+	",mk_date					= '" + mk_date + "' " ;
				}
				


				if(req.getParameter("olevel") !=null && req.getParameter("olevel").length()>0) {
					olevel	=  Integer.parseInt(String.valueOf(req.getParameter("olevel")));
					query = query+	",olevel						= " + olevel + " " ;
				}
 

					query = query +     " where ocode 		=  " + ocode;

		}

			rtn = querymanager.updateEntities(query);
//System.out.println(query);
		////////////////
		//  ���� ���� //
		////////////////

			String[] oms_contentsArr = req.getParameterValues("oms_contents");
			String[] oms_secondsArr = req.getParameterValues("oms_seconds");

			ArrayList aList = new ArrayList();
//System.out.println(oms_contentsArr.length);
			if (oms_contentsArr != null && oms_contentsArr.length != 0 && oms_secondsArr != null && oms_secondsArr.length != 0) {
				for (int i=0; i < oms_contentsArr.length; i++) {
					OrderMediaSubInfoBean omsib = new OrderMediaSubInfoBean();
					if (StringUtils.isNotBlank(oms_contentsArr[i]) && StringUtils.isNotBlank(oms_secondsArr[i])) {
						omsib.setOms_contents(oms_contentsArr[i]);
						omsib.setOms_seconds(oms_secondsArr[i]);
						aList.add(omsib);
					}
				}
			}


			 if (aList != null) {
				// ���� ������ ��ü DELETE �� �ٽ� INSERT
				query = " DELETE FROM vod_media_sub WHERE oms_ocode = " + ocode;
				querymanager.updateEntities(query);
				this.insertMediaSub(ocode,  aList);
			}
        
			
//System.out.println(query);
		return rtn;
	}

	///////////
	//  ����
	//  vod ���� ���
	//////////

public int insertVod(HttpServletRequest req, String ccode) throws Exception 
	{
//		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_MEDIA + MediaManager.getInstance().getUploadFolder(mcode, ctype, "media");

		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_MEDIA + this.getUploadFolder(ccode );

		MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, 20 * 1024 * 1024, new DefaultFileRenamePolicyITNC21());

		// �⺻�������� �ʱ�ȭ �Ѵ�.
		int ocode    	=  0;
		String otitle  = "";

		String oplay_time    =  "";
		String ocontents  = "";
//		int ohit  = 0;
		String oquality  = "";
		int olevel  = 0;
		String oflag  = "";
		String ofilename  = "";
//		String owdate  = "";

		String ohtml_flag  = "2";
		String oimagefile1  = "";

		String attach_file  = "";
		String omedia_type  = "";
 
		String ofilename2  = "";
		String omedianame  = "";
		String omedianame2  = "";
//		int property_id  = 0;
		String user_id  = "";
		String user_pwd  = "";
		String openflag  = "";
		String group_id = "";
		String mk_date = "";
//		int point = 0;
		String file_pdf="";
		String file_html="";

 
		String query = "";
		int rtn = 0;
		//�Ķ��Ÿ ���� �������� üũ�Ѵ�.


		
		if(multi.getParameter("otitle") !=null && multi.getParameter("otitle").length()>0) {
			otitle = CharacterSet.toKorean(multi.getParameter("otitle")).replace("'","''");
			otitle = otitle.replace("#","&#35;").replace("&","&#38;").replace("<","&lt;").replace(">","&gt;").replace("(","&#40;").replace(")","&#41;");
		}
		if(multi.getParameter("oplay_time") !=null && multi.getParameter("oplay_time").length()>0 ) 
			oplay_time	=  CharacterSet.toKorean(multi.getParameter("oplay_time").trim().replace("'","''"));
			oplay_time = oplay_time.replace("#","&#35;").replace("&","&#38;").replace("<","&lt;").replace(">","&gt;").replace("(","&#40;").replace(")","&#41;");

		if(multi.getParameter("ccode") !=null && multi.getParameter("ccode").length()>0) {
			ccode = CharacterSet.toKorean(multi.getParameter("ccode")).replace("'","''");

		}
		if(multi.getParameter("ocontents") !=null && multi.getParameter("ocontents").length()>0) {
			ocontents = CharacterSet.toKorean(multi.getParameter("ocontents")).replace("'","''");
			ocontents = ocontents.replace("#","&#35;").replace("&","&#38;").replace("<","&lt;").replace(">","&gt;").replace("(","&#40;").replace(")","&#41;");
		}

					
		if(multi.getParameter("oquality") !=null && multi.getParameter("oquality").length()>0 )  
			oquality	=  multi.getParameter("oquality").trim().replace("'","''");
		if(multi.getParameter("oflag") !=null && multi.getParameter("oflag").length()>0 ) 
			oflag	=  multi.getParameter("oflag").trim().replace("'","''");
		if(multi.getParameter("ofilename") !=null && multi.getParameter("ofilename").length()>0 ) 
			ofilename	=   CharacterSet.toKorean(multi.getParameter("ofilename").trim().replace("'","''"));

		if(multi.getParameter("ohtml_flag") !=null && multi.getParameter("ohtml_flag").length()>0 ) 
			ohtml_flag	=  multi.getParameter("ohtml_flag").trim().replace("'","''");
		if(multi.getParameter("omedia_type") !=null && multi.getParameter("omedia_type").length()>0 ) 
			omedia_type	=  multi.getParameter("omedia_type").trim().replace("'","''");
		if(multi.getParameter("ofilename2") !=null && multi.getParameter("ofilename2").length()>0 ) 
			ofilename2	=  multi.getParameter("ofilename2").trim().replace("'","''");
		if(multi.getParameter("omedianame") !=null && multi.getParameter("omedianame").length()>0 ) 
			omedianame	=   CharacterSet.toKorean(multi.getParameter("omedianame").trim().replace("'","''"));
		if(multi.getParameter("omedianame2") !=null && multi.getParameter("omedianame2").length()>0 ) 
			omedianame2	=   CharacterSet.toKorean(multi.getParameter("omedianame2").trim().replace("'","''"));
		if(multi.getParameter("user_id") !=null && multi.getParameter("user_id").length()>0 ) 
			user_id	=  multi.getParameter("user_id").trim().replace("'","''");
		if(multi.getParameter("user_pwd") !=null && multi.getParameter("user_pwd").length()>0 ) 
			user_pwd	=   CharacterSet.toKorean(multi.getParameter("user_pwd").trim().replace("'","''"));
		if(multi.getParameter("openflag") !=null && multi.getParameter("openflag").length()>0 ) 
			openflag	=  multi.getParameter("openflag").trim().replace("'","''");
		if(multi.getParameter("group_id") !=null && multi.getParameter("group_id").length()>0 ) 
			group_id	=  multi.getParameter("group_id").trim().replace("'","''");
		if(multi.getParameter("mk_date") !=null && multi.getParameter("mk_date").length()>0 ) 
			mk_date	=  multi.getParameter("mk_date").trim().replace("'","''");
		if(multi.getParameter("olevel") !=null && multi.getParameter("olevel").length()>0) 
			olevel	=  Integer.parseInt(String.valueOf(multi.getParameter("olevel")));		
		if(multi.getParameter("file_html") !=null && multi.getParameter("file_html").length()>0) 
			file_html	=    this.getUploadFolder2(ccode)+"/"+CharacterSet.toKorean(multi.getParameter("file_html").trim().replace("'","''"));

		try {
			String file_name = multi.getFilesystemName("oimagefile1");
			if (file_name != null && file_name.length() >0 ){
				oimagefile1 = "/mediaROOT"+this.getUploadFolder(ccode)+"/"+file_name;
			}
			
		} catch(Exception e) {
			oimagefile1="";
		}
//System.out.println(oimagefile1);
		if ( oimagefile1 == null || oimagefile1.equals("") )
		{
			if(multi.getParameter("thumbnailImg") !=null && multi.getParameter("thumbnailImg").length()>0) 
			oimagefile1	=  "/mediaROOT"+this.getUploadFolder(ccode)+"/" + String.valueOf(multi.getParameter("thumbnailImg"));
		}
//System.out.println(oimagefile1);		

		try {
			String file_name = multi.getFilesystemName("attach_file");
			if (file_name != null && file_name.length() >0 )
			{
				attach_file = "/mediaROOT"+this.getUploadFolder(ccode)+"/"+file_name;
			}
			
		} catch(Exception e) {
			attach_file="";
		}
		
		try {
			String file_name = multi.getFilesystemName("file_pdf");
			
 
			if (file_name != null && file_name.length() >0 )
			{
				file_pdf = "/mediaROOT"+this.getUploadFolder(ccode)+"/"+file_name;
			}
			
		} catch(Exception e) {
			file_pdf="";
		}

 

		////////////////
		//  ���� ���� //
		////////////////

		String[] oms_contentsArr = multi.getParameterValues("oms_contents");
        String[] oms_secondsArr = multi.getParameterValues("oms_seconds");
//System.out.println(oms_contentsArr);
        ArrayList aList = new ArrayList();

        if (oms_contentsArr != null && oms_contentsArr.length != 0 && oms_secondsArr != null && oms_secondsArr.length != 0) {
            for (int i=0; i < oms_contentsArr.length; i++) {
                OrderMediaSubInfoBean omsib = new OrderMediaSubInfoBean();
                if (StringUtils.isNotBlank(oms_contentsArr[i]) && StringUtils.isNotBlank(oms_secondsArr[i])) {
                    omsib.setOms_contents(oms_contentsArr[i]);
                    omsib.setOms_seconds(oms_secondsArr[i]);
                    aList.add(omsib);
                }
            }
        }

			query = " insert into vod_media ( otitle, oplay_time  ,ccode , ocontents  ,oquality  , olevel, oflag , ofilename  , owdate, ohtml_flag  , oimagefile1 ,attach_file , omedia_type , ofilename2, omedianame  , omedianame2  , user_id, user_pwd , openflag, group_id, mk_date, file_pdf, file_html, del_flag )"
			+" values( '"+otitle+"', '"+oplay_time+"', '"+ccode+"','"+ocontents+"','"+oquality+"','"+olevel+"', '"+oflag+"','"+ofilename+"' ,now(), '"+ohtml_flag+"','"+oimagefile1+"','"+attach_file+"','"+omedia_type+"','"+ofilename2+"','"+omedianame+"','"+omedianame2+"','"+user_id+"','"+user_pwd+"','"+openflag+"','"+group_id+"','"+mk_date+"','"+file_pdf+"','"+file_html+"','N')";

//System.out.println(query);

		rtn = querymanager.updateEntities(query);
			

        if (aList != null && aList.size() > 0) {
            query = " SELECT LAST_INSERT_ID() ";

			Vector v = querymanager.selectEntity(query);

			if (v != null && v.size() > 0) {
				ocode = Integer.parseInt(String.valueOf(v.elementAt(0)));
				this.insertMediaSub(ocode,  aList);
			}
		}

		return rtn;
	}



	/////////////
	// ÷������ ���
	//  ����
	///////////////

		public int insertOMediaFile(OrderMediaInfoBean bean ) throws Exception{

		    String query = "";
		    String sub_query1 = "";
	        String sub_query2 = "";

		    if(!String.valueOf(bean.getOimage()).equals("") && bean.getOimage() != null) { // ������ �̹���ȭ���� ���ε� �� ���

		        sub_query1 = String.valueOf(bean.getOimage());

		    }
	 
	            sub_query2 = "update vod_media set attach_file='";

	        query = sub_query2 + sub_query1+ "' where ocode=" +bean.getOcode();
	        return querymanager.updateEntities(query);
		}
		/////////////
		// ÷������ ����
		//  ����
		///////////////

		public int dropOMediaFile(String ocode) throws Exception{
			
		    String query = "";
		    Vector v = null;
		    int rtn = -1;
		
		    if(!ocode.equals("") ) { // ������ ����Ȯ��
		
		        try {
		
		            // �̵�� ȭ�� ����
		            Vector vt = querymanager.selectEntity("select oimagefile3 from vod_media where ocode=" +ocode);
		            String old_file = "";
		            if(vt != null && vt.size() > 0){
		            	old_file = String.valueOf(vt.elementAt(0));

						File deleteFile1 = new File(DirectoryNameManager.VODROOT+old_file);
					
						try{  
							deleteFile1.delete(); // ���� �̹��� ���� ����
						}
						catch(Exception e){ // 
							System.err.println(" ���� �̹��� ���� ���� Ex : " + e);	
						}
		            }

		            query = "update vod_media set oimagefile1 ='' where ocode=" +ocode;
		
		            rtn = querymanager.executeQuery(query);
		
		            if(rtn != -1) {
		                return rtn;
		            }else
		                System.err.println("���̺��������� ����");
		
		        } catch (Exception e) {
					System.err.println(e.getMessage());
		        }
		
		        return rtn;
		
		    } else
		        return -1;
		
		}
	/**
     * �̵�� ������ ���̺� ����
     * @param ocode
     * @param aList OrderMediaSubInfoBean ArrayList
     */
    private void insertMediaSub(int ocode,  ArrayList aList) throws Exception {

//         if (ocode == 0 || mcode == 0 || aList == null || aList.size() == 0) return;
        if (ocode == 0 || aList == null || aList.size() == 0) return;

        try {

            String query = "";
            String query1 = " INSERT INTO vod_media_sub(oms_ocode,  oms_contents, oms_seconds) VALUES ";

            for (int i=0; i < aList.size(); i++) {
                OrderMediaSubInfoBean omsib = (OrderMediaSubInfoBean) aList.get(i);
                query = query1 +
                        " (" +
                        ocode + "," +
                         
                        " '" + omsib.getOms_contents().replace("'","''") + "', " +
                        " '" + omsib.getOms_seconds().replace("'","''") + "' " +
                        " )";
System.out.println(query);                
                querymanager.updateEntities(query);
            }
        } catch (Exception e) {
            System.err.println("insertMediaSub ex : "+e.getMessage());
        }
    }
    
    /*****************************************************
    �̵���ڵ��� ���ε����� ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return ���ε����� ���ڿ��� ����<br>
	@param code �̵���ڵ�, ī�װ�Ÿ��, �̵��Ÿ��
	******************************************************/
	public String getUploadFolder(String ccode) {
	
	    String strtmp = "";
	    String strfolder1 = "";
	    String strfolder2 = "";
	    String strfolder3 = "";
	    String strfolder4 = "";
	    String query = "";
	    String str = ccode;
	
	    if(ccode == null ) {
	        return null;
	    } else {
	
	        try {
		        
		        // ī�װ����̺��� ��,��,�Һз� ����.
	
		        Vector v2 = this.selectQuery("select cinfo from category where ccode='" +ccode+ "' ");
		        String cinfo = "A";
		        if (v2 != null && v2.size() > 0) {
		            cinfo = String.valueOf(v2.elementAt(0));
		        }
	
		        String strFolderRoot = "";
					strFolderRoot = "/VOD/";
	
		        if(cinfo.equals("A")) {
		            strfolder1 = str;
	
		            strtmp = strFolderRoot + strfolder1;
	
		        } else if(cinfo.equals("B") && str!=null && str.length() > 3) {
			        strfolder1 = str.substring(0,3);
			        strfolder1 = TextUtil.zeroFill(0,12,strfolder1); //�ڷ� 9��°���� ����
			        strfolder2 = str;
	
			        strtmp = strFolderRoot +strfolder1+ "/" +strfolder2;
	
		        } else if(cinfo.equals("C") && str!=null && str.length() > 6) {
		            strfolder1 = str.substring(0,3);
		            strfolder1 = TextUtil.zeroFill(0,12,strfolder1); //�ڷ� 9��°���� ����
			        strfolder2 = str.substring(0,6);
			        strfolder2 = TextUtil.zeroFill(0,12,strfolder2); //�ڷ� 9��°���� ����
			        strfolder3 = str;
	
			        strtmp = strFolderRoot +strfolder1+ "/" +strfolder2+ "/" +strfolder3;
			        //System.err.println(">>>>>>>>>>>>>>>>>>>>>>>" + strtmp);
		        }else if(cinfo.equals("D") && str!=null && str.length() > 6) {
		            strfolder1 = str.substring(0,3);
		            strfolder1 = TextUtil.zeroFill(0,12,strfolder1); //�ڷ� 9��°���� ����
			        strfolder2 = str.substring(0,6);
			        strfolder2 = TextUtil.zeroFill(0,12,strfolder2); //�ڷ� 9��°���� ����
			        strfolder3 = str.substring(0,9);
			        strfolder3 = TextUtil.zeroFill(0,12,strfolder3); //�ڷ� 9��°���� ����
			        strfolder4 = str;
	
			        strtmp = strFolderRoot +strfolder1+ "/" +strfolder2+ "/" +strfolder3+ "/" +strfolder4;
			        //System.err.println(">>>>>>>>>>>>>>>>>>>>>>>" + strtmp);
		        }
	
		       
	        } catch (Exception e) {
	            System.err.println("getUploadFolder2 ex : "+e.toString());
	        }
	
	        return strtmp;
	    }
	
	}
	
	/*****************************************************
    �̵���ڵ��� ���ε����� ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return ���ε����� ���ڿ��� ����<br>
	@param code �̵���ڵ�, ī�װ�Ÿ��, �̵��Ÿ��
	******************************************************/
	public String getUploadFolder2(String ccode) {
	
	    String strtmp = "";
	    String strfolder1 = "";
	    String strfolder2 = "";
	    String strfolder3 = "";
	    String strfolder4 = "";
	    String query = "";
	    String str = ccode;
	
	    if(ccode == null ) {
	        return null;
	    } else {
	
	        try {
		        
		        // ī�װ����̺��� ��,��,�Һз� ����.
	
		        Vector v2 = this.selectQuery("select cinfo from category where ccode='" +ccode+ "' ");
		        String cinfo = "A";
		        if (v2 != null && v2.size() > 0) {
		            cinfo = String.valueOf(v2.elementAt(0));
		        }
	
		        String strFolderRoot = "";
			 
	
		        if(cinfo.equals("A")) {
		            strfolder1 = str;
	
		            strtmp = strFolderRoot + strfolder1;
	
		        } else if(cinfo.equals("B") && str!=null && str.length() > 3) {
			        strfolder1 = str.substring(0,3);
			        strfolder1 = TextUtil.zeroFill(0,12,strfolder1); //�ڷ� 9��°���� ����
			        strfolder2 = str;
	
			        strtmp = strFolderRoot +strfolder1+ "/" +strfolder2;
	
		        } else if(cinfo.equals("C") && str!=null && str.length() > 6) {
		            strfolder1 = str.substring(0,3);
		            strfolder1 = TextUtil.zeroFill(0,12,strfolder1); //�ڷ� 9��°���� ����
			        strfolder2 = str.substring(0,6);
			        strfolder2 = TextUtil.zeroFill(0,12,strfolder2); //�ڷ� 9��°���� ����
			        strfolder3 = str;
	
			        strtmp = strFolderRoot +strfolder1+ "/" +strfolder2+ "/" +strfolder3;
			        //System.err.println(">>>>>>>>>>>>>>>>>>>>>>>" + strtmp);
		        }else if(cinfo.equals("D") && str!=null && str.length() > 6) {
		            strfolder1 = str.substring(0,3);
		            strfolder1 = TextUtil.zeroFill(0,12,strfolder1); //�ڷ� 9��°���� ����
			        strfolder2 = str.substring(0,6);
			        strfolder2 = TextUtil.zeroFill(0,12,strfolder2); //�ڷ� 9��°���� ����
			        strfolder3 = str.substring(0,9);
			        strfolder3 = TextUtil.zeroFill(0,12,strfolder3); //�ڷ� 9��°���� ����
			        strfolder4 = str;
	
			        strtmp = strFolderRoot +strfolder1+ "/" +strfolder2+ "/" +strfolder3+ "/" +strfolder4;
			        //System.err.println(">>>>>>>>>>>>>>>>>>>>>>>" + strtmp);
		        }
	
		       
	        } catch (Exception e) {
	            System.err.println("getUploadFolder2 ex : "+e.toString());
	        }
	
	        return strtmp;
	    }
	
	}
	
	public Vector selectQuery(String query) {
	    return querymanager.selectEntity(query);
	
	}
	
	
	public int insertOMediaHtml(HttpServletRequest req) throws Exception{
		MultipartRequest multi = new MultipartRequest(req, DirectoryNameManager.UPLOAD_MEDIA , 20 * 1024 * 1024, new DefaultFileRenamePolicyITNC21());
		
		
		String file_html = "";
		String ocode = "";
		String ccode = "";
		if(multi.getParameter("ccode") !=null && multi.getParameter("ccode").length()>0) {
			ccode = multi.getParameter("ccode").replace("'","''");
		}
		
		if(multi.getParameter("file_html") !=null && multi.getParameter("file_html").length()>0 ) 
			file_html	=  this.getUploadFolder2(ccode)+multi.getParameter("file_html").trim().replace("'","''");

		if(multi.getParameter("ocode") !=null && multi.getParameter("ocode").length()>0) {
			ocode = multi.getParameter("ocode").replace("'","''");
		}
		
	    String query = "";
 	    int rtn = -1;
	
	    if(!ocode.equals("") ) { // ������ ����Ȯ��

	            query = "update vod_media set file_html ='"+file_html+"' where  ocode=" +ocode;
	
	            rtn = querymanager.executeQuery(query);
	
	        return rtn;
	
	    } else
	        return -1;
	
	}
	
	public int insertOMediaHtml2(String ocode , String file_html, String ccode) throws Exception{
		
 
	    String query = "";
 	    int rtn = -1;
 	   String upload_= this.getUploadFolder2(ccode);
	    if(!ocode.equals("") ) { // ������ ����Ȯ��

	            query = "update vod_media set file_html ='"+upload_+"/"+file_html+"' where  ocode=" +ocode;
	
	            rtn = querymanager.executeQuery(query);
	
	        return rtn;
	
	    } else
	        return -1;
	
	}
	
public int dropOMediaHtml(String ocode) throws Exception{
		
	    String query = "";
 	    int rtn = -1;
	
	    if(!ocode.equals("") ) { // ������ ����Ȯ��
	
	        try {
	
	            Vector vt = querymanager.selectEntity("select file_html from vod_media where ocode=" +ocode);
	            String old_file = "";
	            if(vt != null && vt.size() > 0){
	            	old_file = String.valueOf(vt.elementAt(0));

					File deleteFile1 = new File(DirectoryNameManager.VODROOT+old_file);
				
					try{  
						deleteFile1.delete(); // ���� �̹��� ���� ����
					}
					catch(Exception e){ // 
						System.err.println(" ÷������ PDF ���� ���� Ex : " + e);	
					}
	            }

	            query = "update vod_media set file_html ='' where  ocode=" +ocode;
	
	            rtn = querymanager.executeQuery(query);
	
	            if(rtn != -1) {
	                return rtn;
	            }else
	                System.err.println(" ÷������ PDF �������� ����");
	
	        } catch (Exception e) {
	        	System.err.println(e.getMessage());
	        }
	
	        return rtn;
	
	    } else
	        return -1;
	
	}
	
public int dropOMediaVod(String ocode) throws Exception{
		
	    String query = "";
 	    int rtn = -1;
	
	    if(!ocode.equals("") ) { // ������ ����Ȯ��
	
	        try {
	
	            query = "update vod_media set omedianame ='' , ofilename='' where  ocode=" +ocode;
	
	            rtn = querymanager.executeQuery(query);
	
	            if(rtn != -1) {
	                return rtn;
	            }else
	                System.err.println(" ÷������ VOD �������� ����");
	
	        } catch (Exception e) {
	        	System.err.println(e.getMessage());
	        }
	
	        return rtn;
	
	    } else
	        return -1;
	
	}
	

}
