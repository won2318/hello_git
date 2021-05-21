<%@ page contentType="text/html; charset=euc-kr"%><%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.yundara.util.*, java.util.Date, com.vodcaster.sqlbean.DirectoryNameManager, java.io.IOException"%><%@ page import="org.apache.poi.xssf.usermodel.*"%><%@ page import="org.apache.poi.ss.util.CellRangeAddress"%><%@ page import="org.apache.poi.ss.usermodel.*"%><%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%><%@ page import="java.util.Map"%><%@ page import="java.util.HashMap"%><%@ page import="java.io.FileOutputStream"%><%@ page import="java.io.*"%><%@ include file = "/vodman/include/auth.jsp"%><%!
/**
	     * Create a library of cell styles
	     */
	    private static Map<String, CellStyle> createStyles(Workbook wb){
	        Map<String, CellStyle> styles = new HashMap<String, CellStyle>();
	        CellStyle style;
	        Font titleFont = wb.createFont();
	        titleFont.setFontHeightInPoints((short)18);
	        titleFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
	        style = wb.createCellStyle();
	        style.setAlignment(CellStyle.ALIGN_CENTER);
	        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	        style.setFont(titleFont);
	        styles.put("title", style);

	        Font monthFont = wb.createFont();
	        monthFont.setFontHeightInPoints((short)11);
	        monthFont.setColor(IndexedColors.WHITE.getIndex());
	        style = wb.createCellStyle();
	        style.setAlignment(CellStyle.ALIGN_CENTER);
	        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	        style.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
	        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
	        style.setFont(monthFont);
	        style.setWrapText(true);
	        styles.put("header", style);

	        style = wb.createCellStyle();
	        style.setAlignment(CellStyle.ALIGN_CENTER);
	        style.setWrapText(true);
	        style.setBorderRight(CellStyle.BORDER_THIN);
	        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
	        style.setBorderLeft(CellStyle.BORDER_THIN);
	        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
	        style.setBorderTop(CellStyle.BORDER_THIN);
	        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
	        style.setBorderBottom(CellStyle.BORDER_THIN);
	        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
	        styles.put("cell", style);

	        style = wb.createCellStyle();
	        style.setAlignment(CellStyle.ALIGN_CENTER);
	        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	        style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
	        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
	        style.setDataFormat(wb.createDataFormat().getFormat("0.00"));
	        styles.put("formula", style);

	        style = wb.createCellStyle();
	        style.setAlignment(CellStyle.ALIGN_CENTER);
	        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	        style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
	        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
	        style.setDataFormat(wb.createDataFormat().getFormat("0.00"));
	        styles.put("formula", style);

	        
	        style = wb.createCellStyle();
	        style.setAlignment(CellStyle.ALIGN_CENTER);
	        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	        style.setFillForegroundColor(IndexedColors.GREY_40_PERCENT.getIndex());
	        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
	        style.setDataFormat(wb.createDataFormat().getFormat("0.00"));
	        styles.put("formula_2", style);

	        return styles;
	    }
%>
<%

	String ctype = "";
	String strTitle = "";
	int num = 1;

	if(request.getParameter("ctype") != null) {
		ctype = String.valueOf(request.getParameter("ctype").replaceAll("<","").replaceAll(">",""));
	}else
		ctype = "V";


	if(ctype.equals("V"))
		strTitle = "동영상(VOD)";
	

	String ccode = "";
	String ocode = "";
	String user_id = "";


    		
    String rstime = "";

	String retime = "";
	String dept = "";
	String grade = "";

	if(request.getParameter("rstime") !=null && request.getParameter("rstime").length()>0)
		rstime = request.getParameter("rstime").replaceAll("<","").replaceAll(">","");

	if(request.getParameter("retime") !=null && request.getParameter("retime").length()>0)
		retime = request.getParameter("retime").replaceAll("<","").replaceAll(">","");

	if(request.getParameter("ocode") !=null && request.getParameter("ocode").length()>0)
		ocode = request.getParameter("ocode");
	if(request.getParameter("user_id") !=null && request.getParameter("user_id").length()>0)
		user_id = request.getParameter("user_id").replaceAll("<","").replaceAll(">","");
    
	if(request.getParameter("dept") !=null && request.getParameter("dept").length()>0)
		dept = request.getParameter("dept").replaceAll("<","").replaceAll(">","");
	if(request.getParameter("grade") !=null && request.getParameter("grade").length()>0)
		grade = request.getParameter("grade").replaceAll("<","").replaceAll(">","");
	
	//response.setHeader("Content-Disposition", "inline; filename=view_state.xls");

    MediaManager mgr = MediaManager.getInstance();
	Vector vt =  null;
	vt = mgr.getOVODMemberList3_group( rstime, retime, ocode, user_id, ccode, ctype, dept, grade);
	if(vt == null || vt.size() <=0){
		return;
	}
