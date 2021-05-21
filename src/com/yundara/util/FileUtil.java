/*
 * 생성일 : 2004. 12. 14.
 *
 * 사용방법 : 
 */
package com.yundara.util;

/**
 * @author 오영석
 *
 * TODO 파일관련 처리를 담당하는 유틸리티 클래스
 */

import java.io.*;
import java.util.Vector;

public class FileUtil {

	/**
	 *	텍스트 파일을 읽어 내용을 리턴.
	 *
	 *	@param file_path 텍스트 파일의 위치
	 *	@return 파일로 부터 문자열을 읽어내어 반환합니다.
	 *	@author 오영석
	 */
	public static String getTextFile(String file_path) {
		RandomAccessFile file  = null;
		StringBuffer buffer = new StringBuffer("");
		String debugString = "";

		try{
			file = new RandomAccessFile(file_path, "r"); 
			while(file.getFilePointer() < file.length())   { 
				buffer.append( file.readLine() );
			} 
			file.close();
		}catch(Exception e){
			debugString = e.getMessage();
		}

		return buffer.toString()+debugString;
	}
	
	/**
	 *	파일을 삭제한다.
	 *
	 *	@param path 경로.
	 *	@param fileName 파일명.
	 *	@return 파일 삭제 성공시 true를 리턴 합니다.
	 */
	public static boolean delete(String path, String fileName){

		if( fileName == null || fileName.trim().equals("") )
			return false;

		File file = new File( path + "/" + fileName );
		try{
			if( file.isFile() ){ 
				return file.delete(); 
			} else {
				return false;	
			}
		}catch(Exception e){
			return false;
		}
	}

	/**
	 *	파일 이름을 변경한다.
	 *
	 *	@param path 파일 디렉토리
	 *	@param oldName 바꿀 파일 이름
	 *	@param newName 바뀔 파일 이름
	 *	@return 파일 이름 변경 성공시 true를 리턴 합니다.
	 */
	public static boolean renameTo( String path, String oldName, String newName ){

		if( oldName == null || oldName.trim().equals("") )
			return false;

		if( newName == null || newName.trim().equals("") )
			return false;

		File old_file = new File( path + "/" + oldName );
		File new_file = new File( path + "/" + newName );
		try{
			if( old_file.isFile() ){
				return old_file.renameTo( new_file );
			}
			else{
				return false;
			}
		}catch(Exception e){
			return false;
		}
	}

	/**
	 *	파일을 다른 이름으로 복사 한다.
	 *
	 *	@param path 파일 디렉토리
	 *	@param copyingfile 복사할 파일 이름                 ex) image.gif
	 *	@param copyedfile  복사된 파일 이름(확장자 뺀 이름)   ex) image2     -> image2.gif
	 *	@return 파일 복사 성공시 true를 리턴 합니다.
	 */
	public static boolean copy( String path, String copyingfile, String copyedfile ) { 

		if( path == null || copyingfile == null || copyedfile == null )
			return false;
		try{
			String input_file = path + "/" + copyingfile;
			String output_file = "";
			
			if( copyingfile.indexOf( "." ) == -1 )
				output_file = path + "/" + copyedfile;
			else 
				output_file = path + "/" + copyedfile + copyingfile.substring( copyingfile.indexOf( "." ) );

			FileInputStream in = new FileInputStream ( input_file ); 
			FileOutputStream out = new FileOutputStream ( output_file ); 

			byte[] buffer = new byte[16]; 
			int numberRead; 
			while ( (numberRead = in.read(buffer) ) >= 0 ) out.write ( buffer, 0, numberRead ); 
			out.close (); 
			in.close (); 
			return true;
		}catch(Exception e){
			return false;
		}
    } 

