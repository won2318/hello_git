package dbcp;


public abstract class SQLBeanExt  {
	
	//protected final DbcpMan querymanager;
	protected  DbcpMan querymanager;
	
	public SQLBeanExt() {
		//querymanager = new DbcpMan();
		try{
			querymanager = DbcpMan.getDBMan();
		}catch(Exception e){
			System.err.println(e);
		}
	}
}
