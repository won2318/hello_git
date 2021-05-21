<%@ page contentType="application/octet-stream; charset=euc-kr" import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*,java.text.SimpleDateFormat,java.io.*,java.net.SocketException"%><%!
    public static String read(String f) throws Exception{//���Ϸε� ��Ʈ������ ��ȯ

        String filename=f;
        StringBuffer outStr=new StringBuffer();
        String c;
        String back_str ="";

        try{
            File tt=new File(filename);
            FileReader FR=new FileReader(tt);
            BufferedReader in=new BufferedReader(FR);//new FileReader(filename)

            while((c=in.readLine()) !=null){
                outStr.append(c);
                outStr.append("\r\n");
            }

            back_str=outStr.toString();
        }catch(Exception e){
            System.out.println("Exception �߻�");
        }
        return back_str;
    }
%><%
try{

	String dbname= DirectoryNameManager.DB_NAME;
	String user= DirectoryNameManager.DB_USER;
	String passwd= DirectoryNameManager.DB_PASS;

    SimpleDateFormat fommatter = new SimpleDateFormat("yyyyMMddHHmmss");
    Calendar cal = Calendar.getInstance();
    String today = null;
    today = fommatter.format(cal.getTime());
    String file_name = "vodcaster_DB-" +today + ".sql";
    
  
	String mysqlCmd = "mysqldump --extended-insert=FALSE --skip-comments -u"+user+ " -p"+passwd+ " "+dbname;
 
    BufferedReader bufferedReader = null;
 
   OutputStreamWriter fileWriter = null;
    try {
        Process process = Runtime.getRuntime().exec(mysqlCmd);
        
        String line;        
        bufferedReader = new BufferedReader(new InputStreamReader(process.getInputStream(),"UTF-8"));
	 		 fileWriter = new OutputStreamWriter(new FileOutputStream(DirectoryNameManager.VODROOT+"/dbtemp/"+file_name),"UTF-8");
		
         while ((line = bufferedReader.readLine()) != null) {
            fileWriter.write(line + "\n");
        }
        bufferedReader.close();
        fileWriter.close();

        process.waitFor();
    } catch (Exception e) {
        System.out.println(e.toString());
    } finally {
        if (bufferedReader != null) try { bufferedReader.close(); } catch (Exception _ignored){}
        if (fileWriter != null) try { fileWriter.close(); } catch (Exception _ignored){}
    }

String UPLOADFILE = DirectoryNameManager.VODROOT+"/dbtemp/" +file_name;

    File file = new File(CharacterSet.toKorean( UPLOADFILE ) ); // �������Դϴ�.

    byte b[] = new byte[(int)file.length()];


    String strClient=request.getHeader("User-Agent");
    if(strClient.indexOf("MSIE 5.5")>-1) {
        response.setHeader("Content-Disposition", "filename=" + file_name + ";");
    } else {
        response.setHeader("Content-Disposition", "attachment;filename=" + file_name + ";");

        response.setHeader("Content-Transfer-Encoding", "binary;");
        response.setHeader("Pragma", "no-cache;");
        response.setHeader("Expires", "-1;");
        response.setContentLength((int)file.length()); //����ũ�⸦ �������� �˷��ش�
    }
	
	try{
		if ( file.isFile()){
	        //out.println("file.isFile() = " + file.isFile());
			BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
			BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
			int read = 0;
			try {
				while ((read = fin.read(b)) != -1){
					outs.write(b,0,read);
				}
				outs.close();
				fin.close();
			} catch (IOException e) {
				//out.println("IOException.toString() == "+e.toString());
				if ( e.toString().indexOf("reset") != -1 ){
				  // ee.printStackTrace();
			   }
			} finally {
				if(outs!=null) outs.close();
				if(fin!=null) fin.close();
			}

			// ȭ�� ����
			String dir = DirectoryNameManager.VODROOT+"/dbtemp/";

			if(FileUtil.existsFile( dir, file_name ) ) {
			 
				if(FileUtil.delete(dir, file_name ) ) {
					//System.out.println("ȭ�� ���� ����");
				} else {
					//System.out.println("ȭ�� ���� ����");
				}
		 
			}

		}else{
			System.out.println("else file.isFile() = " + file.isFile());
		}
	}catch (IOException e1) {
		System.out.println("���� Exception e1");
	}
}  catch (Exception e1) {
	System.out.println("�ܺ� Exception e1");
}
 
%>
