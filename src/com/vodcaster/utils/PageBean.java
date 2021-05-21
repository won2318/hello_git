/*
 * Created on 2005. 1. 3
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.utils;

/**
 * @author Jong-Hyun Ho
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 * 
 */

/**
 * 게시판의 페이지 형태를 관리하는 클래스입니다. 예를 들어 페이지당 출력될 리스트개수, 리스트 번호수 등을 설정합니다.
 */

public class PageBean {

private int line_per_page;					//화면에 몇개씩 출력							//default 2
private int page_per_block;					//화면에 표시될 페이지 수 ex) [1][2][3][4]=> 4 block 씩 화면에 페이지 번호 메김		//default 4
private int currentPage;					//화면에 표시될 페이지						//default 1
private int currentBlock;					//화면에 표시될 block 넘버 ex) [1]

private int totalRecord;					//화면에 보여줄 열의 개수
private int totalPage;						//총 페이지 수
private int totalBlock;						//총 block 수

private int startRecord;					//시작하는 열의 번호-1, 0 부터 시작한다.
private int endRecord;						//해당 페이지의 끝나는 열의 번호 
private int startPage;						//시작하는 block에 시작하는 페이지 번호 ex) [5]
private int endPage;						//끝나는 block에 끝나는 페이지 번호 번호 ex) [8]


public PageBean()
{}

public void setPage(int currentPage){
	this.currentPage=currentPage;
	if(!(totalRecord%line_per_page==0))
		this.totalPage=totalRecord/line_per_page+1;
	else
		this.totalPage=totalRecord/line_per_page;

	if(!(totalPage%page_per_block==0))
		this.totalBlock=totalPage/page_per_block+1;
	else 
		this.totalBlock=totalPage/page_per_block;

	this.startRecord=(currentPage-1) * line_per_page+1;//ok

	this.endRecord=(currentPage*line_per_page); //ok
	if(endRecord >totalRecord)			
		endRecord = totalRecord;
	
	if(!(currentPage%page_per_block==0))
		this.currentBlock=(int)currentPage/page_per_block+1;
	else
		this.currentBlock=(int)currentPage/page_per_block; 
		//currentPage이 4의 배수인 경우

	this.startPage=(currentBlock-1)*page_per_block + 1; //startPage
	this.endPage=currentBlock*page_per_block;//endPage
	if( endPage>totalPage)
		endPage=totalPage;
	}


public void setLinePerPage(int line_per_page){
	this.line_per_page=line_per_page;
//	System.out.println(line_per_page);
	
}

public void setPagePerBlock(int page_per_block){
	this.page_per_block=page_per_block;
}

public void setCurrentPage(int currentPage){
	this.currentPage=currentPage;
}

public void setCurrentBlock(int currentBlock){
	this.currentBlock=currentBlock;
}

public void setTotalRecord(int totalRecord){
	this.totalRecord=totalRecord;
}

public void setTotalPage(int totalPage){
	this.totalPage=totalPage;
}

public void setTotalBlock(int totalBlock){
	this.totalBlock=totalBlock;
}

public void setStartRecord(int startRecord){
	this.startRecord=startRecord;
}

public void setEndRecord(int endRecord){
	this.endRecord=endRecord;
}

public void setStartPage(int startPage){
	this.startPage=startPage;
}

public void setEndPage(int endPage){
	this.endPage=endPage;
}

public int getLinePerPage(){
	return line_per_page;
}

public int getPagePerBlock(){
	return page_per_block;
}

public int getCurrentPage(){
	return currentPage;
}

public int getCurrentBlock(){
	return currentBlock;
}

public int getTotalRecord(){
	return totalRecord;
}

public int getTotalPage(){
	return totalPage;
}

public int getTotalBlock(){
	return totalBlock;
}

public int getStartRecord(){
	return startRecord;
}

public int getEndRecord(){
	return endRecord;
}

public int getStartPage(){
	return startPage;
}

public int getEndPage(){
	return endPage;
}


}
