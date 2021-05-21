/*
 * Created on 2004. 12. 14.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.yundara.conf;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

public class SiteConfException extends Exception {
	private Exception e;

	public SiteConfException(String msg) {
		super(msg);
	}

	public SiteConfException(Exception ex) {
		super(ex.getMessage());
		this.e = ex;
	}

	public Exception getException() {
		return e;
	}
}
