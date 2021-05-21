package com.vodcaster.utils;


import java.text.*;
import java.io.*;
import java.util.*;

public class LogfileCheck {

	
	
	public LogfileCheck() {
		
	}
	public void check(){
		if(CheckLength()){
			MakeLogfile();
		}
	}
	private boolean CheckLength(){
		File file = new File("/vodtemp/vod.log");
		File to_file = null;
		try {
			boolean bOk = false;
			if(file.exists()) {
				long lSize = file.length();
				if(lSize > 10000000){
					Date date = new Date();
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
					String strDate = df.format(date);
	
					String newFileName = "/vodtemp/vod_"+strDate+".log";
					to_file = new File(newFileName);
					file.renameTo(to_file);
					bOk = true;
					if(to_file != null){
						to_file = null;
					}
					if(file != null){
						file = null;
					}
				}
				else{
					bOk = false;
				}
			}
			else{
				bOk = false;
			}
			return bOk;
		}
		catch(Exception e){
			return true;
		}
		finally{
			if(file != null){
				file = null;
			}
			if(to_file != null){
				to_file = null;
			}
		}
	}
	
	private void MakeLogfile(){
		PrintWriter out = null;
		try{
			out = new PrintWriter(new FileWriter("/vodtemp/vod.log", false));
			out.println("VOD LOG NEW FILE "+"\n");
			out.close();
			
		}
		catch(Exception e){
			System.out.println(e);
		}
		finally{
			
			if (out != null) {
                out.flush();
                out.close();
            }

		}
	}
}
