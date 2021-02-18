import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wa_status_saver/ui/flush_bar_widget.dart';
import 'package:wa_status_saver/ui/not_intsalled_screen.dart';
import 'package:wa_status_saver/ui/viewphotos.dart';
import 'package:wa_status_saver/utils/save_image.dart';
import 'package:wa_status_saver/utils/delete_file.dart';
final Directory _photoDir =
    new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class ImageScreen extends StatefulWidget {
  @override
  ImageScreenState createState() => new ImageScreenState();
}

class ImageScreenState extends State<ImageScreen> {
  @override
  void initState() {
    super.initState();
  }

  var imageList = _photoDir
      .listSync()
      .map((item) => item.path)
      .where((item) =>
          item.endsWith(".jpg") ||
          item.endsWith(".png") ||
          item.endsWith(".gif"))
      // .toList()
      // .reversed
      .toList();

  @override
  Widget build(BuildContext context) {
    if (!Directory("${_photoDir.path}").existsSync()) {
      return WhatsappNotInstalled();
      // return Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Text(
      //       "Install WhatsApp\n",
      //       style: TextStyle(fontSize: 18.0),
      //     ),
      //     Text(
      //       "Your Friend's Status Will Be Available Here",
      //       style: TextStyle(fontSize: 18.0),
      //     ),
      //   ],
      // );
    } else {
      // ..sort((a, b) => File(a)
      //     .lastModifiedSync()
      //     .compareTo(File(a).lastModifiedSync()));
      if (imageList.length > 0) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: StaggeredGridView.countBuilder(
            itemCount: imageList.length,
            crossAxisCount: 4,
            itemBuilder: (context, index) {
              String imgPath = imageList[index];
              return ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ViewPhotos(imgPath)));
                    },
                    child: Hero(
                        tag: imgPath,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(
                              File(imgPath),
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      imageList.removeAt(index);
                                      deleteFile(File(imgPath));
                                      erroSnackBar(
                                          context, "Image has been deleted");
                                    });
                                  },
                                  child: Container(
                                      height: 20,
                                      width: 50,
                                      // width: double.infinity,
                                      color: Colors.red,
                                      child: Icon(Icons.delete,
                                          color: Colors.white, size: 12)),
                                )),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    saveImage(
                                      context: context,
                                      imgPath: imgPath,
                                    );
                                  },
                                  child: Container(
                                      height: 20,
                                      width: 50,
                                      // width: double.infinity,
                                      color: Colors.teal,
                                      child: Icon(Icons.file_download,
                                          color: Colors.white, size: 12)),
                                ))
                          ],
                        )),
                  ),
                ),
              );
            },
            staggeredTileBuilder: (i) =>
                StaggeredTile.count(2, i.isEven ? 2 : 3),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
        );
      } else {
        return Scaffold(
          body: Center(
            child: new Container(
                padding: EdgeInsets.only(bottom: 60.0),
                child: Text(
                  'Sorry, No Image Found!',
                  style: TextStyle(fontSize: 18.0),
                )),
          ),
        );
      }
    }
  }

 
}
