/*
 * Created on 2004. 12. 14.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.yundara.exception;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class MgrException extends Exception {
	private Exception e;

	public MgrException(Exception ex) {
		super(ex.getMessage());
		this.e = ex;
	}

	public MgrException(String msg) {
		super(msg);
	}

	public Exception getException() {
		return e;
	}
}
