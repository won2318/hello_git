/*
 * Created on 2005. 1. 17
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.utils;

import com.yundara.util.WebUtils;
import com.yundara.util.CharacterSet;
import javazoom.upload.*;
import com.yundara.beans.*;
import com.yundara.io.*;

import java.util.*;
import org.apache.commons.beanutils.BeanUtils;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class WebutilsExt extends WebUtils {
    
	public static void fill(InfoBeanExt bean, MultipartFormDataRequest req) {
		
	    try {
			Enumeration e = req.getParameterNames();
	        for(;e.hasMoreElements();) {
			    String key = (String)e.nextElement();
				BeanUtils.setProperty(bean, key, req.getParameter(key));
			}
			Hashtable files = req.getFiles();

			if ( (files != null) || (!files.isEmpty()) ) {
			    
			    UploadFile file = (UploadFile) files.get("ofilename");
                if(file != null)
                    BeanUtils.setProperty(bean, "ofilename", file.getFileName());

			    UploadFile file6 = (UploadFile) files.get("ofilename2");
                if(file6 != null)
                    BeanUtils.setProperty(bean, "ofilename2", file6.getFileName());

			    UploadFile file4 = (UploadFile) files.get("attach_file");
                if(file != null)
                    BeanUtils.setProperty(bean, "attach_file", file4.getFileName());



			    UploadFile file2 = (UploadFile) files.get("oimage");
                if(file2 != null)
                    BeanUtils.setProperty(bean, "oimage", file2.getFileName());

			    UploadFile file3 = (UploadFile) files.get("rfilename");
                if(file3 != null)
                    BeanUtils.setProperty(bean, "rfilename", file2.getFileName());

			    UploadFile file5 = (UploadFile) files.get("rimagefile");
                if(file5 != null)
                    BeanUtils.setProperty(bean, "rimagefile", file5.getFileName());
			}

			//for(Enumeration e = req.getFileNames();e.hasMoreElements();) {
			//	String key = (String)e.nextElement();
			//	BeanUtils.setProperty(bean, key, req.getFilesystemName(key));
			//}
		} catch(Exception ex){
		}
	}

}
