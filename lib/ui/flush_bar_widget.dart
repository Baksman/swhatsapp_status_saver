// import 'package:flash/flash.dart';
// import 'package:flutter/material.dart';

// void showBottomFlash(
//     {bool persistent = true,
//     EdgeInsets margin = EdgeInsets.zero,
//     @required context,
//     String title,
//     String subTitle}) {
//   showFlash(
//     context: context,
//     persistent: persistent,
//     builder: (_, controller) {
//       return Flash(
//         controller: controller,
//         margin: margin,
//         borderRadius: BorderRadius.circular(8.0),
//         borderColor: Colors.blue,
//         boxShadows: kElevationToShadow[8],
//         backgroundGradient: RadialGradient(
//           colors: [Colors.teal, Colors.green],
//           center: Alignment.topLeft,
//           radius: 2,
//         ),
//         onTap: () => controller.dismiss(),
//         forwardAnimationCurve: Curves.easeInCirc,
//         reverseAnimationCurve: Curves.bounceIn,
//         child: DefaultTextStyle(
//           style: TextStyle(color: Colors.white),
//           child: FlashBar(
//             title: Text(title ?? ""),
//             message: Text(subTitle ?? ""),
//             leftBarIndicatorColor: Colors.red,
//             icon: Icon(Icons.info_outline),
//             primaryAction: FlatButton(
//               onPressed: () => controller.dismiss(),
//               child: Text('Close'),
//             ),
//             // actions: <Widget>[
//             //   FlatButton(
//             //       onPressed: () => controller.dismiss('Yes, I do!'),
//             //       child: Text('YES')),
//             //   FlatButton(
//             //       onPressed: () => controller.dismiss('No, I do not!'),
//             //       child: Text('NO')),
//             // ],
//           ),
//         ),
//       );
//     },
//   ).then((_) {});
// }

import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

showSnack(BuildContext context, String title) {
  return showTopSnackBar(
    context,
    CustomSnackBar.success(
      message: title ?? "",
    ),
  );
}

erroSnackBar(BuildContext context, String title) {
  return showTopSnackBar(
    context,
    CustomSnackBar.error(
      message: title ?? "",
    ),
  );
}
