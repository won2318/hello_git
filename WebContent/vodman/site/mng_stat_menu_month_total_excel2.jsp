<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.yundara.util.*, java.util.Date, com.vodcaster.sqlbean.DirectoryNameManager, java.io.IOException"%>

<%@ page import="org.apache.poi.xssf.usermodel.*"%>
<%@ page import="org.apache.poi.ss.util.CellRangeAddress"%>
<%@ page import="org.apache.poi.ss.usermodel.*"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>

<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.*"%>
<%@page import="com.yundara.util.TextUtil"%>
<%!
		
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
		ctype = String.valueOf(request.getParameter("ctype"));
	}else
		ctype = "V";

	//response.setHeader("Content-Disposition", "inline; filename=view_state.xls");

	String today = "";
	String chk_gb = "";
	String ydate = request.getParameter("ydate");
	String mdate = request.getParameter("mdate");
	today = ydate+mdate;
	
	
	MenuManager mgr = MenuManager.getInstance();
	Vector vt =  (Vector)mgr.getMenuListALL3(today, "W");
	Vector vt1 = (Vector)mgr.getMenuListALL3_1(today, "W");
	
	Vector Mvt =  (Vector)mgr.getMenuListALL3(today, "M");
	Vector Mvt1 = (Vector)mgr.getMenuListALL3_1(today, "M");
	
	if(vt == null || vt.size() <=0){
		return;
	}
%>

<%	
	int y = Integer.parseInt(request.getParameter("ydate"));
	int m = Integer.parseInt(request.getParameter("mdate"));
	
	int d=0;
	switch(m){
	case 1:
	case 3:
	case 5:
	case 7:
	case 8:
	case 10:
	case 12:
	d = 31;
	break;
	case 4:
	case 6:
	case 9:
	case 11:
	d=30;
	break;
	case 2:
		if(((y%4==0)&&!(y%100==0))||(y%400==0))
			d=29;		
		else
			d = 28;
		
	break;
	}
	
// 	Calendar now = Calendar.getInstance();
// 	int d = now.getActualMaximum(Calendar.DAY_OF_MONTH);
	