	/**
	 *	파일을 다른 이름으로 복사 합니다.
	 *  <br><font size=2>2003/01/10. Kim JongJin</font>
	 *  <p>
	 *
	 *	@param path 파일 디렉토리
	 *	@param copyingfile 복사할 파일 이름                 ex) image.gif
	 *	@param copyedfile  복사된 파일 이름(확장자 뺀 이름)   ex) image2     -> image2.gif
	 *	@return 파일 복사 성공시 true를 리턴 합니다.
	 */
	public static boolean copy( String path, String copyingfile, String tgr_path, String copyedfile ) { 

		if( path == null || copyingfile == null || copyedfile == null )
			return false;
		try{
			String input_file = path + "/" + copyingfile;
			String output_file = "";
			
			if( copyingfile.indexOf( "." ) == -1 )
				output_file = tgr_path + "/" + copyedfile;
			else{
				output_file = tgr_path + "/" + copyedfile + copyingfile.substring( copyingfile.indexOf( "." ) );
			}

			System.out.println("input_file:"+ input_file);
			System.out.println("output_file:"+ output_file);

			FileInputStream in = new FileInputStream ( input_file ); 
			FileOutputStream out = new FileOutputStream ( output_file ); 

			byte[] buffer = new byte[16]; 
			int numberRead; 
			while ( (numberRead=in.read (buffer) ) >= 0 ) 
				out.write ( buffer, 0, numberRead ); 
			out.close (); 
			in.close (); 
			return true;
		}catch(Exception e){
			System.out.println(e);
			return false;
		}
    } 

	/**
	 * 파일 이동
	 * return : boolean
	*/
	public static String moveFile(String srcDir, String srcFileName, String tgrDir) {

		String returnValue = srcFileName;
		
		String newFileName = srcFileName;
		String body = null;
		String ext = null;

		int dot = newFileName.lastIndexOf(".");
		if (dot != -1) {
			body = newFileName.substring(0, dot);
			ext = newFileName.substring(dot);  // includes "."
		}
		else {
			body = newFileName;
			ext = "";
		}

		String new_body = body;

		// 이동할 파일이 타겟 폴더에 있으면 새로운 이름을 만듭니다.
		if(existsFile(tgrDir, new_body + ext)) {
			int count = 0;
			while (existsFile(tgrDir, new_body + ext) && count < 999999999) {
				count++;
				new_body = body + "("+ count +")";
			}
		}
		
		System.out.println("srcDir:"+ srcDir);
		System.out.println("tgrDir:"+ tgrDir);
		System.out.println("srcFileName:"+ srcFileName);
		System.out.println("new_body:"+ new_body);
		System.out.println("ext:"+ ext);
		
		
		// 파일을 복사합니다.
		if( copy( srcDir, srcFileName, tgrDir, new_body ) ) {
			// 원본 파일을 지웁니다.
			if( delete( srcDir, srcFileName ) ) {
				returnValue = new_body + ext;
			}
		}
		

		return returnValue;
	}
	
	/**
	 * 파일 존재여부
	 * return : boolean
	*/
	public static boolean existsFile(String strDir, String strFileName) {

		boolean returnBln = false;
		
		try {
			File objFile = new File(strDir +"/"+ strFileName);
			returnBln = objFile.exists();
		}
		catch(Exception e) {
			System.out.println("FileUtilExt.existsFile("+ strDir +", "+ strFileName +")");
		}

		return returnBln;
	}
	
	/**
	 * 특정 경로의 디렉토리 리스트 얻기
	 * return : Vector
	*/
	public static Vector getDirectoryList(String strUrl) {

		Vector rs_v = new Vector();

		File objFile = new File(strUrl);
		File[] arrFiles = objFile.listFiles();

		for(int i=0; i<arrFiles.length; i++) {
			if(arrFiles[i].isDirectory()) rs_v.addElement(arrFiles[i].getName());
		}

		return rs_v;
	}	
	
	/**
	 * 특정 디렉토리의 파일 리스트 얻기
	 * return : Vector
	*/
	public static Vector getFileList(String strUrl) {

		Vector rs_v = new Vector();

		File objFile = new File(strUrl);
		File[] arrFiles = objFile.listFiles();

		for(int i=0; i<arrFiles.length; i++) {
			if(arrFiles[i].isFile()) rs_v.addElement(arrFiles[i].getName());
		}

		return rs_v;
	}

	public static void main(String[] args) {
	}
}
