
package com.vodcaster.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

 
public abstract class Handler implements java.io.Serializable {

	public HttpServletRequest request;
	public HttpServletResponse response;
	public Box box;

	public Handler(){
	}

	public Handler( HttpServletRequest request ){
		this.request = request;
		try{
			this.box = Box.set(request);
		}catch(Exception e){
			System.out.println( "Handler(request) : " + e.toString() );
			this.box = new Box();
		}
		request.setAttribute(Box.KEY, box);
	}

	public Handler( HttpServletRequest request, HttpServletResponse response ){
		this.request = request;
		this.response = response;
		try{
			this.box = Box.set(request);
		}catch(Exception e){
			System.out.println( "Handler(request,response) : " + e.toString() );
			this.box = new Box();
		}
		request.setAttribute(Box.KEY, box);
	}
 
}
