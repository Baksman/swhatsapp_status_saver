import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'utils/admob.dart';
import 'package:wa_status_saver/ui/homepage.dart';
import 'package:wa_status_saver/ui/loading_screen.dart';
import 'package:wa_status_saver/ui/un_accepted.dart';

// import 'package:flutter_html/flutter_html;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  // Future<int> _storagePermissionCheck () async {
  //     int storagePermissionCheckInt;
  //     int finalPermission;

  //     print("Initial Values of $_storagePermissionCheck");
  //     if (_storagePermissionCheck == null || _storagePermissionCheck == 0) {
  //       _storagePermissionCheck = await checkStoragePermission();
  //     } else {
  //       _storagePermissionCheck = 1;
  //     }
  //     if (_storagePermissionCheck == 1) {
  //       storagePermissionCheckInt = 1;
  //     } else {
  //       storagePermissionCheckInt = 0;
  //     }

  //     if (storagePermissionCheckInt == 1) {
  //       finalPermission = 1;
  //     } else {
  //       finalPermission = 0;
  //     }

  //     return finalPermission;
  //   }

  Future<int> checkStoragePermission() async {
    PermissionStatus permissionStatus = await Permission.storage.status;
    if (permissionStatus.isGranted) {
      return 1;
    } else if (permissionStatus.isPermanentlyDenied) {
      return 2;
    }
    return 0;
  }

  Future<int> requestStoragePermission() async {
    // PermissionStatus result = await SimplePermissions.requestPermission(Permission.ReadExternalStorage);
    Map<Permission, PermissionStatus> result =
        await [Permission.storage].request();

    setState(() {});
    if (result[Permission.storage].isGranted) {
      return 1;
    } else if (result[Permission.storage].isPermanentlyDenied) {
      return 2;
    }
    return 0;
  }

  openSettings() {
    openAppSettings();
  }

  Future<void> _initAdMob() {
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }

  @override
  void initState() {
    super.initState();
    _initAdMob();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Status saver',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
      ),
      // darkTheme: darkTheme,
      home: DefaultTabController(
        length: 3,
        child: FutureBuilder(
          future: checkStoragePermission(),
          builder: (context, status) {
            if (!status.hasData) {
              return LoadingScreen();
            }
            if (status.data == 1) {
              return MyHome();
            } else if (status.data == 0) {
              return UnGranted(
                  title: "Storage Permission Required",
                  onTap: requestStoragePermission);
            }
            return UnGranted(
                title:
                    "Seems you have denied storage permission request go to application settings to manually grant storage permission to this app",
                onTap: openSettings);
          },
        ),
      ),
    );
  }
}
