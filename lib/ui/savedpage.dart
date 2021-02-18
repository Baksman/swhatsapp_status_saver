import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wa_status_saver/ui/viewphotos.dart';
import 'package:wa_status_saver/utils/delete_file.dart';
import 'package:wa_status_saver/ui/flush_bar_widget.dart';

final Directory _savedStatusDir = new Directory('/storage/emulated/0/Pictures');

class SavedStatusPage extends StatefulWidget {
  @override
  _SavedStatusPageState createState() => _SavedStatusPageState();
}

class _SavedStatusPageState extends State<SavedStatusPage> {
  var savedImage = _savedStatusDir
      .listSync()
      .map((item) => item.path)
      .where((item) =>
          item.endsWith(".jpg") ||
          item.endsWith(".png") ||
          item.endsWith(".gif"))
      .toList()
      .reversed
      .toList();
  @override
  Widget build(BuildContext context) {
    if (!Directory("${_savedStatusDir.path}").existsSync()) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Empty\n",
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      );
    }

    if (savedImage.length > 0) {
      return Container(
        margin: EdgeInsets.all(8.0),
        child: StaggeredGridView.countBuilder(
          itemCount: savedImage.length,
          crossAxisCount: 4,
          itemBuilder: (context, index) {
            String imgPath = savedImage[index];
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
                            builder: (context) =>
                                new ViewPhotos(imgPath, fromSave: true)));
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
                                    savedImage.removeAt(index);
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
                        ],
                      )),
                ),
              ),
            );
          },
          staggeredTileBuilder: (i) => StaggeredTile.count(2, i.isEven ? 2 : 3),
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
                'No Image Found!',
                style: TextStyle(fontSize: 18.0),
              )),
        ),
      );
    }
  }
}
