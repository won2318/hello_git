/*
 * ������ : 2004. 12. 14.
 *
 * ����� : 
 */
package com.yundara.util;

/**
 * @author ������
 *
 * TODO ���ϰ��� ó���� ����ϴ� ��ƿ��Ƽ Ŭ����
 */

import java.io.*;
import java.util.Vector;

public class FileUtil {

	/**
	 *	�ؽ�Ʈ ������ �о� ������ ����.
	 *
	 *	@param file_path �ؽ�Ʈ ������ ��ġ
	 *	@return ���Ϸ� ���� ���ڿ��� �о�� ��ȯ�մϴ�.
	 *	@author ������
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
	 *	������ �����Ѵ�.
	 *
	 *	@param path ���.
	 *	@param fileName ���ϸ�.
	 *	@return ���� ���� ������ true�� ���� �մϴ�.
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
	 *	���� �̸��� �����Ѵ�.
	 *
	 *	@param path ���� ���丮
	 *	@param oldName �ٲ� ���� �̸�
	 *	@param newName �ٲ� ���� �̸�
	 *	@return ���� �̸� ���� ������ true�� ���� �մϴ�.
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
	 *	������ �ٸ� �̸����� ���� �Ѵ�.
	 *
	 *	@param path ���� ���丮
	 *	@param copyingfile ������ ���� �̸�                 ex) image.gif
	 *	@param copyedfile  ����� ���� �̸�(Ȯ���� �� �̸�)   ex) image2     -> image2.gif
	 *	@return ���� ���� ������ true�� ���� �մϴ�.
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
	 *	������ �ٸ� �̸����� ���� �մϴ�.
	 *  <br><font size=2>2003/01/10. Kim JongJin</font>
	 *  <p>
	 *
	 *	@param path ���� ���丮
	 *	@param copyingfile ������ ���� �̸�                 ex) image.gif
	 *	@param copyedfile  ����� ���� �̸�(Ȯ���� �� �̸�)   ex) image2     -> image2.gif
	 *	@return ���� ���� ������ true�� ���� �մϴ�.
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
	 * ���� �̵�
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

		// �̵��� ������ Ÿ�� ������ ������ ���ο� �̸��� ����ϴ�.
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
		
		
		// ������ �����մϴ�.
		if( copy( srcDir, srcFileName, tgrDir, new_body ) ) {
			// ���� ������ ����ϴ�.
			if( delete( srcDir, srcFileName ) ) {
				returnValue = new_body + ext;
			}
		}
		

		return returnValue;
	}
	
	/**
	 * ���� ���翩��
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
	 * Ư�� ����� ���丮 ����Ʈ ���
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
	 * Ư�� ���丮�� ���� ����Ʈ ���
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
