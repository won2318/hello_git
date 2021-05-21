package com.vodcaster.utils;

import javax.imageio.*;
import java.io.*;
import java.awt.image.*;
import java.awt.*;
import com.vodcaster.sqlbean.DirectoryNameManager;
import com.nowonplay.hover.image.*;

/*
 * 파일이름과 width, height를 받아서 썸네일을 생성한다.
 */
public class ImageUtil {
	public static void createThumbnail(String oldName, String newName, int targetW, int targetH) throws Exception {
		if ((oldName == null || oldName.equals(""))
			|| (newName == null || newName.equals(""))) throw new Exception("File name is null or empty");
		if (!(targetW > 0 && targetH > 0)) throw new Exception("target width and height is not approval");
		
		int sIdx = oldName.lastIndexOf(".") + 1;
		int eIdx = oldName.length();
		
		String extension = oldName.substring(sIdx, eIdx).toLowerCase();
		
		if (extension.equals("gif")) extension = "png";

		ImageConverter ic = 
			new ImageConverter(
					oldName, newName,
					targetW, targetH, extension);

		ic.setConstraintPreservation(true);

		ic.create();
	}

	public static void createThumbnail2(String fileName) throws Exception {
		if (fileName == null || fileName.equals("")) throw new Exception("File name is null or empty");
		
		int sIdx = fileName.lastIndexOf(".") + 1;
		int eIdx = fileName.length();
		
		String extension = fileName.substring(sIdx, eIdx).toLowerCase();
		
		if (extension.equals("gif")) extension = "png";

		FileInputStream srcIs = null;

		srcIs = new FileInputStream(DirectoryNameManager.UPLOAD_BORADLIST + "/" + fileName);

		BufferedImage srcImg = ImageIO.read(srcIs);

		BufferedImage destImg = new BufferedImage(150, 150, BufferedImage.TYPE_3BYTE_BGR);

		Graphics2D g = destImg.createGraphics();
		g.drawImage(srcImg, 0, 0, 150, 150, null);

		File dest = new File(DirectoryNameManager.UPLOAD_BORADLIST_IMG + "/" + fileName);
		ImageIO.write(destImg, extension, dest);
	}
}
