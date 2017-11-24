package com.cglee079.portfolio.util;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;

import javax.imageio.ImageIO;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.MetadataException;
import com.drew.metadata.Tag;
import com.drew.metadata.exif.ExifIFD0Directory;

public class ImageManager {
	public synchronized static Image fileToImage(File file) throws IOException{
		Image image = ImageIO.read(file);
		return image;
	}
	
	public synchronized static BufferedImage getScaledImage(File file, int h) throws IOException {
		BufferedImage srcImg = ImageIO.read(file);
		int width = srcImg.getWidth();
		int height = srcImg.getHeight();
		double ratio = (double)h / (double)height;
		int w = (int)(width * ratio);
	    BufferedImage destImg = new BufferedImage( w, h, BufferedImage.TYPE_3BYTE_BGR);
	    Graphics2D g = destImg.createGraphics();
	    g.drawImage(srcImg, 0, 0, w, h, null);
	    return destImg;
	}    
	
	public synchronized static HashMap<String, String> getImageMetaData(File file) throws ImageProcessingException, IOException{
		final String sep1 = "\\]";
		final String sep2 = "\\-";
		HashMap<String, String> map = new HashMap<String, String>();
		String sepeartor[] = null;
		String key;
		String value;
		
		Metadata metadata = ImageMetadataReader.readMetadata(file);
		for (Directory directory : metadata.getDirectories()) {
		    for (Tag tag : directory.getTags()) {
		    	sepeartor = tag.toString().split(sep1);
		    	sepeartor = sepeartor[1].split(sep2);
		    	key = sepeartor[0].trim();
		    	value = sepeartor[1].trim();
		    	System.out.println(tag.toString());
		    	map.put(key, value);
		    }
		}
		return map;
	}
	
    public synchronized static int getOrientation(File file) throws IOException, MetadataException, ImageProcessingException {
        int orientation = 1;
	    Metadata metadata = ImageMetadataReader.readMetadata(file);
	    ExifIFD0Directory directory = metadata.getDirectory(ExifIFD0Directory.class);
	    orientation = directory.getInt(ExifIFD0Directory.TAG_ORIENTATION);
        return orientation;
    }
    
    public synchronized static BufferedImage rotateImageForMobile(BufferedImage bi, int orientation) throws IOException {
		if(orientation == 6){ //정위치
		        return rotateImage(bi, 90);
		} else if (orientation == 1){ //왼쪽으로 눞였을때
		        return bi;
		} else if (orientation == 3){//오른쪽으로 눞였을때
		        return rotateImage(bi, 180);
		} else if (orientation == 8){//180도
		        return rotateImage(bi, 270);      
		} else{
		        return bi;
		}       
    }
    
    public synchronized static BufferedImage rotateImageForMobile(File file, int orientation) throws IOException {
    	BufferedImage bi = ImageIO.read(file);
		if(orientation == 6){ //정위치
		        return rotateImage(bi, 90);
		} else if (orientation == 1){ //왼쪽으로 눞였을때
		        return bi;
		} else if (orientation == 3){//오른쪽으로 눞였을때
		        return rotateImage(bi, 180);
		} else if (orientation == 8){//180도
		        return rotateImage(bi, 270);      
		} else{
		        return bi;
		}       
    }
    
    public synchronized static BufferedImage rotateImage(BufferedImage orgImage,int radians) {
		BufferedImage newImage;
		 if(radians==90 || radians==270){
		       newImage = new BufferedImage(orgImage.getHeight(),orgImage.getWidth(),orgImage.getType());
		} else if (radians==180){
		       newImage = new BufferedImage(orgImage.getWidth(),orgImage.getHeight(),orgImage.getType());
		} else{
		        return orgImage;
		}
		Graphics2D graphics = (Graphics2D) newImage.getGraphics();
		graphics.rotate(Math. toRadians(radians), newImage.getWidth() / 2, newImage.getHeight() / 2);
		graphics.translate((newImage.getWidth() - orgImage.getWidth()) / 2, (newImage.getHeight() - orgImage.getHeight()) / 2);
		graphics.drawImage(orgImage, 0, 0, orgImage.getWidth(), orgImage.getHeight(), null );
		
		return newImage;	
    }
    
    public static String getExt(String filename){
    	int pos = filename.lastIndexOf( "." );
    	String ext = filename.substring( pos + 1 );
    	return ext;
    }
}
