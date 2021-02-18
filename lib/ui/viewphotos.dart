import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';
import 'package:share/share.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wa_status_saver/ui/flush_bar_widget.dart';
import 'package:wa_status_saver/utils/save_image.dart';
// import 'package:wallpaper/wallpaper.dart';
// import 'package:wallpaper/wallpaper.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class ViewPhotos extends StatefulWidget {
  final String imgPath;
  final bool fromSave;
  ViewPhotos(this.imgPath, {this.fromSave = false});

  @override
  _ViewPhotosState createState() => _ViewPhotosState();
}

class _ViewPhotosState extends State<ViewPhotos> {
  var filePath;
  // final String imgShare = "Image.file(File(widget.imgPath),)";

  final LinearGradient backgroundGradient = new LinearGradient(
    colors: [
      Color(0x00000000),
      Color(0x00333333),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  void _onLoading(bool t, String str) {
    if (t) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: <Widget>[
                Center(
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: CircularProgressIndicator()),
                ),
              ],
            );
          });
    } else {
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SimpleDialog(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Great, Saved in Gallary",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          Text(str,
                              style: TextStyle(
                                fontSize: 16.0,
                              )),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          Text("FileManager > wa_status_saver",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.teal)),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          MaterialButton(
                            child: Text("Close"),
                            color: Colors.teal,
                            textColor: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    }
  }

  Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    //The list of FabMiniMenuItems that we are going to use
    var _fabMiniMenuItemList = [
      new FabMiniMenuItem.withText(
          new Icon(Icons.sd_storage), Colors.teal, 4.0, "Button menu", () {
        saveImage(
          context: context,
          imgPath: widget.imgPath,
        );
      }, "Save", Colors.black, Colors.white, true),
      new FabMiniMenuItem.withText(
          new Icon(Icons.share), Colors.teal, 4.0, "Button menu", () {
        Share.shareFiles(['${widget.imgPath}'], text: 'Great picture');
        //  Share.shareFiles(['${directory.path}/image.jpg'], text: 'Great picture');
      }, "Share", Colors.black, Colors.white, true),
      new FabMiniMenuItem.withText(
          new Icon(Icons.wallpaper), Colors.teal, 4.0, "Button menu", () async {
        int location = WallpaperManager
            .HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
        final String result = await WallpaperManager.setWallpaperFromFile(
            widget.imgPath, location);
        if (result == "Wallpaper set") {
          showSnack(
            context,
            "Image set as Wallpaper",
          );
        }
      }, "Make Wallpaper", Colors.black, Colors.white, true),
      // new FabMiniMenuItem.withText(
      //     new Icon(Icons.delete_outline), Colors.teal, 4.0, "Button menu", () {
      //   deleteFile(File(widget.imgPath));
      //   showBottomFlash(
      //     context: context,
      //     subTitle: "Image has been deleted",
      //     title: "Delete",
      //   );
      //   Navigator.pop(context);
      // }, "Delete", Colors.black, Colors.white, true),
    ];

    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.indigo,
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Hero(
                  tag: widget.imgPath,
                  child: Container(
                      child: PhotoView(
                    imageProvider: FileImage(File(widget.imgPath)),
                  ))
                  //               Container(
                  //   child: PhotoView(
                  //     imageProvider: AssetImage("assets/large-image.jpg"),
                  //   )
                  // )
                  ),
            ),
            widget.fromSave
                ? Offstage()
                : new FabDialer(
                    _fabMiniMenuItemList, Colors.teal, new Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
