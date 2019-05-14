package com.fh.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.springframework.web.multipart.MultipartFile;

public class ImgUtil {
	public static int[] getImgWH(String path){
		BufferedImage bufferedImage;
		int width=0;
		int height=0;
		try {
			bufferedImage = ImageIO.read(new File(path));
			width = bufferedImage.getWidth();
			height = bufferedImage.getHeight();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new int[]{width,height};
	}
	
	public static String[] fileUpload(MultipartFile file,String imgpath,String name) {
		String ffile = DateUtil.getDays(), fileName = "";
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath() + imgpath
					+ ffile; // 文件上传路径
			fileName = FileUpload.fileUp(file, filePath, name); // 执行上传
			String path=imgpath+ ffile+"/"+fileName;
			return new String[]{path,filePath+"/"+fileName};//url ,本地路径
		} else {
			System.out.println("上传失败");
			return null;
		}
	}

}
