import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Hero(
              tag: "SonderLogo",
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    "S O N D E R",
                    style:
                        TextStyle(fontSize: 30, color: Colors.black, shadows: [
                      Shadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 5.0,
                          color: Colors.black),
                    ]),
                  ),
                ),
              ),
            ),
            Text(
              "All pictures are provided by the unsplash source API, and are licensed by their respective authors.",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