%>
<%
	String[] titles = {
	            "번호",	"아이디", "영상제목", "카테고리", "시청일", "아이피"
	    };

	Object[][] sample_data = {
	            {"1", "YK11", "5.0", "8.0", "10.0"},
	            {"2", "GB22",  "5.0", "8.0", "10.0"},
	    };

	FileOutputStream fileOutputStream = null;

	Workbook wb;
	try{
//
	//    if(args.length > 0 && args[0].equals("-xls")) wb = (Workbook) new HSSFWorkbook();
	//    else wb = new XSSFWorkbook();
		wb = new XSSFWorkbook();
		Map<String, CellStyle> styles = createStyles(wb);

		Sheet sheet = wb.createSheet("동영상");
		PrintSetup printSetup = sheet.getPrintSetup();
		printSetup.setLandscape(true);
		sheet.setFitToPage(true);
		sheet.setHorizontallyCenter(true);

		//title row
		Row titleRow = sheet.createRow(0);
		titleRow.setHeightInPoints(45);
		Cell titleCell = titleRow.createCell(0);
		titleCell.setCellValue("통계");
		titleCell.setCellStyle(styles.get("title"));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$A$1:$F$1"));  // A~F 셀까지

		//header row
		Row headerRow = sheet.createRow(1);
		headerRow.setHeightInPoints(40);
		Cell headerCell;
		for (int i = 0; i < titles.length; i++) {
			headerCell = headerRow.createCell(i);
			headerCell.setCellValue(titles[i]);
			headerCell.setCellStyle(styles.get("header"));
		}

		int rownum = 2;
		for (int i = 0; i < vt.size(); i++) {
			Row row = sheet.createRow(rownum++);
			for (int j = 0; j < titles.length; j++) {
				Cell cell = row.createCell(j);
				
					cell.setCellStyle(styles.get("cell"));
			   
			}
		}
		

		try{
			if(vt != null && vt.size()>0) {
				
				for(int i=0; i<vt.size(); i++) {
					 Row row = sheet.getRow(2 + i);
					 String aaa = ""+(vt.size()-i);
					String no 		= String.valueOf(((Vector)(vt.elementAt(i))).elementAt(0));
					String ip 		= String.valueOf(((Vector)(vt.elementAt(i))).elementAt(1));
					String list_id 	= String.valueOf(((Vector)(vt.elementAt(i))).elementAt(2));
					String list_name= String.valueOf(((Vector)(vt.elementAt(i))).elementAt(3));
					String vod_code = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(4));
					String regDate 	= String.valueOf(((Vector)(vt.elementAt(i))).elementAt(5));
					String otitle 	= String.valueOf(((Vector)(vt.elementAt(i))).elementAt(6));
					String ctitle 	= String.valueOf(((Vector)(vt.elementAt(i))).elementAt(7));
					row.getCell(0).setCellValue((String)aaa);
					//row.getCell(1).setCellValue((String)list_name+"("+list_id+")");
					row.getCell(1).setCellValue((String)list_id);
					row.getCell(2).setCellValue((String)otitle);
					row.getCell(3).setCellValue((String)ctitle);
					row.getCell(4).setCellValue((String)regDate);
					row.getCell(5).setCellValue((String)ip);
				
				}
			}
		}catch(Exception e) {out.println("오류가 발생 하였습니다. 관리자에게 문의 주세요");}
							
								
		//finally set column widths, the width is measured in units of 1/256th of a character width
		sheet.setColumnWidth(0, 6*256); //30 characters wide
		for (int i = 2; i < 6; i++) {
			sheet.setColumnWidth(i, 30*256);  //6 characters wide
		}


		// Write the output to a file
		String file = DirectoryNameManager.VODROOT+"/dbtemp/vod.xls";
		String file_name = "vod.xls";
		if(wb instanceof XSSFWorkbook) file += "x";
		if(wb instanceof XSSFWorkbook) file_name += "x";
		try{
			fileOutputStream = new FileOutputStream(file);
			wb.write(fileOutputStream);
			//out.println(wb.toString());
		}catch(Exception ex){
			out.println("오류가 발생 하였습니다. 관리자에게 문의 주세요");
			
		}finally{
			try{
			   if (fileOutputStream != null){
				fileOutputStream.close();
			   }
			}catch (IOException ex){
				ex.printStackTrace();
			}

		}
			
		File file2 = new File(file ); // 절대경로입니다.

		byte b[] = new byte[(int)file2.length()];


		String strClient=request.getHeader("User-Agent");
		if(strClient.indexOf("MSIE 5.5")>-1) {
			response.setHeader("Content-Disposition", "filename=" + file_name + ";");
		} else {
			response.setHeader("Content-Disposition", "attachment;filename=" + file_name + ";");

			response.setHeader("Content-Transfer-Encoding", "binary;");
			response.setHeader("Pragma", "no-cache;");
			response.setHeader("Expires", "-1;");
			response.setContentLength((int)file2.length()); //파일크기를 브라우저에 알려준다
		}
	
		try{
			if ( file2.isFile()){
				//out.println("file.isFile() = " + file2.isFile());
				BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file2));
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

				// 화일 삭제
				String dir = DirectoryNameManager.VODROOT+"/dbtemp/";

				if(FileUtil.existsFile( dir, file_name ) ) {
					if(FileUtil.delete(dir, file_name ) ) {
						//System.out.println("화일 삭제 성공");
					} else {
						//System.out.println("화일 삭제 실패");
					}
				}

			}else{
				System.out.println("else file.isFile() = " + file2.isFile());
			}
		}catch (IOException e1) {
			System.out.println("내부 Exception e1");
		}
	
	}
	catch(Exception ex){
		System.out.println(ex);
	}%>