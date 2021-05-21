package dbcp;

import javax.naming.*;
import javax.sql.*;

import com.yundara.io.LoggerImpl;

import java.io.InputStream;
import java.io.Reader;
import java.sql.*;
import java.util.Hashtable;
import java.util.Vector;



public class DbcpMan2 extends LoggerImpl{
	
	
	private static DbcpMan2 dbMan = null;
	public DbcpMan2(){
		
	}

	public static DbcpMan2 getDBMan(){
		if(dbMan == null) dbMan = new DbcpMan2();
		return dbMan;
	}
	public Connection getConnection(){
		Connection conn=null;
		try{
			Context  initCtx = null;;
		    
		    DataSource ds = null;
		    
		    try {
		    	initCtx = new InitialContext();
		    	Context envCtx = (Context) initCtx.lookup("java:/comp/env");
		        ds = (DataSource)envCtx.lookup("jdbc/vodcaster_suwonnews");
		    } catch(Exception e) {
		            System.out.println("error : " + e);
		   }
		   
		   conn = ds.getConnection();
		   
		}catch(Exception ex){
			printLog("getConnection error : " + ex);
		}
		return conn;
	}
	
	/****************************************************************
	여러행을 가진 Select문의 결과 집합을 Vector로 리턴한다.
	@return : 열과 행들로 표현된 이중 <code>Vector</code> 
			: 쿼리결과값이 없거나 예외발생 -> 빈백터
	        : 컨넥션 요청 실패시 null
*****************************************************************/
public Vector selectEntities(String query){
	Vector rows = new Vector();
	if(query == null || query.length()<=0){
		return null;
	}
	
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	ResultSetMetaData metaData	= null;
	
	try{
		conn = this.getConnection();
		if ( isClosed(conn) ) {
			if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
			if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
			if(conn != null) {
				try{
					if(!conn.isClosed()){
						conn.close();
					}
				} catch(SQLException ex){
					printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
				}finally{
					conn = null;
				}
			}
			return null;
		} else{   

			pstmt = conn.prepareStatement(query);
			if(pstmt == null){
				if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
				if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
				if(conn != null) {
					try{
						if(!conn.isClosed()){
							conn.close();
						}
					} catch(SQLException ex){
						printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
					}finally{
						conn = null;
					}
				}
				return null;
			}else{
				rs = pstmt.executeQuery();
				if(rs != null ){
			        metaData = rs.getMetaData();
			        int numberOfColumns = metaData.getColumnCount();
			
			        while (rs.next()){
			            Vector columns = new Vector();
			            
			            for (int i = 1; i <= numberOfColumns; i++){
							int type = metaData.getColumnType(i);
							Object data = rs.getObject(i);
							columns.addElement( chkNull(data, type) );
			            }
			            rows.addElement(columns);
			        }
				}
			}
		}
	}catch(SQLException e){
		printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶쿼리실행중 예외발생-selectEntities(query)■■■▶\n" + e.getMessage() );
		printLog(query);
	}catch(NullPointerException e){
		printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶필드에 Null값이 포함되어있읍니다.-selectEntities(query)■■■▶\n" + e.getMessage() );
		printLog(query);
	}catch(Exception e){
		printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶알수없는 오류발생.-selectEntities(query)■■■▶\n" + e.getMessage() );
		printLog(query);
	}finally{
		if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
		if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
		if(conn != null) {
			try{
				if(!conn.isClosed()){
					conn.close();
				}
			} catch(SQLException ex){
				printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
			}finally{
				conn = null;
			}
		}
	}
	return rows;
}

/**
	여러행을 가진 Select문의 결과 집합을 Hashtable로 리턴한다.
	@return Hashtable로 된 열을 가지고있는 백터 행 
*/

public Vector selectHashEntities(String query){
	Vector rows = new Vector();
	if(query == null || query.length()<=0){
		return null;
	}
	
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	ResultSetMetaData metaData	= null;
	
	try{
		//printLog( toString() + "(" + "VOD" + ")" + "\n\n\n■■■▶DBPool요청-selectHashEntities(query)" );
		conn = this.getConnection();
		if ( isClosed(conn) ) {
			if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
			if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
			if(conn != null) {
				try{
					if(!conn.isClosed()){
						conn.close();
					}
				} catch(SQLException ex){
					printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
				}finally{
					conn = null;
				}
			}
			return null;
		}else{       
			pstmt = conn.prepareStatement(query);
			if(pstmt == null){
				if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
				if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
				if(conn != null) {
					try{
						if(!conn.isClosed()){
							conn.close();
						}
					} catch(SQLException ex){
						printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
					}finally{
						conn = null;
					}
				}
				return null;
			}else{
				//printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶쿼리실행-selectHashEntities(queryv)■■■▶\n" + query );
				rs = pstmt.executeQuery();
				
				if(rs != null){
			        metaData = rs.getMetaData();
			        int numberOfColumns = metaData.getColumnCount();
					int rowCount = 0;
		 
			        while (rs.next()){
			            Hashtable columns = new Hashtable();
			            for (int i = 1; i <= numberOfColumns; i++){
							int type = metaData.getColumnType(i);
							Object data = rs.getObject(i); 
							columns.put( metaData.getColumnLabel(i).toLowerCase(), chkNull(data, type) );
			            } 
			            rows.addElement(columns);
						rowCount++;
			        }
				}
			}
		}
	}catch(SQLException e){
		printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 예외발생-selectHashEntities(query)■■■▶\n" + e.getMessage() );
		printLog(query);
	}catch(NullPointerException e){
		printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶필드에 Null값이 포함되어있읍니다.-selectHashEntities(query)■■■▶\n" + e.getMessage() );
		printLog(query);
	}catch(Exception e){
		printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶알수없는 오류발생.-selectHashEntities(query)■■■▶\n" + e.getMessage() );
		printLog(query);
	}finally{
		if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
		if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
		if(conn != null) {
			try{
				if(!conn.isClosed()){
					conn.close();
				}
			} catch(SQLException ex){
				printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
			}finally{
				conn = null;
			}
		}
	}
	return rows;
}


/**
	하나의 행을 가진 Select문의 결과 집합을 Vector로 리턴한다.
	@return 열들로 표현된 하나의 <code>Vector</code> 
*/
public Vector selectEntity(String query){
	Vector row = new Vector();
	if(query == null || query.length()<=0){
		return null;
	}
	
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	ResultSetMetaData metaData	= null;
	
	try{
		//printLog( toString() + "(" + "VOD" + ")" + "\n\n\n■■■▶DBPool요청-selectEntity(query, "VOD")" );
		conn = this.getConnection();
		if ( isClosed(conn) ) {
			if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
			if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
			if(conn != null) {
				try{
					if(!conn.isClosed()){
						conn.close();
					}
				} catch(SQLException ex){
					printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
				}finally{
					conn = null;
				}
			}
			return null;
		}else{

			pstmt = conn.prepareStatement(query);
			if(pstmt == null){
				if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
				if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
				if(conn != null) {
					try{
						if(!conn.isClosed()){
							conn.close();
						}
					} catch(SQLException ex){
						printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
					}finally{
						conn = null;
					}
				}
				return null;
			}else{
				rs = pstmt.executeQuery();
				if(rs != null){
			        metaData = rs.getMetaData();
			        int numberOfColumns = metaData.getColumnCount();
			
			        if(rs.next()==true){
			            for (int i = 1; i <= numberOfColumns; i++){
							int type = metaData.getColumnType(i);
							Object data = rs.getObject(i);
							row.addElement( chkNull(data, type) );
			            }
			        }
				}
			}
		}
	}catch(SQLException e){
		printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 예외발생-selectEntity(query)■■■▶\n" + e.getMessage() );
		printLog(query);
	}catch(NullPointerException e){
		printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶필드에 Null값이 포함되어있읍니다.-selectEntity(query)■■■▶\n" + e.getMessage() );
		printLog(query);
	}catch(Exception e){
		printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶알수없는 오류발생.-selectEntity(query)■■■▶\n" + e.getMessage() );
		printLog(query);
	}finally{
		if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
		if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
		if(conn != null) {
			try{
				if(!conn.isClosed()){
					conn.close();
				}
			} catch(SQLException ex){
				printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
			}finally{
				conn = null;
			}
		}
	}
	return row;
}


public Vector selectHashEntity(String query){
	Vector row = new Vector();
	if(query == null || query.length()<=0){
		return null;
	}
	
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	ResultSetMetaData metaData	= null;
	
	try{
		//printLog( toString() + "(" + "VOD" + ")" + "\n\n\n■■■▶DBPool요청-selectHashEntity(query)" );
		conn = this.getConnection();
		if ( isClosed(conn) ) {
			if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
			if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
			if(conn != null) {
				try{
					if(!conn.isClosed()){
						conn.close();
					}
				} catch(SQLException ex){
					printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
				}finally{
					conn = null;
				}
			}
			return null;
		}else{
			pstmt = conn.prepareStatement(query);
			if(pstmt == null) {
				if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
				if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
				if(conn != null) {
					try{
						if(!conn.isClosed()){
							conn.close();
						}
					} catch(SQLException ex){
						printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
					}finally{
						conn = null;
					}
				}
				return null;
			}else{
				rs = pstmt.executeQuery();
				if(rs != null){
		
			        metaData = rs.getMetaData();
			        int numberOfColumns = metaData.getColumnCount();
			        if(rs.next()==true){
			            Hashtable columns = new Hashtable();
			            for (int i = 1; i <= numberOfColumns; i++){
							int type = metaData.getColumnType(i);
							
							Object data = rs.getObject(i);
							
							columns.put( metaData.getColumnLabel(i).toLowerCase(), chkNull(data, type) );
			            }
						row.addElement(columns);
			        }
				}
			}
		}
	} catch(SQLException e){
		printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 예외발생-selectHashEntity(query)\n" + e.getMessage() );
		printLog(query);
	}catch(NullPointerException e){
		printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶필드에 Null값이 포함되어있읍니다.-selectHashEntity(query)\n" + e.getMessage() );
		printLog(query);
	}catch(Exception e){
		printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶알수없는 오류발생.-selectHashEntity(query)\n" + e.getMessage() );
		printLog(query);
	} finally{
		if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
		if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
		if(conn != null) {
			try{
				if(!conn.isClosed()){
					conn.close();
				}
			} catch(SQLException ex){
				printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
			}finally{
				conn = null;
			}
		}
	}

	return row;
}
/*
 * DataBase 커넥션 여부 리턴 
 */
public boolean isClosed(Connection conn)
{
	boolean isClosed = false;
	try
	{
		if( null == conn || (conn != null && conn.isClosed()) )
		{
			isClosed = true;
		}
		else
		{
			isClosed = false;
		}
	}
	catch( SQLException _se )
	{
	}
	return isClosed;
}
/**
	하나의 SQL문으로 구성된 Insert, Update, Delete문의 처리 결과를 리턴한다.
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1, 커넥션 에러일 경우 -2
*/

public int updateEntities(String updateQuery){
	int updateRows = -1;
	if(updateQuery == null || updateQuery.length()<=0){
		return updateRows;
	}
	
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	try{
		//printLog( toString() + "(" + "VOD" + ")" + "\n\n\n■■■▶DBPool요청-updateEntities(updateQuery)" );
		conn = this.getConnection();	

		if ( isClosed(conn) ) {
			if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
			if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
			if(conn != null) {
				try{
					if(!conn.isClosed()){
						conn.close();
					}
				} catch(SQLException ex){
					printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
				}finally{
					conn = null;
				}
			}
			return -1;
		} else{     	
	        conn.setAutoCommit(false);
	        pstmt = conn.prepareStatement(updateQuery);
			if(pstmt == null){
	            conn.setAutoCommit(true);
	            if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
	    		if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
	    		if(conn != null) {
	    			try{
	    				if(!conn.isClosed()){
	    					conn.close();
	    				}
	    			} catch(SQLException ex){
	    				printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
	    			}finally{
	    				conn = null;
	    			}
	    		}
				return -1;
			}else{
	
				updateRows = pstmt.executeUpdate();
				try
			    {
			        if(conn != null && !conn.getAutoCommit()){ 
			        	conn.commit();
			        	conn.setAutoCommit(true);
			        }
			    }
			    catch(SQLException e){printLog("commit SQLException error " +  e);}
			    catch(Exception e)   {printLog("commit Exception error" +  e);}
			}
		}
	}catch(SQLException e){
		printLog(updateQuery);
        try{
			printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 예외발생-updateEntities(updateQuery)\n" + e.getMessage() );
			if(conn != null && !conn.isClosed()){
				if(!conn.getAutoCommit()){
					conn.rollback();
					conn.setAutoCommit(true);
				}
			}
		}catch(SQLException ee){
			printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 예외발생(rollback failed)-updateEntities(updateQuery)\n" + e.getMessage() );
		}
		updateRows = -1;
	}finally{
		if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
		if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
		if(conn != null) {
			try{
				if(!conn.isClosed()){
					conn.close();
				}
			} catch(SQLException ex){
				printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
			}finally{
				conn = null;
			}
		}
	}
	return updateRows;
}

/**
	여러개의 SQL문으로 구성된 Insert, Update, Delete문의 처리 결과를 리턴한다.
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1, 커넥션 에러일 경우 -2, 기타에러 -3
*/

public int updateEntities(String[] updateQuery){
	int updateRows = 0;
	if(updateQuery == null || updateQuery.length <= 0){
		return -2;
	}
	
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	try{
		//printLog( toString() + "(" + "VOD" + ")" + "\n\n\n■■■▶DBPool요청-updateEntities(updateQuery[])" );
		conn = this.getConnection();	
		if ( isClosed(conn) ) {
			if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
			if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
			if(conn != null) {
				try{
					if(!conn.isClosed()){
						conn.close();
					}
				} catch(SQLException ex){
					printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
				}finally{
					conn = null;
				}
			}
			return -2;
		}else{
	        conn.setAutoCommit(false);
			
			if(updateQuery != null && updateQuery.length > 0){
				for(int i=0; i < updateQuery.length; i++){
					pstmt = conn.prepareStatement(updateQuery[i]);
					if(pstmt == null){
						try
					    {
					        if(conn != null && !conn.getAutoCommit()){ 
					        	conn.commit();
					        	conn.setAutoCommit(true);
					        }
					    }
					    catch(SQLException e){printLog("commit SQLException error " +  e);}
					    catch(Exception e)   {printLog("commit Exception error" +  e);}
					    if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
						if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
						if(conn != null) {
							try{
								if(!conn.isClosed()){
									conn.close();
								}
							} catch(SQLException ex){
								printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
							}finally{
								conn = null;
							}
						}
						return -2;
					}
					updateRows += pstmt.executeUpdate();
					if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
				}
			}
	
			try
		    {
		        if(conn != null && !conn.getAutoCommit()){ 
		        	conn.commit();
		        	conn.setAutoCommit(true);
		        }
		    }
		    catch(SQLException e){printLog("commit SQLException error " +  e);}
		    catch(Exception e)   {printLog("commit Exception error" +  e);}
		}
	}catch(SQLException e){
        try{
			printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 예외발생-updateEntities(updateQuery[])\n" + e.getMessage() );
			if(conn != null && !conn.isClosed()){
				if(!conn.getAutoCommit()){
					conn.rollback();
					conn.setAutoCommit(true);
				}
			}
		}catch(SQLException ee){
			printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 예외발생(rollback failed)-updateEntities(updateQuery[])\n" + ee.getMessage() );
		}
		updateRows = -1;
	} catch(Exception e) {
		printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 예외발생-updateEntities(updateQuery[])\n" + e.getMessage() );
		updateRows = -3;
	} finally{
		if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
		if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
		if(conn != null) {
			try{
				if(!conn.isClosed()){
					conn.close();
				}
			} catch(SQLException ex){
				printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
			}finally{
				conn = null;
			}
		}
	}
	return updateRows;
}



/*▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
	▒  updateEntities( Vector, String ) 추가되었습니다.                          ▒
▒  2003-07-23, Kimg JongJin                                                  ▒
	▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒*/
/**
	여러개의 SQL문으로 구성된 Insert, Update, Delete문의 처리 결과를 리턴한다.
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1, 커넥션 에러일 경우 -2, 기타에러 -3
*/



/*▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
	▒  updateEntities( Vector ) 추가되었습니다.                                  ▒
▒  2003-07-23, Kimg JongJin                                                  ▒
	▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒*/
public int updateEntities(Vector updateQuery){
	int updateRows = 0;
	if(updateQuery == null || updateQuery.size()<=0){
		return 0;
	}
	
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	try{
		//printLog( toString() + "(" + "VOD" + ")" + "\n\n\n■■■▶DBPool요청-updateEntities(vector)" );
		conn = this.getConnection();	
		if ( isClosed(conn) ) {
			if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
			if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
			if(conn != null) {
				try{
					if(!conn.isClosed()){
						conn.close();
					}
				} catch(SQLException ex){
					printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
				}finally{
					conn = null;
				}
			}
			return -2;
		}else{
			conn.setAutoCommit(false);
			if(updateQuery != null && updateQuery.size()>0){
				
				for(int i=0; i < updateQuery.size(); i++){
					
					pstmt = conn.prepareStatement(( String )updateQuery.elementAt( i ));
					if(pstmt == null){
						try
					    {
					        if(conn != null && !conn.getAutoCommit()){ 
					        	conn.commit();
					        	conn.setAutoCommit(true);
					        }
					    }
					    catch(SQLException e){printLog("commit SQLException error " +  e);}
					    catch(Exception e)   {printLog("commit Exception error" +  e);}
					    if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
						if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
						if(conn != null) {
							try{
								if(!conn.isClosed()){
									conn.close();
								}
							} catch(SQLException ex){
								printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
							}finally{
								conn = null;
							}
						}
						return 0;
					}
					//printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶쿼리실행-updateEntities(vector)\n" + ( String )updateQuery.elementAt( i ) );
					updateRows += pstmt.executeUpdate(  );
					if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
				}
			}
	
			try
		    {
		        if(conn != null && !conn.getAutoCommit()){ 
		        	conn.commit();
		        	conn.setAutoCommit(true);
		        }
		    }
		    catch(SQLException e){printLog("commit SQLException error " +  e);}
		    catch(Exception e)   {printLog("commit Exception error" +  e);}
		}
	}catch(SQLException e){
        try{
			printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 예외발생-updateEntities(vector)\n" + e.getMessage() );
			if(conn != null && !conn.isClosed()){
				if(!conn.getAutoCommit()){
					conn.rollback();
					conn.setAutoCommit(true);
				}
			}
		}catch(SQLException ee){
			printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 예외발생(rollback failed)-updateEntities(vector)\n" + ee.getMessage() );
		}
		updateRows = -1;
	} catch(Exception e) {
		printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 예외발생-updateEntities(vector)\n" + e.getMessage() );
		updateRows = -3;
	} finally{
		if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
		if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
		if(conn != null) {
			try{
				if(!conn.isClosed()){
					conn.close();
				}
			} catch(SQLException ex){
				printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
			}finally{
				conn = null;
			}
		}
	}
	return updateRows;
}



public Vector executeQuery(String updateQuery, String selectQuery){
	
	Vector rows = new Vector();
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	ResultSetMetaData metaData	= null;
	
	try{
		conn = this.getConnection();	
		if ( isClosed(conn) ) {
			if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
			if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
			if(conn != null) {
				try{
					if(!conn.isClosed()){
						conn.close();
					}
				} catch(SQLException ex){
					printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
				}finally{
					conn = null;
				}
			}
			return null;
		}else{
			conn.setAutoCommit(false);
			if(updateQuery != null && updateQuery.length()> 0){
	            
				pstmt = conn.prepareStatement(updateQuery);
				if(pstmt == null){
					try
				    {
				        if(conn != null && !conn.getAutoCommit()){ 
				        	conn.commit();
				        	conn.setAutoCommit(true);
				        }
				    }
				    catch(SQLException e){printLog("commit SQLException error " +  e);}
				    catch(Exception e)   {printLog("commit Exception error" +  e);}
				    if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
					if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
					if(conn != null) {
						try{
							if(!conn.isClosed()){
								conn.close();
							}
						} catch(SQLException ex){
							printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
						}finally{
							conn = null;
						}
					}
					return null;
				}else{
					pstmt.executeUpdate(  );
					if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
					try
				    {
				        if(conn != null && !conn.getAutoCommit()){ 
				        	conn.commit();
				        	conn.setAutoCommit(true);
				        }
				    }
				    catch(SQLException e){printLog("commit SQLException error " +  e);}
				    catch(Exception e)   {printLog("commit Exception error" +  e);}
				}
			}
			if(selectQuery != null && selectQuery.length()>0 && !selectQuery.trim().equals("")){
				pstmt = conn.prepareStatement(selectQuery);
				if(pstmt == null){
					return null;
				}else{
					rs = pstmt.executeQuery();
					if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
					if(rs != null){
						metaData = rs.getMetaData();
			            int numberOfColumns = metaData.getColumnCount();
						int rowCount = 0;
						
			            while (rs.next()){
			                Hashtable columns = new Hashtable();
			                for (int i = 1; i <= numberOfColumns; i++){
								int type = metaData.getColumnType(i);
								Object data = rs.getObject(i);
			                    columns.put( metaData.getColumnLabel(i).toLowerCase(), chkNull(data, type) );
			                }
			                rows.addElement(columns);
			            }
					}
				}
			}
		}
	} catch(SQLException e){
		printLog(updateQuery);
		printLog(selectQuery);
        try{
			printLog( toString() + "(VOD)" + "\n■■■▶DBPool 예외발생-executeQuery(string, string)\n" + e.getMessage() );
			if(conn != null && !conn.isClosed()){
				if(!conn.getAutoCommit()){
					conn.rollback();
					conn.setAutoCommit(true);
				}
			}
		}catch(SQLException ee){
			printLog( toString() + "(VOD)" + "\n■■■▶DBPool 예외발생(rollback failed)-executeQuery(string, string)\n" + ee.getMessage() );
		}
	} catch(Exception e) {
		printLog(updateQuery);
		printLog(selectQuery);
		printLog( toString() + "(VOD)" + "\n■■■▶DBPool 예외발생-executeQuery(string, string)\n" + e.getMessage() );
	} finally{
		if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
		if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
		if(conn != null) {
			try{
				if(!conn.isClosed()){
					conn.close();
				}
			} catch(SQLException ex){
				printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
			}finally{
				conn = null;
			}
		}
	}

	return rows;
}


public int executeQuery(String updateQuery){
	Vector rows = new Vector();
	if(updateQuery == null || updateQuery.length()<=0){
		return 0;
	}
	int iResult = 0;
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	try{
		//printLog( toString() + "(" + dbName + ")" + "\n\n\n■■■▶DBPool요청-executeQuery(string, string)" );
		conn = this.getConnection();	
		if ( isClosed(conn) ) {
			if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
			if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
			if(conn != null) {
				try{
					if(!conn.isClosed()){
						conn.close();
					}
				} catch(SQLException ex){
					printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
				}finally{
					conn = null;
				}
			}
			return -1;
		}else{

	        conn.setAutoCommit(false);
	        pstmt = conn.prepareStatement(updateQuery);
			if(pstmt == null){
				try
			    {
			        if(conn != null && !conn.getAutoCommit()){ 
			        	conn.commit();
			        	conn.setAutoCommit(true);
			        }
			    }
			    catch(SQLException e){printLog("commit SQLException error " +  e);}
			    catch(Exception e)   {printLog("commit Exception error" +  e);}
				if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
				if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
				if(conn != null) {
					try{
						if(!conn.isClosed()){
							conn.close();
						}
					} catch(SQLException ex){
						printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
					}finally{
						conn = null;
					}
				}
				return 0;
			}else{
				iResult = pstmt.executeUpdate(  );
				try
			    {
			        if(conn != null && !conn.getAutoCommit()){ 
			        	conn.commit();
			        	conn.setAutoCommit(true);
			        }
			    }
			    catch(SQLException e){printLog("commit SQLException error " +  e);}
			    catch(Exception e)   {printLog("commit Exception error" +  e);}
			}
		}
		

	} catch(SQLException e){
		printLog(updateQuery);
        try{
        	iResult = -1;
			printLog( toString() + "(VOD)" + "\n■■■▶DBPool 예외발생-executeQuery(string, string)\n" + e.getMessage() );
			if(conn != null && !conn.isClosed()){
				if(!conn.getAutoCommit()){
					conn.rollback();
					conn.setAutoCommit(true);
				}
			}
		}catch(SQLException ee){
			printLog( toString() + "(VOD)" + "\n■■■▶DBPool 예외발생(rollback failed)-executeQuery(string, string)\n" + ee.getMessage() );
		}
	} catch(Exception e) {
		iResult = -1;
		printLog( toString() + "(VOD)" + "\n■■■▶DBPool 예외발생-executeQuery(string, string)\n" + e.getMessage() );
	} finally{
		if(rs != null) try{rs.close(); rs = null;}catch(SQLException e){}
		if(pstmt != null) try{pstmt.close(); pstmt = null;}catch(SQLException e){}
		if(conn != null) {
			try{
				if(!conn.isClosed()){
					conn.close();
				}
			} catch(SQLException ex){
				printLog( toString() + "(" + "VOD" + ")" + "\n■■■▶DBPool 반환중 예외발생-releaseConnection■■■▶\n" + ex.getMessage() );				
			}finally{
				conn = null;
			}
		}
	}

	return iResult;
}

private Object chkNull(Object data, int type) {
	Object tmp = data;

	if(tmp == null) {
		switch(type) {
			case Types.BIGINT: // -5
				tmp = new Long(-1);
				break;

			case Types.BINARY:// -2
				tmp = new byte[0];
				break;

			case Types.BIT: // -7
				tmp = new Boolean(false);
				break;

			case Types.BOOLEAN: // 16
				tmp = new Boolean(false);
				break;

			case Types.BLOB: // 16
				tmp = new byte[0];
				break;

			case Types.CHAR:
				tmp = "";
				break;

			case Types.CLOB: //2005
				tmp = "";
				break;

			case Types.DATE: //91
				tmp = new java.sql.Date(0);
				break;

			case Types.DECIMAL: //3
				tmp = new java.math.BigDecimal(-1);
				break;

			case Types.DOUBLE: //8
				tmp = new Double(-1);
				break;

			case Types.FLOAT: //6
				tmp = new Double(-1);
				break;

			case Types.INTEGER: //4
				tmp = new Integer(-1);
				break;

			case Types.LONGVARBINARY: //-4
				tmp = new byte[0];
				break;

			case Types.LONGVARCHAR: //-1
				tmp = "";
				break;

			case Types.NUMERIC: //2
				tmp = new java.math.BigDecimal(-1);
				break;

			case Types.REAL: //7
				tmp = new Float(-1);
				break;

			case Types.SMALLINT: //5
				tmp = new Integer(-1);
				break;

			case Types.TIME: //92
				tmp = new java.sql.Time(0);
				break;

			case Types.TIMESTAMP: //93
				tmp = new java.sql.Timestamp(0);
				break;

			case Types.TINYINT: //-6
				tmp = new Integer(-1);
				break;

			case Types.VARBINARY: //-3
				tmp = new byte[0];
				break;

			case Types.VARCHAR: //12
				tmp = "";
				break;
		}
	
	} else {

		if(type == Types.CLOB) {
			tmp = convCLOBtoString((Clob)tmp);
		} else if(type == Types.BLOB) {
			tmp = convBLOBtoByteArray((Blob)tmp);
		}

	}

	return tmp;
}
private String convCLOBtoString(Clob clob) {
	String returnValue = "";
	StringBuffer buff = new StringBuffer();

	try{
		Reader instream = clob.getCharacterStream();
		char[] buffer = new char[10];
		int length = 0;

		while ((length = instream.read(buffer)) != -1) {
			buff.append(buffer);
			buffer = new char[10];
		}
		instream.close();
		returnValue = buff.toString().trim();
	} catch(Exception ex) {
		returnValue = "";
	}

	return returnValue;
}

private byte[] convBLOBtoByteArray(Blob blob) {
	byte[] returnValue;

	try{
		InputStream instream = blob.getBinaryStream();
		returnValue = new byte[(int)blob.length()];
		byte[] buffer = new byte[1024];
		int length = 0;
		int offset = 0;
		while((length = instream.read(buffer)) != -1) {
			System.arraycopy( buffer, 0, returnValue, offset, length );
			offset += length;
		}

		instream.close();
	} catch(Exception ex) {
		returnValue = new byte[0];
	}

	return returnValue;
}
}
