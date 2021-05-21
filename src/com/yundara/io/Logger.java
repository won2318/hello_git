/*
 * Created on 2004. 12. 16.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.yundara.io;

import java.io.*;
import java.util.*;
import java.text.*;

import com.itnc21.asynch.Active_object;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Logger extends OutputStream {
	private Active_object	dispatcher	= new Active_object();
	private Map				users		= new HashMap();
	private PrintWriter		writer		= null;
	private long			createTime	= 0;
	SimpleDateFormat dfDate = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" );

	public Logger(PrintWriter pw) {
		writer = pw;
		dispatcher.start();
		createTime = System.currentTimeMillis();
	}

	public Logger(FileWriter fw) {
		writer = new PrintWriter(fw, true);
		dispatcher.start();
		createTime = System.currentTimeMillis();
	}

	public void shut_down() {
		dispatcher.close();
		dispatcher  = null;
		writer.close();
		writer = null;
		users	    = null;
	}

    /**
     * 
     * @uml.property name="createTime"
     */
    public long getCreateTime() {
        return createTime;
    }

	public void write(int character) throws IOException	{
		if( character != 0 ) dispatcher.dispatch( new Handler(character, Thread.currentThread()) );
	}

	private final class Handler implements Runnable {
		private int 	character;
		private Object	key;

		Handler( int character, Object key ) {
			this.character = character;
			this.key	   = key;
		}

		public void run() {
			List buffer = (List)( users.get(key) );

			if( character != '\n' ) {
				if( buffer == null ) {
					buffer = new Vector();	
					users.put( key, buffer );
				}
				buffer.add( new int[]{ character } );
			} else {
				if( buffer != null ) {
					for( Iterator i= ((List)buffer).iterator();	i.hasNext(); ) {
						int c = ( (int[])( i.next() ) )[0];
						writer.print( (char)c );
					}
					users.remove( key );
				}
				writer.print( '\n' );
				writer.flush();
			}
		}
	}

    public void flush() throws IOException {
		Set	keys = users.keySet();
		for( Iterator i = keys.iterator(); i.hasNext(); )
			dispatcher.dispatch( new Handler('\n', i.next()) );
    }

    public void close() throws IOException {
		flush();
		dispatcher.close();
	}

	public void println( final String s ) {
		try{
			for( int i = 0; i < s.length(); ++i )
				write( s.charAt(i) );
			write( '\n' );
		} catch( IOException e ){}
	}

	public void printlog(String str) {
		println(dfDate.format(new java.util.Date( System.currentTimeMillis() + 2000 )) + ":" + str);
	}

    public void printlog(Throwable e) {
        e.printStackTrace(new PrintStream(this, true));
    }

    public void printlog(Throwable e, String msg) {
        printlog(msg);
        e.printStackTrace(new PrintStream(this, true));
    }
    
    protected void finalize(){
    	shut_down();
    }

static public final class Test extends Thread {
		private String message;

        /**
         * 
         * @uml.property name="log"
         * @uml.associationEnd multiplicity="(0 1)"
         */
        private Logger log = null;

		private DataOutputStream out =	null;

		public Test( Logger log, String message ) {
			this.message = message;
			this.log = log;
			this.out = new DataOutputStream(log);
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
			Logger log = new Logger(new PrintWriter(System.out, true));
		
			Thread one = new Test( log, "THIS MESSAGE IS FROM THREAD ONE" );
			Thread two = new Test( log, "하하하 message is from thread two" );

			one.start();
			two.start();

			one.join();
			two.join();

			log.close();
		}
	}
}
