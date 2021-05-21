/*
 * Created on 2004. 12. 16.
 *
 * TODO 로거 관리를 하는 싱글톤 객체
 */

package com.yundara.io;

import java.io.*;
import java.util.*;

import com.itnc21.asynch.*;
import com.yundara.conf.*;

/**
 * @author 오영석 *  * TODO To change the template for this generated type comment go to * Window - Preferences - Java - Code Style - Code Templates
 */


public class LoggerManager {
	private	Map loggers						= new HashMap();
	private Mutex lock						= new Mutex();

    /**
     * 
     * @uml.property name="the_mgr"
     * @uml.associationEnd multiplicity="(0 1)"
     */
    private static LoggerManager the_mgr = new LoggerManager();
 
	private static long createTime			= 0;

	static {
		new JDK_11_unloading_bug_fix(LoggerManager.class);
		createTime = System.currentTimeMillis();
	}

	private LoggerManager() {
		try{
			register("STDOUT", new Logger(new PrintWriter(System.out, true)));
			register("STDERR", new Logger(new PrintWriter(System.err, true)));
			createLoggers();
		} catch(LoggerException e){
		} catch(InterruptedException e){}
	}

	private void createLoggers() throws LoggerException {
		SiteConf conf = SiteConf.getInstance();
		
		try{
			String site_log = (String)conf.getConf("site_log");
			String os = (String)conf.getConf("os");
		    register("site_log", new Logger(new FileWriter(site_log, true)));
		} catch (IOException e) {
			throw new LoggerException(e);
		} catch (InterruptedException e) {
			throw new LoggerException(e);
		}
		
		Hashtable subConf = conf.getSubConfs();
		Enumeration confKeys = subConf.keys();
		while(confKeys.hasMoreElements()) {
			String siteName = (String) confKeys.nextElement();
			Hashtable siteconf = (Hashtable)subConf.get(siteName);
			String logfile	= (String)siteconf.get("logfile");
			try{
			    if(logfile == null)  {
			        register(siteName + ".logfile",  getStdOutLogger());
			    } else {
			        register(siteName + ".logfile",  new Logger(new FileWriter(logfile, true)));
			    }
			} catch (IOException e) {
				throw new LoggerException(e);
			} catch (InterruptedException e) {
				throw new LoggerException(e);
			}
		}
	}

	public static final LoggerManager getInstance() {
		if(the_mgr == null) {
			synchronized(LoggerManager.class) {
				if(the_mgr == null) {
					the_mgr = new LoggerManager();
				}
			}
		}
		return the_mgr;
	}

    /**
     * 
     * @uml.property name="createTime"
     */
    public static long getCreateTime() {
        return createTime;
    }

	public int getLoggerCount() {
		return loggers.size();
	}

	public void register( String key, Logger logger ) throws InterruptedException {
		lock.acquire(1000);
		try{
			loggers.put( key, logger );
		} finally {
			lock.release();
		}
	}

	public Logger getLogger(String key) {
		Logger log = null;

		log = (Logger)loggers.get(key);

		return log;
	}

	public Logger getStdOutLogger() {
	    return (Logger)loggers.get("STDOUT");
	}
	
	public Logger getStdErrLogger() {
	    return (Logger)loggers.get("STDERR");
	}
	
	public Logger getSiteLogger() {
	    return (Logger)loggers.get("site_log");
	}
	
	public void removeLogger(String key) throws InterruptedException, IOException {
		lock.acquire(1000);
		try{
			Logger temp = (Logger)loggers.remove( key );
			temp.close();
		} finally {
			lock.release();
		}
	}

static public final class Test extends Thread {

        /**
         * 
         * @uml.property name="loggermgr"
         * @uml.associationEnd multiplicity="(0 1)"
         */
        private LoggerManager loggermgr = null;

        /**
         * 
         * @uml.property name="log"
         * @uml.associationEnd multiplicity="(0 1)"
         */
        private Logger log = null;

		private DataOutputStream out  = null;
		private String message = null;

		public Test(String message) {
			loggermgr = LoggerManager.getInstance();
			log = loggermgr.getLogger("LOG");
			out = new DataOutputStream(log);
			this.message = message;
			System.out.println(loggermgr.hashCode());
		}

		public void run() {
			try{
				Random indeterminate_time = new Random();
				System.out.println("현재쓰래드:" + Thread.currentThread());

				for(int count = 2; --count >= 0 ;) {
					for( int i = 0; i < message.length(); ++i ) {
						log.write( message.charAt(i) );
						sleep(Math.abs(indeterminate_time.nextInt())%20);
					}

					log.println( "(" + count + ")" );
					sleep( Math.abs(indeterminate_time.nextInt()) % 20);

					out.writeChars( "[" + count + "]" );
					sleep( Math.abs(indeterminate_time.nextInt()) % 20);

					log.write('\n');
				}
			} catch( Exception e ) {
				log.println( e.toString() );
			}
		}

		static public void main( String[] args ) throws Exception {
			LoggerManager mgr = LoggerManager.getInstance();

			mgr.register("LOG", new Logger(new PrintWriter(System.out, true)));

			Thread one = new Test("THIS MESSAGE IS FROM THREAD ONE" );
			Thread two = new Test("하하하 message is from thread two" );

			one.start();
			two.start();

			one.join();
			two.join();

			mgr.removeLogger("LOG");
		}
	}
}
