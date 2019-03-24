import 'package:extended_share/extended_share.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: FlatButton(
            child: Text("Share"),
            onPressed: () {
              ExtendedShare.share(text: "Some text", subject: "A subject");
            },
          ),
        ),
      ),
    );
  }
}
