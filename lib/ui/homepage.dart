import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:wa_status_saver/ui/dashboard.dart';
// import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:wa_status_saver/ui/send_message.dart';
import "package:external_app_launcher/external_app_launcher.dart";
import "package:wa_status_saver/utils/admob.dart";

class MyHome extends StatefulWidget {
  // final html =
  //     "<h3><b>How To Use?</b></h3><p>- Check the Desired Status/Story...</p><p>- Come Back to App, Click on any Image or Video to View...</p><p>- Click the Save Button...<br />The Image/Video is Instantly saved to your Galery :)</p><p>- You can also Use Multiple Saving. [to do]</p>";
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
 

  BannerAd _bannerAd;

  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(anchorType: AnchorType.bottom);
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
    );
    _loadBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () async {
            bool isInstalled = await LaunchApp.isAppInstalled(
                androidPackageName: "com.whatsapp");
            if (isInstalled) {
              LaunchApp.openApp(androidPackageName: "com.whatsapp");
            }
          },
          child: Image.asset(
            "assets/images/whatsapp.png",
            height: 30,
            width: 30,
          ),
        ),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.near_me,
                size: 25,
              ),
            
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SendMessageScreen()));
              }),

          // PopupMenuButton<String>(
          //   onSelected: choiceAction,/whats
          //   itemBuilder: (BuildContext context) {
          //     return Constants.choices.map((String choice) {
          //       return PopupMenuItem<String>(
          //         value: choice,
          //         child: Text(choice),
          //       );
          //     }).toList();
          //   },
          // )
        ],
        bottom: TabBar(indicatorSize: TabBarIndicatorSize.label,
            // indicatorSize: ,
            tabs: [
              Container(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'IMAGES',
                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'VIDEOS',
                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'SAVED IMAGES',
                ),
              ),
            ]),
      ),
      body: Dashboard(),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.about) {
      FlutterOpenWhatsapp.sendSingleMessage("918179015345", "Hello");
    } else if (choice == Constants.rate) {
      print('Rate App');
    } else if (choice == Constants.share) {
      print('Share with friends');
    }
  }
}

class Constants {
  static const String about = 'About App';
  static const String rate = 'Rate App';
  static const String share = 'Share with friends';

  static const List<String> choices = <String>[about, rate, share];
}
