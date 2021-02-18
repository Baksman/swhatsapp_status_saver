// to diplay this screen if whatsapp is not installed on device

import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';

class WhatsappNotInstalled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Center(child: Text("You dont have whatsapp installed")),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Install",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              onPressed: () {
                StoreRedirect.redirect(androidAppId: "com.whatsapp");
              },
            ),
          )
        ]));
  }
}
