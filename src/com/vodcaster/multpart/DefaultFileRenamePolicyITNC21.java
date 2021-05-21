/*
 * Created on 2004. 12. 29
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.multpart;

import com.oreilly.servlet.multipart.*;
import java.io.*;
import com.yundara.util.CharacterSet;
import java.util.Calendar;
import java.text.SimpleDateFormat;
import java.sql.Timestamp; 

/**
 * @author Jong-Hyun Ho
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class DefaultFileRenamePolicyITNC21 implements FileRenamePolicy{

	/**
	 * @author Jong-Hyun Ho
	 * ���ε� ���� �̸��� �ѱ��� ��� CharacterSet.toKorean()�޼ҵ�� ���ϸ��� �ѱ۷� ��ȯ.
	 */
	 public File rename(File f) {

	    String name = f.getName();
	    String body = null;
	    String ext = null;
	    
	    
	    // ���� �ð�����
        SimpleDateFormat fommatter = new SimpleDateFormat("yyyyMMddHHmmss");
        Calendar cal = Calendar.getInstance();
        String today = "";
        today = fommatter.format(cal.getTime());       
        String str_result = today ;

	    int dot = name.lastIndexOf(".");
	    if (dot != -1) {
	      body = name.substring(0, dot);
	      ext = name.substring(dot);  // includes "."
	    }
	    else {
	      body = name;
	      ext = "";
	    }
		//body = CharacterSet.toKorean(body);
	    body = str_result;


	    int count = 0;

	    if (!f.exists()) {
			String newName = body + ext;
			f = new File(f.getParent(), newName);
	    }

		while (f.exists()) {
			count++;
			String newName = count + "_" + body + ext;
			f = new File(f.getParent(), newName);
		}
		return f;

	  }
	 
}
