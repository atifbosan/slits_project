import 'package:flutter/material.dart';
import 'package:slits_project/color/constant_color.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Downloads"),
        centerTitle: true,
        backgroundColor: appColor,
      ),
      body: Center(
        child: Text(
          "Downloads",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
