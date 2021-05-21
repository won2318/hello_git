/*
 * Created on 2004. 12. 28
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.multpart;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.oreilly.servlet.multipart.MultipartParser;
import com.oreilly.servlet.multipart.Part;
import com.oreilly.servlet.multipart.FilePart;
import com.oreilly.servlet.multipart.ParamPart;
import com.oreilly.servlet.multipart.FileRenamePolicy;

/**
 * @author Jong-Hyun Ho
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class MultipartRequest {

	  private static final int DEFAULT_MAX_POST_SIZE = 1024 * 1024;  // 1 Meg

	  protected Hashtable parameters = new Hashtable();  // name - Vector of values
	  protected Hashtable files = new Hashtable();       // name - UploadedFile

	  public MultipartRequest(HttpServletRequest request,
	                          String saveDirectory) throws IOException {
	    this(request, saveDirectory, DEFAULT_MAX_POST_SIZE);
	  }

	 public MultipartRequest(HttpServletRequest request,
	                          String saveDirectory,
	                          int maxPostSize) throws IOException {
	    this(request, saveDirectory, maxPostSize, null, null);
	  }
	
	  public MultipartRequest(HttpServletRequest request,
	                          String saveDirectory,
	                          String encoding) throws IOException {
	    this(request, saveDirectory, DEFAULT_MAX_POST_SIZE, encoding, null);
	  }

	  public MultipartRequest(HttpServletRequest request,
	                          String saveDirectory,
	                          int maxPostSize,
	                          FileRenamePolicy policy) throws IOException {
	    this(request, saveDirectory, maxPostSize, null, policy);
	  }

	  public MultipartRequest(HttpServletRequest request,
	                          String saveDirectory,
	                          int maxPostSize,
	                          String encoding) throws IOException {
	    this(request, saveDirectory, maxPostSize, encoding, null);
	  }

	  public MultipartRequest(HttpServletRequest request,
	                          String saveDirectory,
	                          int maxPostSize,
	                          String encoding,
	                          FileRenamePolicy policy) throws IOException {
	    // Sanity check values
	    if (request == null)
	      throw new IllegalArgumentException("request cannot be null");
	    if (saveDirectory == null)
	      throw new IllegalArgumentException("saveDirectory cannot be null");
	    if (maxPostSize <= 0) {
	      throw new IllegalArgumentException("maxPostSize must be positive");
	    }

	    // Save the dir
	    File dir = new File(saveDirectory);

	    // Check saveDirectory is truly a directory
	    if (!dir.isDirectory())
	      throw new IllegalArgumentException("Not a directory: " + saveDirectory);

	    // Check saveDirectory is writable
	    if (!dir.canWrite())
	      throw new IllegalArgumentException("Not writable: " + saveDirectory);

	    // Parse the incoming multipart, storing files in the dir provided, 
	    // and populate the meta objects which describe what we found
	    MultipartParser parser = new MultipartParser(request, maxPostSize);
	    if (encoding != null) {
	      parser.setEncoding(encoding);
	    }

	    Part part;
	    while ((part = parser.readNextPart()) != null) {
	      String name = part.getName();
	      if (part.isParam()) {
	        // It's a parameter part, add it to the vector of values
	        ParamPart paramPart = (ParamPart) part;
	        String value = paramPart.getStringValue();
	        Vector existingValues = (Vector)parameters.get(name);
	        if (existingValues == null) {
	          existingValues = new Vector();
	          parameters.put(name, existingValues);
	        }
	        existingValues.addElement(value);
	      }
	      else if (part.isFile()) {
	        // It's a file part
	        FilePart filePart = (FilePart) part;
	        String fileName = filePart.getFileName();
	        if (fileName != null) {
	          filePart.setRenamePolicy(policy);  // null policy is OK
	          // The part actually contained a file
	          filePart.writeTo(dir);
	          files.put(name, new UploadedFile(dir.toString(),
	                                           filePart.getFileName(),
	                                           fileName,
	                                           filePart.getContentType()));
	        }
	        else { 
	          // The field did not contain a file
	          files.put(name, new UploadedFile(null, null, null, null));
	        }
	      }
	    }
	  }

	  public MultipartRequest(ServletRequest request,
	                          String saveDirectory) throws IOException {
	    this((HttpServletRequest)request, saveDirectory);
	  }

	  public MultipartRequest(ServletRequest request,
	                          String saveDirectory,
	                          int maxPostSize) throws IOException {
	    this((HttpServletRequest)request, saveDirectory, maxPostSize);
	  }

	  public Enumeration getParameterNames() {
	    return parameters.keys();
	  }

	  public Enumeration getFileNames() {
	    return files.keys();
	  }

	  public String getParameter(String name) {
	    try {
	      Vector values = (Vector)parameters.get(name);
	      if (values == null || values.size() == 0) {
	        return null;
	      }
	      String value = (String)values.elementAt(values.size() - 1);
	      return value;
	    }
	    catch (Exception e) {
	      return null;
	    }
	  }

	
	  public String[] getParameterValues(String name) {
	    try {
	      Vector values = (Vector)parameters.get(name);
	      if (values == null || values.size() == 0) {
	        return null;
	      }
	      String[] valuesArray = new String[values.size()];
	      values.copyInto(valuesArray);
	      return valuesArray;
	    }
	    catch (Exception e) {
	      return null;
	    }
	  }

	  public String getFilesystemName(String name) {
	    try {
	      UploadedFile file = (UploadedFile)files.get(name);
	      return file.getFilesystemName();  // may be null
	    }
	    catch (Exception e) {
	      return null;
	    }
	  }

	  public String getOriginalFileName(String name) {
	    try {
	      UploadedFile file = (UploadedFile)files.get(name);
	      return file.getOriginalFileName();  // may be null
	    }
	    catch (Exception e) {
	      return null;
	    }
	  }

	  public String getContentType(String name) {
	    try {
	      UploadedFile file = (UploadedFile)files.get(name);
	      return file.getContentType();  // may be null
	    }
	    catch (Exception e) {
	      return null;
	    }
	  }

	  public File getFile(String name) {
	    try {
	      UploadedFile file = (UploadedFile)files.get(name);
	      return file.getFile();  // may be null
	    }
	    catch (Exception e) {
	      return null;
	    }
	  }
	}


//	 A class to hold information about an uploaded file.
	//
	class UploadedFile {

	  private String dir;
	  private String filename;
	  private String original;
	  private String type;

	  UploadedFile(String dir, String filename, String original, String type) {
	    this.dir = dir;
	    this.filename = filename;
	    this.original = original;
	    this.type = type;
	  }

	  public String getContentType() {
	    return type;
	  }

	  public String getFilesystemName() {
	    return filename;
	  }

	  public String getOriginalFileName() {
	    return original;
	  }

	  public File getFile() {
	    if (dir == null || filename == null) {
	      return null;
	    }
	    else {
	      return new File(dir + File.separator + filename);
	    }
	  }
	}
