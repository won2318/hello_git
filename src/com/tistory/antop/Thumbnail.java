package com.tistory.antop;

import java.io.IOException;

import net.coobird.thumbnailator.Thumbnails;

public class Thumbnail {
	/**
	 * 썸네일 생성
	 * @param orgName 원본 파일
	 * @param destName 썸네일 이미지 파일
	 * @param width 썸네일 이미지 크기
	 * @param height 썸네일 이미지 크기
	 * @return 파일명
	 * @throws IOException
	 */
	public static String createThumb(String orgName, String destName, int width, int height) throws IOException {

		Thumbnails.of(orgName).size(width,height).toFile(destName);
	 
		return "";
	}
 

}
