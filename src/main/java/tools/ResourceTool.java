package tools;

public class ResourceTool {
	public static String getFileType(String fileName) {
		String suffix=fileName.substring(fileName.lastIndexOf(".") + 1);
		String type;
		switch(suffix) {
		case "doc":
		case "docx":
			type="word";
			break;
		case "xls":
		case "xlsx":
			type="excel";
			break;
		case "pdf":
			type="pdf";
			break;
		case "mp4":
		case "rmvb":
			type="video";
			break;
		case "mp3":
			type="audio";
			break;
		case "png":
		case "jpg":
			type="picture";
			break;
		case "zip":
		case "rar":
			type="archive";
			break;
		default:
			type="other";
			break;
		}
		return type;
	}
	public static String transferUnit(String s) {
		int sizeInKB=Integer.parseInt(s);
		int size=0;
		if(sizeInKB>1024&&sizeInKB<1048576) {
			size=sizeInKB/1024;
			return size+"M";
		}
		else if(sizeInKB>1048576) {
			size=sizeInKB/1048576;
			return size+"G";
		}
			
		else {
			size=sizeInKB;
			return size+"K";
		}
					
	}

}
