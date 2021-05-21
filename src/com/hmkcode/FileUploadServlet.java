package com.hmkcode;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hmkcode.vo.FileMeta;

//this to be used with Java Servlet 3.0 API
@MultipartConfig 
public class FileUploadServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	// this will store uploaded files
	private static List<FileMeta> files = new LinkedList<FileMeta>();
	/***************************************************
	 * URL: /upload
	 * doPost(): upload the files and other parameters
	 ****************************************************/
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException{
		//request.setCharacterEncoding("UTF-8");
		//request.setCharacterEncoding("euc-kr");
		// 1. Upload File Using Java Servlet API
		//files.addAll(MultipartRequestHandler.uploadByJavaServletAPI(request));			

		files = new LinkedList<FileMeta>();
		// 1. Upload File Using Apache FileUpload
//System.out.println("upload step 1");	
		files.addAll(MultipartRequestHandler.uploadByApacheFileUpload(request));
		
		// Remove some files
//		while(files.size() > 20)
//		{
//			files.remove(0);
//		}
 

		HashMap<String, String> map = new HashMap<String, String>();
		if (files.size() > 0 ) {
		map.put("fileName",files.get(0).getFileName());
		map.put("ccode",files.get(0).getCcode());
		}
		
		JSONObject jso=new JSONObject();
		jso.put("data", map); 
	 	
 
		//response.setContentType("application/json");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		System.out.println(jso.toString());
		out.print(jso.toString()); 
    
 
	}
	/***************************************************
	 * URL: /upload?f=value
	 * doGet(): get file of index "f" from List<FileMeta> as an attachment
	 ****************************************************/
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException{
		
		 // 1. Get f from URL upload?f="?"
		 String value = request.getParameter("f");
		 
		 // 2. Get the file of index "f" from the list "files"
		 FileMeta getFile = files.get(Integer.parseInt(value));
		 
		 try {		
			 	// 3. Set the response content type = file content type 
			 	response.setContentType(getFile.getFileType());
 
			 	// 4. Set header Content-disposition
			 	response.setHeader("Content-disposition", "attachment; filename=\""+getFile.getFileName()+"\"");
			 	
			 	// 5. Copy file inputstream to response outputstream
		        InputStream input = getFile.getContent();
		        OutputStream output = response.getOutputStream();
		        byte[] buffer = new byte[1024*10];
		        
		        for (int length = 0; (length = input.read(buffer)) > 0;) {
		            output.write(buffer, 0, length);
		        }
		        
		        output.close();
		        input.close();
		 }catch (IOException e) {
				e.printStackTrace();
		 }
		
	}
}
