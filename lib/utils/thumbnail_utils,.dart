import 'package:thumbnails/thumbnails.dart';

getImage(videoPathUrl) async {
    //await Future.delayed(Duration(milliseconds: 500));
    String thumb = await Thumbnails.getThumbnail(
        videoFile: videoPathUrl,
        imageType:
            ThumbFormat.PNG, 
            //this image will store in created folderpath
        quality: 10);
    return thumb;
  }