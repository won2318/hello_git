/*
 * Created on 2004. 12. 14.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.yundara.util;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class PageBean {
	private int line_per_page;			//ȭ�鿡 ��� ���//default 2
	private int page_per_block;			//ȭ�鿡 ǥ�õ� ������ �� ex) [1][2][3][4]=> 4 block �� ȭ�鿡 ������ ��ȣ �ޱ�		//default 4
	private int currentPage;			//ȭ�鿡 ǥ�õ� ������ //default 1
	private int currentBlock;			//ȭ�鿡 ǥ�õ� block �ѹ� ex) [1]

	private int totalRecord;			//ȭ�鿡 ������ ���� ����
	private int totalPage;				//�� ������ ��
	private int totalBlock;				//�� block ��

	private int startRecord;			//�����ϴ� ���� ��ȣ-1, 0 ���� �����Ѵ�.
	private int endRecord;				//�ش� �������� ������ ���� ��ȣ 
	private int startPage;				//�����ϴ� block�� �����ϴ� ������ ��ȣ ex) [5]
	private int endPage;				//������ block�� ������ ������ ��ȣ ��ȣ ex) [8]

	public PageBean(){
	}

	public PageBean(int totalRecord, int linePerPage, int pagePerBlock, int page){
		this.totalRecord = totalRecord;
		this.line_per_page = linePerPage;
		this.page_per_block = pagePerBlock;
		setPage(page);	
	}

	
	public void setPage(int currentPage){
		this.currentPage=currentPage;
		if(!(totalRecord%line_per_page==0))
			this.totalPage=totalRecord/line_per_page+1;
		else
			this.totalPage=totalRecord/line_per_page;
		//////////////////////////////////////////////
		//total block
		if(!(totalPage%page_per_block==0))
			this.totalBlock=totalPage/page_per_block+1;
		else 
			this.totalBlock=totalPage/page_per_block;
		/////////////////////////////////////////////
		this.startRecord=(currentPage-1) * line_per_page+1;//ok
		////////////////////////////////////////////////////
		this.endRecord=(currentPage*line_per_page); //ok
		if(endRecord >totalRecord)			
			endRecord = totalRecord;
		//////////////////////////////////////////////////////			
				
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
//		System.out.println(line_per_page);
		
	}

	public void setPagePerBlock(int page_per_block){
		this.page_per_block=page_per_block;
	}

    /**
     * 
     * @uml.property name="currentPage"
     */
    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    /**
     * 
     * @uml.property name="currentBlock"
     */
    public void setCurrentBlock(int currentBlock) {
        this.currentBlock = currentBlock;
    }

    /**
     * 
     * @uml.property name="totalRecord"
     */
    public void setTotalRecord(int totalRecord) {
        this.totalRecord = totalRecord;
    }

    /**
     * 
     * @uml.property name="totalPage"
     */
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    /**
     * 
     * @uml.property name="totalBlock"
     */
    public void setTotalBlock(int totalBlock) {
        this.totalBlock = totalBlock;
    }

    /**
     * 
     * @uml.property name="startRecord"
     */
    public void setStartRecord(int startRecord) {
        this.startRecord = startRecord;
    }

    /**
     * 
     * @uml.property name="endRecord"
     */
    public void setEndRecord(int endRecord) {
        this.endRecord = endRecord;
    }

    /**
     * 
     * @uml.property name="startPage"
     */
    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    /**
     * 
     * @uml.property name="endPage"
     */
    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }


	public int getLinePerPage(){
		return line_per_page;
	}

	public int getPagePerBlock(){
		return page_per_block;
	}

    /**
     * 
     * @uml.property name="currentPage"
     */
    public int getCurrentPage() {
        return currentPage;
    }

    /**
     * 
     * @uml.property name="currentBlock"
     */
    public int getCurrentBlock() {
        return currentBlock;
    }

    /**
     * 
     * @uml.property name="totalRecord"
     */
    public int getTotalRecord() {
        return totalRecord;
    }

    /**
     * 
     * @uml.property name="totalPage"
     */
    public int getTotalPage() {
        return totalPage;
    }

    /**
     * 
     * @uml.property name="totalBlock"
     */
    public int getTotalBlock() {
        return totalBlock;
    }

    /**
     * 
     * @uml.property name="startRecord"
     */
    public int getStartRecord() {
        return startRecord;
    }

    /**
     * 
     * @uml.property name="endRecord"
     */
    public int getEndRecord() {
        return endRecord;
    }

    /**
     * 
     * @uml.property name="startPage"
     */
    public int getStartPage() {
        return startPage;
    }

    /**
     * 
     * @uml.property name="endPage"
     */
    public int getEndPage() {
        return endPage;
    }

}
