package com.hmkcode;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import java.awt.*;
import java.io.*;
import java.awt.image.*;

//import com.sun.image.codec.jpeg.*; 
import javax.imageio.ImageIO;
import com.yundara.util.CharacterSet;
import com.hmkcode.vo.FileMeta;

public class MultipartRequestHandler {

	
	//private final static String UPLOAD_DIRECTORY = "D:/vod_temp/upload/test";
	//private final static String UPLOAD_DIRECTORY = com.vodcaster.sqlbean.DirectoryNameManager.VODROOT+com.vodcaster.sqlbean.DirectoryNameManager.UPLOAD_VOD ;
	private final static String UPLOAD_DIRECTORY = com.vodcaster.sqlbean.DirectoryNameManager.VOD_UPLOAD ;
	//IMGPATH
	public static List<FileMeta> uploadByJavaServletAPI(HttpServletRequest request) throws IOException, ServletException{
		
		List<FileMeta> files = new LinkedList<FileMeta>();
 
		// 1. Get all parts
		Collection<Part> parts = request.getParts();
		
		// 2. Get paramter "twitter"
		String ocode = request.getParameter("ocode");
		String ccode = request.getParameter("ccode");
		String img_title = request.getParameter("img_title");
 
		// 3. Go over each part
		FileMeta temp = null;
		for(Part part:parts){	
 
			// 3.1 if part is multiparts "file"
			if(part.getContentType() != null){
				
				// 3.2 Create a new FileMeta object
				temp = new FileMeta();
				temp.setFileName(getFilename(part));
				temp.setFileSize(part.getSize()/1024 +" Kb");
				temp.setFileType(part.getContentType());
				temp.setContent(part.getInputStream()); 
				
				temp.setOcode(ocode); 
				temp.setCcode(ccode); 
				temp.setImg_title(img_title);  
				
				// 3.3 Add created FileMeta object to List<FileMeta> files
				files.add(temp);
				
			}
		}
		return files;
	}
	
	public static List<FileMeta> uploadByApacheFileUpload(HttpServletRequest request) throws IOException, ServletException{
//System.out.println("upload step 2");		
		String temp_agent = request.getHeader("User-Agent");
		temp_agent = temp_agent.toLowerCase();
		
	if (temp_agent.indexOf("msie") > 0) {
		if ( temp_agent.indexOf("trident/6.0") > 0 ) {
			if ( temp_agent.indexOf("msie 10.0") > 0 ) {
				 // ie11
				request.setCharacterEncoding("UTF-8");	
			} else {
				 // ie10
				request.setCharacterEncoding("euc-kr");
			}
		 
		} else { 
			// ie10 이하
			request.setCharacterEncoding("euc-kr");
		}
	} else {
		request.setCharacterEncoding("UTF-8");	
		 // 크롬
	} 
	
		//request.setCharacterEncoding("UTF-8");	
		//request.setCharacterEncoding("euc-kr");
		
		List<FileMeta> files = new LinkedList<FileMeta>();
		// 1. Check request has multipart content
//System.out.println("upload step 3");		
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		FileMeta temp = null;
//System.out.println(isMultipart);		
		// 2. If yes (it has multipart "files")
		if(isMultipart){

			// 2.1 instantiate Apache FileUpload classes
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory); 
			 upload.setSizeMax(3000*1024*1024);  // 3G 까지 업로드
			// 2.2 Parse the request
			try {
 
				
				// 2.3 Get all uploaded FileItem
System.out.println("upload.parseRequest:");				
				List<FileItem> items = upload.parseRequest(request);  // 파일 업로드

				String ocode = "";
				String ccode = "";
				String img_title = "";
		 
				String real_file = "";
				// 2.4 Go over each FileItem
				for(FileItem item:items){ 
 
					// 2.5 if FileItem is not of type "file" 
 
				 if (item.isFormField()) { 

					  // 2.6 Search for "twitter" parameter
						 if(item.getFieldName().equals("ocode"))
							 ocode = item.getString();
						 if(item.getFieldName().equals("ccode"))
							 ccode = item.getString();
						 if(item.getFieldName().equals("img_title"))
							 img_title = item.getString();
 
 
				 } else {
				    	// 2.7 Create FileMeta object
				    	temp = new FileMeta();
						temp.setFileName(item.getName());
						temp.setContent(item.getInputStream());
						temp.setFileType(item.getContentType());
						temp.setFileSize(item.getSize()/1024+ "Kb"); 
						
						SimpleDateFormat fommatter = new SimpleDateFormat("yyyy/MM");
		                Date currentTime = new Date();
		                String today = "";
		                today = fommatter.format(currentTime);
		                String tmp_ocode = "/"+item.getName().substring(0, item.getName().indexOf("."));
			                
						String name = new File(item.getName()).getName();
						String save_dir = UPLOAD_DIRECTORY + File.separator +today+ tmp_ocode;
						//temp.setCcode(today+tmp_ocode);  
						temp.setCcode(today); // 용인은 해당 월까지만 저장
						
						java.io.File fPath = new java.io.File(UPLOAD_DIRECTORY + "/" + today.substring(0,today.indexOf("/")) );  // 년
						fPath.mkdir();
						java.io.File fPath2 = new java.io.File(UPLOAD_DIRECTORY + "/" + today);  // 월
						fPath2.mkdir(); 
						java.io.File fPath3 = new java.io.File(UPLOAD_DIRECTORY + "/" + today+ tmp_ocode);  // 일
						fPath3.mkdir();
						
System.out.println(save_dir);			

						item.write( new File(save_dir + File.separator + name));
						//item.write( new File(UPLOAD_DIRECTORY + File.separator + name));
						// 2.7 Add created FileMeta object to List<FileMeta> files
						files.add(temp); 

				     } 
 				}
			
				
			} catch (FileUploadException e) {
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return files;
	}

	
	// this method is used to get file name out of request headers
	// 
	private static String getFilename(Part part) {
	    for (String cd : part.getHeader("content-disposition").split(";")) {
	        if (cd.trim().startsWith("filename")) {
	            String filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
	            return filename.substring(filename.lastIndexOf('/') + 1).substring(filename.lastIndexOf('\\') + 1); // MSIE fix.
	        }
	    }
	    return null;
	}
}
