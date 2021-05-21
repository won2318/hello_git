/*
 * Created on 2004. 12. 16.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.yundara.io;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class LoggerException extends Exception {
	
	private Exception e;

	public LoggerException(Exception ex) {
		super(ex.getMessage());
		this.e = ex;
	}

	public LoggerException(String msg) {
		super(msg);
	}

	public Exception getException() {
		return e;
	}
}
