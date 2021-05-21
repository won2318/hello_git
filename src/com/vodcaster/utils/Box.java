package com.vodcaster.utils;


import java.io.Serializable;
import java.lang.reflect.Array;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


public class Box implements Cloneable, Serializable
{

	public static String KEY = "_BOX";
	private Hashtable table = new Hashtable();

	public Box()
	{
		super();
	}

	/**
	 * box.request에 있는 파라메타 이름으로 해당 값을 가져온다..
	 * @param key
	 * @return
	 */
	public String getParameter(String key)
	{
		Object obj = null;

		String value = null;

		try
		{
			Object o = (Object)table.get(key);;
			Class c = o.getClass();
			if ( o == null )
			{
				value = "";
			}
			else if( c.isArray() )
			{
				int length = Array.getLength(o);
				if ( length == 0 )
				{
					value = "";
				}
				else
				{
					Object item = Array.get(o, 0);
					if ( item == null ) value = "";
					else value = item.toString();
				}
			}
			else
			{
				value = o.toString();
			}
		}
		catch(Exception e)
		{
			value = "";
		}


		return value;

	}

	/**
	 *	파라메타 이름으로 해당 값을 가져온다..
	 * @param key
	 * @return
	 */
	public String getParameter(String key, String defalutValue)
	{
		return this.getString(key, defalutValue);
	}

	/**
	 *	파라메타 이름으로 해당 배값을 가져온다..
	 * @param key
	 * @return
	 */
	public String[] getParameterValues(String key)
	{
		return this.getStrArray(key);
	}

	/**
	 * 세션값 가져온다.
	 * @param key
	 * @return
	 */
	public String getSession(String key)
	{
		return (String) this.get(key + Box.SESSION);
	}
	/**
	 * 쿠키값을 가져온다.
	 * @param key
	 * @return
	 */
	public String getCookie(String key)
	{
		return (String) this.get(key + Box.COOKIE);
	}

	/**
	 * URI을 가져온다.
	 * @param key
	 * @return
	 */
	public String getRequestURI()
	{
		return (String) this.get(Box.REQUESTURI);
	}

	/**
	 * 파라미터 값과 종류(페이지/리퀘스트/세션/쿠키)로 해당값을 가져온다..
	 * @param key
	 * @param mode
	 * @return
	 */
	public Object get(String key, String mode)
	{
		String keyname = key;
		if (mode != null)
			keyname = key + mode;
		return table.get(keyname);
	}

	/**
	 * Key값으로 이름을 가져온다..
	 * @param key
	 * @return
	 */
	public String getString(String key)
	{
		String value = null;
		try {
			Object o = (Object)this.get(key);
			Class c = o.getClass();
			if ( o == null ) value = "";
			else if( c.isArray() ) {
				int length = Array.getLength(o);
				if ( length == 0 ) value = "";
				else {
					Object item = Array.get(o, 0);
					if ( item == null ) value = "";
					else value = item.toString();
				}
			}
			else 	value = o.toString();
		}
		catch(Exception e) {
			value = "";
		}

		return value;
	}


	/**
	 * check box 와 같이 같은 name에 대해 여러 value들이 String의 Vector로 넘겨준다.
	 * @return Vector
	 * @param key java.lang.String
	 */
	public ArrayList getArrayString(String key) {
		ArrayList arr = new ArrayList();
		try {
			Object o = (Object)this.get(key);
			Class c = o.getClass();
			if ( o != null ) {
				if( c.isArray() ) {
					int length = Array.getLength(o);
					if ( length != 0 ) {
						for(int i=0; i<length;i++) {
							Object tiem = Array.get(o, i);
							if (tiem == null ) arr.add("");
							else arr.add(tiem.toString());
						}
					}
				}
				else
				arr.add(o.toString());
			}
		}
		catch(Exception e) {}
		return arr;
	}





	/**
	 * Key값으로 배열을 가져온다..
	 * @param key
	 * @return
	 */
	public String[] getStrArray(String key)
	{
		String[] rtnStr = null;
		Object obj = this.get(key);
		if (obj != null)
		{
			rtnStr = ((String[]) obj);
		}
		else
		{
			rtnStr = null;
		}
		return rtnStr;
	}



