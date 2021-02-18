import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wa_status_saver/ui/flush_bar_widget.dart';
import 'dart:io';
//import 'package:thumbnails/thumbnails.dart';
import 'package:wa_status_saver/ui/not_intsalled_screen.dart';
import 'package:wa_status_saver/utils/thumbnail_utils,.dart';
import 'package:wa_status_saver/utils/video_play.dart';

final Directory _videoDir =
    new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class VideoScreen extends StatefulWidget {
  @override
  VideoScreenState createState() => new VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory("${_videoDir.path}").existsSync()) {
      return WhatsappNotInstalled();
    } else {
      return VideoGrid(directory: _videoDir);
    }
  }
}

class VideoGrid extends StatefulWidget {
  final Directory directory;

  const VideoGrid({Key key, this.directory}) : super(key: key);

  @override
  _VideoGridState createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  // _getImage(videoPathUrl) async {
  //   //await Future.delayed(Duration(milliseconds: 500));
  //   String thumb = await Thumbnails.getThumbnail(
  //       videoFile: videoPathUrl,
  //       imageType:
  //           ThumbFormat.PNG, //this image will store in created folderpath
  //       quality: 10);
  //   return thumb;
  // }
  getVideo() {
    var videoList = widget.directory
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith(".mp4"))
        .toList(growable: false)
          ..sort((a, b) =>
              File(a).lastModifiedSync().compareTo(File(a).lastModifiedSync()));
    return videoList;
  }

  @override
  Widget build(BuildContext context) {
    if (getVideo() != null) {
      if (getVideo().length > 0) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: GridView.builder(
            itemCount: getVideo().length,
            // padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              childAspectRatio: 1.0,
              mainAxisSpacing: 3.0,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new PlayStatus(getVideo()[index])),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        // Where the linear gradient begins and ends
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        // Add one stop for each color. Stops should increase from 0 to 1
                        stops: [0.1, 0.3, 0.5, 0.7, 0.9],
                        colors: [
                          // Colors are easy thanks to Flutter's Colors class.
                          Color(0xffb7d8cf),
                          Color(0xffb7d8cf),
                          Color(0xffb7d8cf),
                          Color(0xffb7d8cf),
                          Color(0xffb7d8cf),
                        ],
                      ),
                    ),
                    child: FutureBuilder(
                        future: getImage(getVideo()[index]),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              return Hero(
                                tag: getVideo()[index],
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.file(
                                      File(snapshot.data),
                                      fit: BoxFit.cover,
                                    ),
                                    Icon(Icons.play_arrow,
                                        size: 50,
                                        color: Colors.black.withOpacity(0.5)),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () async {
                                            bool result =
                                                await GallerySaver.saveVideo(
                                                    getVideo()[index]);
                                            if (result) {
                                              showSnack(context,
                                                  "Video saved to gallery");
                                            }
                                            // saveImage(
                                            //   context: context,
                                            //   imgPath: imgPath,
                                            // );
                                          },
                                          child: Container(
                                              height: 20,
                                              width: 50,
                                              // width: double.infinity,
                                              color: Colors.teal,
                                              child: Icon(Icons.file_download,
                                                  color: Colors.white,
                                                  size: 12)),
                                        ))
                                  ],
                                ),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          } else {
                            return Hero(
                              tag: getVideo()[index],
                              child: Container(
                                height: 280.0,
                                child: Image.asset(
                                    "assets/images/video_loader.gif"),
                              ),
                            );
                          }
                        }),
                    //new cod
                  ),
                ),
              );
            },
          ),
        );
      } else {
        return Center(
          child: Text(
            "Sorry, No Videos Found.",
            style: TextStyle(fontSize: 18.0),
          ),
        );
      }
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
