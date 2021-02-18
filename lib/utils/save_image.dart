import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wa_status_saver/ui/flush_bar_widget.dart';

saveImage({String imgPath, BuildContext context}) async {
  // _onLoading(true, "");

  // Uri myUri = Uri.parse(imgPath);
  // File originalImageFile = new File.fromUri(myUri);
  // Uint8List bytes;
  // await originalImageFile.readAsBytes().then((value) {
  //   bytes = Uint8List.fromList(value);
  //   // print('reading of bytes is completed');
  // }).catchError((onError) {});
  // final result =
  //     await ImageGallerySaver.saveImage(Uint8List.fromList(bytes));
  final result = await GallerySaver.saveImage(imgPath);
  if (result) {
    showSnack(
      context,
      "Image has been saved to device",
    );
  }

  // _onLoading(false,
  //     "If Image not available in gallery\n\nYou can find all images at");
}