	/**
	 * key값으로 밸류 가져오고 널일경우 기본값 반환
	 * @param key
	 * @param defaultValue
	 * @return
	 */
	public String getString(String key, String defaultValue)
	{
		String rtnStr = defaultValue;
		try
		{
			rtnStr = this.getString(key);
			if(rtnStr==null || "".equals(rtnStr.trim())) rtnStr = defaultValue;
		}
		catch (Exception e)
		{
		}
		return rtnStr;
	}



	/**
	 * 	키값을 가지고 오브젝트 반환한다. (페이지/리퀘스트/세션/박스)
	 * @param key
	 * @return
	 */
	public Object get(String key)
	{
		Object obj = null;

		obj = table.get(key + Box.PAGE);
		if (obj != null)
			return obj;

		obj = table.get(key + Box.REQUEST);
		if (obj != null)
			return obj;

		obj = table.get(key + Box.SESSION);
		if (obj != null)
			return obj;

		obj = table.get(key + Box.COOKIE);
		if (obj != null)
			return obj;

		return obj;
	}

	/**
	 * int 형으로 값 반환
	 * @param key
	 * @return
	 */
	public int getInt(String key)
	{
		String temp = this.getString(key, "0");
		int rtnInt = 0;
		try
		{
			rtnInt = Integer.parseInt(temp);
		}
		catch (Exception e)
		{
		}
		finally
		{

		}
		return rtnInt;
	}

	/**
	 * int 형으로 값 반환
	 * @param key
	 * @return
	 */
	public int getMoney(String key)
	{
		String temp = this.getString(key, "0");
		if(temp!=null) {
			temp = temp.replaceAll("," , "");
			//temp = TextUtil.replace(temp, "," ,"");
		}
		int rtnInt = 0;
		try
		{
			rtnInt = Integer.parseInt(temp);
		}
		catch (Exception e)
		{
		}
		finally
		{

		}
		return rtnInt;
	}

	/**
	 * int 형으로 값 반환
	 * @param key
	 * @return
	 */
	public String getReplaceString(String key , String removeWord)
	{
		String temp = this.getString(key, "");
		if(temp!=null) {
			temp.replaceAll(removeWord , "");
			//temp = TextUtil.replace(temp, "," ,"");
		}
		return temp;
	}


	/**
	 * int 형으로 값 반환, null일경우 defaultValue 리턴
	 * @param key
	 * @return
	 */
	public int getInt(String key, int defaultValue)
	{
		String temp = this.getString(key);
		int rtnInt = 0;
		try
		{
			if (temp.equals(""))
				rtnInt = defaultValue;
			else
				rtnInt = Integer.parseInt(temp);
		}
		catch (Exception e)
		{
		}
		finally
		{

		}
		return rtnInt;
	}

	/**
	 * long 형으로 값 반환
	 * @param key
	 * @return
	 */
	public long getLong(String key)
	{
		String temp = this.getString(key, "0");
		long rtnInt = 0;
		try
		{
			rtnInt = Long.parseLong(temp);
		}
		catch (Exception e)
		{
		}
		finally
		{

		}
		return rtnInt;
	}


	/**
	 * double 형으로 값 반환
	 * @param key
	 * @return
	 */
	public double getDouble(String key)
	{
		String temp = this.getString(key, "0");
		double rtnInt = 0;
		try
		{
			rtnInt = Double.parseDouble(temp);
		}
		catch (Exception e)
		{
		}
		finally
		{
		}

		return rtnInt;

	}

	/**
	 * 요청에 대해  box로 값을 설정...
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static Box set(HttpServletRequest request) throws Exception
	{
		Box box = new Box();
		try
		{
			box.setPage(request);
			box.setRequest(request);
			box.setSession(request);
			box.setCookie(request);
			box.setRequestURI(request);
		}
		catch (Exception e)
		{
			e.printStackTrace();
			throw e;
		}
		return box;
	}


	/**
	 * 주어진 페이지의 파라미터 값을 키 :밸류값으로 Box에 저장
	 * @param request
	 */
	public void setPage(HttpServletRequest request)
	{
		try
		{
			Enumeration keys = request.getParameterNames();
			String key = "";
			while (keys.hasMoreElements())
			{
				key = (String) keys.nextElement();
				String[] value = request.getParameterValues(key);
				this.set(key + Box.PAGE, value);
			}
		}
		catch (Exception e)
		{
		}
	}