// 	String[] titles = { "1","2","3","" };

	FileOutputStream fileOutputStream = null;
	Workbook wb;
	try{
	//
	//    if(args.length > 0 && args[0].equals("-xls")) wb = (Workbook) new HSSFWorkbook();
	//    else wb = new XSSFWorkbook();
		
		wb = new XSSFWorkbook();
		Map<String, CellStyle> styles = createStyles(wb);
		Sheet sheet = wb.createSheet("1");
		PrintSetup printSetup = sheet.getPrintSetup();
		printSetup.setLandscape(true);
		sheet.setFitToPage(true);
		sheet.setHorizontallyCenter(true);
		
		
		//title row
		Row titleRow = sheet.createRow(0);
		titleRow.setHeightInPoints(45);
		Cell titleCell = titleRow.createCell(0);
		titleCell.setCellValue("메뉴 클릭"+m+"월 통계");
		titleCell.setCellStyle(styles.get("title"));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$A$1:$D$1"));

		//header row
		Row headerRow = sheet.createRow(1);
		headerRow.setHeightInPoints(40);
		Cell headerCell;
		
			headerCell = headerRow.createCell(0);
			headerCell.setCellValue("웹 통계");
			headerCell.setCellStyle(styles.get("header"));
				
		for (int i = 1; i < d+1; i++) {
			headerCell = headerRow.createCell(i);
			headerCell.setCellValue(i);
			headerCell.setCellStyle(styles.get("header"));
		}
			headerCell = headerRow.createCell(d+1);
			headerCell.setCellValue("합계");
			headerCell.setCellStyle(styles.get("header"));
		
		
		
		
		
		
		
		int rownum = 2;
		for (int i = 0; i < vt.size()+Mvt.size()+3; i++) {
			Row row = sheet.createRow(rownum++);
			for (int j = 0; j < d+2; j++) {
				Cell cell = row.createCell(j);
				
					cell.setCellStyle(styles.get("cell"));
			   
			}
		}
		
		int[] Websum = new int [d];
		int[] Mosum = new int [d];
		int Totalsum = 0;
		int MTotalsum = 0;
		
		try{
			if(vt != null && vt.size()>0) {
				for(int i=0; i<vt.size(); i++) {
						
						Row row = sheet.getRow(2 + i);
					
						Hashtable ht_list = (Hashtable)vt.get(i);
						String list_name= TextUtil.nvl(String.valueOf(ht_list.get("mtitle")));
						
							row.getCell(0).setCellValue((String)list_name);
						
						int csumM = 0;						
						int gubun1 = 0;
						gubun1 = String.valueOf(ht_list.get("muid")) != null && String.valueOf(ht_list.get("muid")).length()>0 && com.yundara.util.TextUtil.isNumeric(String.valueOf(ht_list.get("muid")))? Integer.parseInt( TextUtil.nvl(String.valueOf(ht_list.get("muid")))):0; 
						
						for(int g=0; g<d; g++){
							
							
							row.getCell(g+1).setCellValue("0");
							
							for(int v=0; v<vt1.size(); v++) {
								
							Hashtable ht_list1 = (Hashtable)vt1.get(v);
							
							int gubun2 = 0;
							int gubun3 = 0;
							
							gubun2 = String.valueOf(ht_list1.get("muid")) != null && String.valueOf(ht_list1.get("muid")).length()>0 && com.yundara.util.TextUtil.isNumeric(String.valueOf(ht_list1.get("muid")))? Integer.parseInt( TextUtil.nvl(String.valueOf(ht_list1.get("muid")))):0;
							gubun3 = String.valueOf(ht_list1.get("day")) != null && String.valueOf(ht_list1.get("day")).length()>0 && com.yundara.util.TextUtil.isNumeric(String.valueOf(ht_list1.get("day")))? Integer.parseInt( TextUtil.nvl(String.valueOf(ht_list1.get("day")))):0;
								if(gubun1==gubun2 && gubun3==g+1){
									row.getCell(g+1).setCellValue(TextUtil.nvl(String.valueOf(ht_list1.get("cnt"))));
									csumM += String.valueOf(ht_list1.get("cnt")) != null && String.valueOf(ht_list1.get("cnt")).length()>0 && com.yundara.util.TextUtil.isNumeric(String.valueOf(ht_list1.get("cnt")))? Integer.parseInt( TextUtil.nvl(String.valueOf(ht_list1.get("cnt")))):0;
									Websum[g] += String.valueOf(ht_list1.get("cnt")) != null && String.valueOf(ht_list1.get("cnt")).length()>0 && com.yundara.util.TextUtil.isNumeric(String.valueOf(ht_list1.get("cnt")))? Integer.parseInt( TextUtil.nvl(String.valueOf(ht_list1.get("cnt")))):0;
									Totalsum += String.valueOf(ht_list1.get("cnt")) != null && String.valueOf(ht_list1.get("cnt")).length()>0 && com.yundara.util.TextUtil.isNumeric(String.valueOf(ht_list1.get("cnt")))? Integer.parseInt( TextUtil.nvl(String.valueOf(ht_list1.get("cnt")))):0;
								}
							}
							row.getCell(d+1).setCellValue(csumM);
						}
						
				}
				
				
				
				for(int i=0; i<Mvt.size(); i++) {
					
					Row row = sheet.getRow(vt.size()+4 + i);
				
					Hashtable Mht_list = (Hashtable)Mvt.get(i);
					String Mlist_name= TextUtil.nvl(String.valueOf(Mht_list.get("mtitle")));
					
						row.getCell(0).setCellValue((String)Mlist_name);
					
					int McsumM = 0;						
					int Mgubun1 = 0;
					Mgubun1 = String.valueOf(Mht_list.get("muid")) != null && String.valueOf(Mht_list.get("muid")).length()>0 && com.yundara.util.TextUtil.isNumeric(String.valueOf(Mht_list.get("muid")))? Integer.parseInt( TextUtil.nvl(String.valueOf(Mht_list.get("muid")))):0; 
					
					for(int g=0; g<d; g++){
						
						
						row.getCell(g+1).setCellValue("0");
						
						for(int v=0; v<Mvt1.size(); v++) {
							
						Hashtable Mht_list1 = (Hashtable)Mvt1.get(v);
						
						int Mgubun2 = 0;
						int Mgubun3 = 0;
						
						Mgubun2 = String.valueOf(Mht_list1.get("muid")) != null && String.valueOf(Mht_list1.get("muid")).length()>0 && com.yundara.util.TextUtil.isNumeric(String.valueOf(Mht_list1.get("muid")))? Integer.parseInt( TextUtil.nvl(String.valueOf(Mht_list1.get("muid")))):0;
						Mgubun3 = String.valueOf(Mht_list1.get("day")) != null && String.valueOf(Mht_list1.get("day")).length()>0 && com.yundara.util.TextUtil.isNumeric(String.valueOf(Mht_list1.get("day")))? Integer.parseInt( TextUtil.nvl(String.valueOf(Mht_list1.get("day")))):0;
							if(Mgubun1==Mgubun2 && Mgubun3==g+1){
								row.getCell(g+1).setCellValue(TextUtil.nvl(String.valueOf(Mht_list1.get("cnt"))));
								McsumM += String.valueOf(Mht_list1.get("cnt")) != null && String.valueOf(Mht_list1.get("cnt")).length()>0 && com.yundara.util.TextUtil.isNumeric(String.valueOf(Mht_list1.get("cnt")))? Integer.parseInt( TextUtil.nvl(String.valueOf(Mht_list1.get("cnt")))):0;
								Mosum[g] += String.valueOf(Mht_list1.get("cnt")) != null && String.valueOf(Mht_list1.get("cnt")).length()>0 && com.yundara.util.TextUtil.isNumeric(String.valueOf(Mht_list1.get("cnt")))? Integer.parseInt( TextUtil.nvl(String.valueOf(Mht_list1.get("cnt")))):0;
								MTotalsum += String.valueOf(Mht_list1.get("cnt")) != null && String.valueOf(Mht_list1.get("cnt")).length()>0 && com.yundara.util.TextUtil.isNumeric(String.valueOf(Mht_list1.get("cnt")))? Integer.parseInt( TextUtil.nvl(String.valueOf(Mht_list1.get("cnt")))):0;
							}
						}
						row.getCell(d+1).setCellValue(McsumM);
					}
					
			}
				Row row = sheet.getRow(2 + vt.size());
				row.getCell(0).setCellValue("웹 합계");
				for(int w=0; w<d; w++){
					row.getCell(w+1).setCellValue(Websum[w]);	
				}
				row.getCell(d+1).setCellValue(Totalsum);
				
				
				Row row1 = sheet.getRow(2 + vt.size()+ Mvt.size()+2);
				row1.getCell(0).setCellValue("모바일 합계");
				
				for(int w=0; w<d; w++){
					row1.getCell(w+1).setCellValue(Mosum[w]);	
				}
				row1.getCell(d+1).setCellValue(MTotalsum);
				
				
				
				
				
				
			}
		}catch(Exception e) { out.println("오류가 발생 하였습니다. 관리자에게 문의 주세요");}
							
								
		//finally set column widths, the width is measured in units of 1/256th of a character width
		sheet.setColumnWidth(0, 30*256); //30 characters wide
		for (int i = 1; i < d+2; i++) {
			sheet.setColumnWidth(i, 8*256);  //6 characters wide
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