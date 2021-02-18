import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'dart:io';
// import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wa_status_saver/ui/flush_bar_widget.dart';
import 'package:wa_status_saver/utils/video_controller.dart';

class PlayStatus extends StatefulWidget {
  final String videoFile;
  PlayStatus(this.videoFile);
  @override
  _PlayStatusState createState() => new _PlayStatusState();
}

class _PlayStatusState extends State<PlayStatus> {
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: StatusVideo(
          videoPlayerController:
              VideoPlayerController.file(File(widget.videoFile)),
          looping: true,
          videoSrc: widget.videoFile,
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.teal,
          child: Icon(Icons.save),
          onPressed: () async {
            // _onLoading(true, "");

            // File originalVideoFile = File(widget.videoFile);
            // Directory directory =
            //     Directory('/storage/emulated/0/wa_status_saver');

            // if (!directory.existsSync()) {
            //   directory.createSync(recursive: true);
            // }
            // print(directory.path);
            // String path = directory.path;
            // String curDate = DateTime.now().toString();
            // String newFileName = "$path/VIDEO-$curDate.mp4";

            bool result = // await originalVideoFile.copy(newFileName);
                await GallerySaver.saveVideo(widget.videoFile);
            if (result) {
              showSnack(context, "Video saved to gallery");
            }
          }),
    );
  }
}