	/**
	 * 	사용자 세션을 키:밸류로 획득하여 Box에 저장
	 * @param request
	 */
	public void setSession(HttpServletRequest request)
	{
		try
		{
			HttpSession session = request.getSession();
			Enumeration sessions = session.getAttributeNames();

			String key = "";
			while (sessions.hasMoreElements())
			{
				key = (String) sessions.nextElement();
				this.set(key + Box.SESSION, session.getAttribute(key));
			}
		}
		catch (Exception e)
		{
		}
	}

	/**
	 * 사용자의 쿠키를 키:밸류로 획득하여 Box 에 저장
	 * @param request
	 */
	public void setCookie(HttpServletRequest request)
	{
		try
		{
			Cookie[] cookies = request.getCookies();
			Cookie cookie = null;
			for (int i = 0; i < cookies.length; i++)
			{
				cookie = cookies[i];
				//this.set(cookie.getName() + Box.COOKIE, URLEncoder.encode(cookie.getValue(), "euc-kr"));
				this.set(cookie.getName() + Box.COOKIE, URLEncoder.encode(cookie.getValue()));
			}
		}
		catch (Exception e)
		{
		}

	}

	/**
	 * 리퀘스트를 받아서 키:밸류값으로 획득하여 Box에 저장..
	 * @param request
	 */
	public void setRequest(HttpServletRequest request)
	{
		try
		{
			Enumeration e = request.getAttributeNames();

			String key = "";
			while (e.hasMoreElements())
			{
				key = (String) e.nextElement();
				this.set(key + Box.REQUEST, request.getAttribute(key));
			}
		}
		catch (Exception e)
		{
		}

	}


	/**
	 * 리퀘스트를 받아서 RequestURI setting
	 * @param request
	 */
	public void setRequestURI(HttpServletRequest request)
	{

		try
		{
			this.set(Box.REQUESTURI, request.getRequestURI());
		}
		catch (Exception e)
		{
		}

	}

	/**
	 * 박스에 있는 Key값을 삭제한다..
	 * @param key
	 * @param mode
	 */
	public void remove(String key, String mode)
	{
		if (this.table.containsKey(key + mode))
		{
			this.table.remove(key + mode);
		}
	}




	/**
	 * 	박스에 있는 특정 값을 변경 한다..
	 * @param key
	 * @param mode
	 * @param newStr
	 */
	public void replace(String key, String mode, String newStr)
	{
		if (this.table.containsKey(key + mode))
		{
			this.table.remove(key + mode);
		}
		this.set(key + mode, newStr);
	}
	public void replace(String key, String mode, Object newObj)
	{
		if (this.table.containsKey(key + mode))
		{
			this.table.remove(key + mode);
		}
		this.set(key + mode, newObj);
	}





	/*
	 * 	다음 setter 관련 ..
	 * 	Hashmap에 입력...
	 * */
	public void set(String key, String value)
	{
		this.table.put(key, value);
	}
	public void set(String key, int value)
	{
		this.table.put(key, "" + value);
	}
	public void set(String key, long value)
	{
		this.table.put(key, "" + value);
	}
	public void set(String key, double value)
	{
		this.table.put(key, "" + value);
	}
	public void set(String key, boolean value)
	{
		this.table.put(key, "" + value);
	}
	public void set(String key, Object obj)
	{
		this.table.put(key, obj);
	}
	public void set(String key, String[] value)
	{
		this.table.put(key, value);
	}
	public void setInt(String key, int value)
	{
		this.table.put(key, new Integer(value));
	}
	public void setLong(String key, long value)
	{
		this.table.put(key, new Long(value));
	}
	public void setDouble(String key, double value)
	{
		this.table.put(key, new Double(value));
	}
	public void setBoolean(String key, boolean value)
	{
		this.table.put(key, new Boolean(value));
	}






