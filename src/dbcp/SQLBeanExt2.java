package dbcp;


public abstract class SQLBeanExt2  {
	
	//protected final DbcpMan querymanager;
	protected  DbcpMan2 querymanager;
	
	public SQLBeanExt2() {
		//querymanager = new DbcpMan();
		try{
			querymanager = DbcpMan2.getDBMan();
		}catch(Exception e){
			System.err.println(e);
		}
	}
}
