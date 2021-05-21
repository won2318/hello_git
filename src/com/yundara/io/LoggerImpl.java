/*
 * Created on 2004. 12. 16.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.yundara.io;

import java.io.*;
import java.util.*;

import com.yundara.conf.*;

/**
 * @author Administrator *  * TODO To change the template for this generated type comment go to * Window - Preferences - Java - Code Style - Code Templates
 */


public abstract class LoggerImpl {
	
	public final static String version = "LoggerImpl V1.0";

    /**
     * 
     * @uml.property name="log"
     * @uml.associationEnd multiplicity="(0 1)"
     */
    private Logger log;

    /**
     * 
     * @uml.property name="srcLogger"
     * @uml.associationEnd multiplicity="(0 1)"
     */
    private Logger srcLogger;

	private boolean printable;
	private String siteName;

	private long CreateTime = System.currentTimeMillis();

	public LoggerImpl() {
		log = LoggerManager.getInstance().getSiteLogger();
		
		srcLogger = log;
		
	    SiteConf conf = SiteConf.getInstance();
	    String log_print = (String)conf.getConf("log_print");
	    if(log_print == null) log_print = "true";
	    printable = Boolean.valueOf(log_print).booleanValue();
	 
	}

	public LoggerImpl(String sname) {
		this.siteName = sname;
		
		log = LoggerManager.getInstance().getLogger(this.siteName + ".logfile");
		srcLogger = log;
		
		SiteConf conf = SiteConf.getInstance();
		
		Hashtable ht = (Hashtable)conf.getSubConfs().get(siteName);
		
		String log_print = (String)ht.get("log_print");
		
		if(log_print == null) {
			log_print = "false";
		}
		printable = Boolean.valueOf(log_print).booleanValue(); 
	}

	public final Logger setLogger(Logger log) {
		Logger old = this.log;
		this.log = log;
		return old;
	}

	public final Logger setLogger(String filename) {
		Logger old = this.log;
		try{
			this.log = new Logger( new FileWriter(filename, true) );
		} catch(IOException ex) {
		    log.printlog(ex);
		    old = null;
		}
		return old;
	}

	public final Logger setLogger(FileWriter fileWriter) {
		Logger old = this.log;
		this.log = new Logger( fileWriter );
		return old;
	}

	public final Logger setLogger(PrintWriter printWriter) {
		Logger old = this.log;
		this.log = new Logger( printWriter );
		return old;
	}

	public final Logger getLogger() {
		return log;
	}

    /**
     * 
     * @uml.property name="printable"
     */
    public final boolean getPrintable() {
        return this.printable;
    }

    /**
     * 
     * @uml.property name="printable"
     */
    public final boolean setPrintable(boolean printable) {
        boolean old = this.printable;
        this.printable = printable;
        return old;
    }


	public final void printLog(String msg) {
		if( printable && (log != null) ) log.printlog(msg);
	}

    /**
     * 
     * @uml.property name="createTime"
     */
    public final long getCreateTime() {
        return CreateTime;
    }

	
}