	/**
	 * Box 값 출력.... 줄줄이....
	 * @return
	 */
	public synchronized String getInfo()
	{
		StringBuffer rtnStr = new StringBuffer();;
		Enumeration e = table.keys();
		String key = "";
		Object value=null;

		rtnStr.append("  :  ===== BOX  =================== \r\n");
		while (e.hasMoreElements())
		{
			key = (String) e.nextElement();
			value = table.get(key);

			if(value==null){
				value = "";
			}

			Class c = value.getClass();
			if(c.isArray()){
				int length = Array.getLength(value);
				if ( length == 0 ) 	value = "";
				else if ( length == 1 ) {
						Object item = Array.get(value, 0);
						if ( item == null ) value = "";
						else value = item.toString();
				} else {
					StringBuffer valueBuf = new StringBuffer();
					valueBuf.append("[");
					for ( int j=0;j<length;j++) {
							Object item = Array.get(value, j);
							if ( item != null ) valueBuf.append(item.toString());
							if ( j<length-1) valueBuf.append(",");
					}
					valueBuf.append("]");
					value = valueBuf.toString();
				}

			} else {
				if(value instanceof String){
					value = (String)value;
				} else {
					value = value.toString();
				}
			}


			rtnStr.append( ">  ["+key+"] \t : "+ value + "\r\n");

		}
		rtnStr.append(" ===== BOX SIZE : " + table.size() +" ============================== \r\n");
		//System.out.println( rtnStr.toString() );
		return rtnStr.toString();
	}
	/**
	 * Box 값 출력.... 줄줄이....
	 * @return
	 */
	public String getFormList()
	{
		StringBuffer rtnStr = new StringBuffer();;
		Enumeration e = table.keys();
		String key = "";
		Object value=null;

		while (e.hasMoreElements())
		{
			key = (String) e.nextElement();
			value = table.get(key);

			if(value==null){
				value = "";
			}

			if(key != null && !(key.endsWith(Box.COOKIE)|| key.endsWith(Box.SESSION) || key.endsWith(Box.REQUEST))){
				if(value instanceof String ){
					value = (String)value;
				} else if(value instanceof String[]){
					String[] arrValue = (String[])value;
					value = arrValue[0];
				}

				if("null".equals(value)) value="";
				rtnStr.append( "<input type='hidden' name='"+key+"' value='"+ value + "' > \n");

			}
		}

		return rtnStr.toString();
	}


	public String getFormArrayList()
	{
		StringBuffer rtnStr = new StringBuffer();;
		Enumeration e = table.keys();
		String key = "";
		Object value=null;

		while (e.hasMoreElements())
		{
			key = (String) e.nextElement();
			value = table.get(key);

			if(value==null){
				value = "";
			}

			if(key != null && !(key.endsWith(Box.COOKIE)|| key.endsWith(Box.SESSION) || key.endsWith(Box.REQUEST))){
				if(value instanceof String ){
					value = (String)value;

					if("null".equals(value)) value="";
					rtnStr.append( "<input type='hidden' name='"+key+"' value=\""+ value + "\" > \n");

				} else if(value instanceof String[]){
					String[] arrValue = (String[])value;
					for( int i = 0 ; i < arrValue.length ; i++ ){
						value = arrValue[i];

						if("null".equals(value)) value="";
						rtnStr.append( "<input type='hidden' name='"+key+"' value=\""+ value + "\" > \n");
					}
				}

			}
		}

		return rtnStr.toString();
	}


	public int getBoxSize(){
		return this.table.size();
	}

	/**
	 * 	Box 를 복제
	 */
	public Object clone() {

		Box newbox = new Box();

		Enumeration e = table.keys();
		while(e.hasMoreElements()) {
			String key = (String) e.nextElement();
			Object value =  table.get(key);
			newbox.set(key,value);
		}
		return newbox;
	}

	public static final String PAGE = "";
	public static final String REQUEST = "_REQUEST";
	public static final String SESSION = "_SESSION";
	public static final String COOKIE = "_COOKIE";
	public static final String REQUESTURI = "_REQUESTURI";

	public static final String FILE = "_FILE";
	public static final String FILE_NAME = "_FILE_NAME";
	public static final String FILE_SYSTEMNAME = "_FILE_SYSTEMNAME";
	public static final String FILE_ORGINALNAME = "_FILE_ORGINALNAME";
}
