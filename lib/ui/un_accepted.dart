import "package:flutter/material.dart";

class UnGranted extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const UnGranted({Key key, this.title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/whatsapp.png", height: 80, width: 80),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  //  "Storage Permission Required",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
            FlatButton(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Check Permission",

                style: TextStyle(fontSize: 15.0),
              ),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: onTap,
            )
          ],
        ),
      ),
    );
  }
}
