/*
 * Created on 2005. 1. 17
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.multpart;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import javazoom.upload.UploadFile;
import javazoom.upload.UploadListener;
import javazoom.upload.UploadParameters;

/**
 * UploadListener implementation sample.
 */
public class MyUploadListener implements UploadListener, Serializable
{
  public static boolean DEBUG = false;
  private File _tmpFile = null;
  private boolean _uploaded = false;
  private boolean _cancelled = false;
  private int _size = -1;
  private int _totalSize = -1;
  private transient PrintStream ps = System.out;

  public MyUploadListener()
  {
    trace("MyUploadListener Constructor called");
  }

  public void setTracefile(String file) throws IOException
  {
    FileOutputStream fos = new FileOutputStream(file);
    ps = new PrintStream(fos,true);
    trace("setTracefile called");
  }

  /**
   * Callback when file upload is starting.
   * @param file
   */
  public void fileUploadStarted(File tmpfile, int contentlength, String contenttype)
  {
    trace("fileUploadStarted called : "+tmpfile+","+contentlength+","+contenttype);
    _tmpFile = tmpfile;
    _totalSize = contentlength;
    _uploaded = false;
    _cancelled = false;
    _size = 0;
  }

  /**
   * Callback when file upload is completed.
   * @param up
   * @param file
   */
  public void fileUploaded(UploadParameters up, UploadFile file)
  {
    trace("fileUploaded called : "+file.getFileName()+","+up.getAltFilename()+","+up.getStoreinfo());
    _uploaded = true;
    //file.reset();
  }

  /**
   * Callback when data chunk is loaded.
   * @param read
   */
  public void dataRead(int read)
  {
    trace("dataRead called : "+read);
    _size = _size + read;
  }

  /**
   * Return upload state.
   * @return
   */
  public boolean isFileUploaded()
  {
    trace("isFileUploaded called : "+_uploaded);
    return _uploaded;
  }

  /**
   * Return upload state.
   * @return
   */
  public boolean isFileUploadCancelled()
  {
    trace("isFileUploadCancelled called : "+_cancelled);
    return _cancelled;
  }

  /**
   * Returns length in KB for current uploading.
   * @return
   */
  public int getUploadedKBLength()
  {
    trace("getUploadedKBLength called : "+_size);
    int kblength = Math.round(_size*1.0f/1024.0f);
    return kblength;
  }

  /**
   * Returns length in bytes for current uploading.
   * @return
   */
  public int getUploadedLength()
  {
    trace("getUploadedLength called : "+_size);
    return _size;
  }

  /**
   * Returns ratio for current uploading.
   * @return
   */
  public int getUploadedRatio()
  {
    trace("getUploadedRatio called : "+_size+"/"+_totalSize);
    if (_totalSize > 0)
    {
      return (int) Math.round(_size*100.0f/_totalSize*1.0f);
    }
    else return -1;
  }

  /**
   * Returns length in bytes for upload file.
   * @return
   */
  public int getTotalLength()
  {
    trace("getTotalLength called : "+_totalSize);
    return _totalSize;
  }

  /**
   * Cancel Upload
   */
  public void cancel()
  {
    trace("cancel called ");
    _cancelled = true;
  }

  /**
   * Resets UploadStatus
   */
  public void reset()
  {
    trace("reset called : "+_totalSize);
    cleanLastupload();
    _tmpFile = null;
    _totalSize = -1;
    _uploaded = false;
    _cancelled = false;
    _size = -1;
  }

  /**
   * Deletes last uploaded file.
   */
  public void cleanLastupload()
  {
     if (_tmpFile != null)
     {
       String tmpFilename = _tmpFile.getName();
       _tmpFile.delete();
       trace("cleanLastupload called : "+tmpFilename);
     }
  }

  /**
   * Sends traces to PrintStream
   * @param msg
   */
  private void trace(String msg)
  {
    if (DEBUG == true)
    {
      Date d = new Date();
      SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
      if (ps != null)
      {
        ps.println(sdf.format(d)+" MyUploadListener1.0.4 : "+msg);
      }
      else
      {
        System.out.println(sdf.format(d)+" MyUploadListener1.0.4 : "+msg);
      }
    }
  }
}
