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
 * �Խ����� ������ ���¸� �����ϴ� Ŭ�����Դϴ�. ���� ��� �������� ��µ� ����Ʈ����, ����Ʈ ��ȣ�� ���� �����մϴ�.
 */

public class PageBean {

private int line_per_page;					//ȭ�鿡 ��� ���							//default 2
private int page_per_block;					//ȭ�鿡 ǥ�õ� ������ �� ex) [1][2][3][4]=> 4 block �� ȭ�鿡 ������ ��ȣ �ޱ�		//default 4
private int currentPage;					//ȭ�鿡 ǥ�õ� ������						//default 1
private int currentBlock;					//ȭ�鿡 ǥ�õ� block �ѹ� ex) [1]

private int totalRecord;					//ȭ�鿡 ������ ���� ����
private int totalPage;						//�� ������ ��
private int totalBlock;						//�� block ��

private int startRecord;					//�����ϴ� ���� ��ȣ-1, 0 ���� �����Ѵ�.
private int endRecord;						//�ش� �������� ������ ���� ��ȣ 
private int startPage;						//�����ϴ� block�� �����ϴ� ������ ��ȣ ex) [5]
private int endPage;						//������ block�� ������ ������ ��ȣ ��ȣ ex) [8]


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
		//currentPage�� 4�� ����� ���

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
