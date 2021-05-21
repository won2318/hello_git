package com.tistory.antop;

import java.io.IOException;

import net.coobird.thumbnailator.Thumbnails;

public class Thumbnail {
	/**
	 * ����� ����
	 * @param orgName ���� ����
	 * @param destName ����� �̹��� ����
	 * @param width ����� �̹��� ũ��
	 * @param height ����� �̹��� ũ��
	 * @return ���ϸ�
	 * @throws IOException
	 */
	public static String createThumb(String orgName, String destName, int width, int height) throws IOException {

		Thumbnails.of(orgName).size(width,height).toFile(destName);
	 
		return "";
	}
 

}
