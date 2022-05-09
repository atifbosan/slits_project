import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slits_project/preference/mypreferences.dart';
import 'package:slits_project/widgets/dashboard_widget.dart';
import 'package:slits_project/widgets/drawer_widget.dart';

class MyHomeScreen extends StatefulWidget {
  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  var keyScaffold = GlobalKey<ScaffoldState>();
  String? name;
  String? email;
  String? user_id;
  String? user_type;
  bool isEnable = false;
  @override
  void initState() {
    // TODO: implement initState
    getSharevalue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: keyScaffold,
      backgroundColor: Color.fromRGBO(28, 155, 107, 1.0),
      endDrawer: DrawerWidget(
        name: "${name}",
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.329,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.27,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(28, 155, 107, 1),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7)
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        height: 180,
                        width: 170,
                        image: AssetImage("images/slit.png"),
                      ),
                      IconButton(
                          onPressed: () {
                            keyScaffold.currentState!.openEndDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            size: 30,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                /*  Positioned(
                  left: 10,
                  right: 10,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: "Search",
                        fillColor: Colors.white,
                        suffixIcon: Icon(
                          Icons.search_outlined,
                          color: Colors.grey,
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 15.0, bottom: 5.0, top: 5.0, right: 15.0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(20, 172, 116, 1),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
          Expanded(
              child: DashboardWidget(
            user_type: user_type,
          ))
        ],
      )),
      floatingActionButton: SpeedDial(
        onOpen: () {
          setState(() {
            isEnable = true;
          });
        },
        onClose: () {
          setState(() {
            isEnable = false;
          });
        },
        backgroundColor: Color.fromRGBO(28, 155, 107, 1),
        icon: isEnable == false ? Icons.add : Icons.close,
        children: [
          SpeedDialChild(
            onTap: () {
              getImageFromGallery();
            },
            label: "Gallery",
            child: Icon(Icons.photo_library_outlined),
          ),
          SpeedDialChild(
            onTap: () {
              getImageFromCamera();
            },
            label: "Camera",
            child: Icon(Icons.photo_camera_outlined),
          ),
        ],
      ),
    );
  }

  //--------------------
  getSharevalue() {
    MyPref.instance.getStringValue("user_id").then((value) => {
          setState(() {
            user_id = value;
          }),
        });
    MyPref.instance.getStringValue("email").then((value) => {
          email = value,
          setState(() {
            email = value;
          }),
        });
    MyPref.instance.getStringValue("name").then((value) => {
          setState(() {
            name = value;
          }),
        });
    MyPref.instance.getStringValue("user_type").then((value) => {
          setState(() {
            user_type = value;
          }),
        });
  }

  //--------------
  Future<void> getImageFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
    }
  }

  Future<void> getImageFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
    }
  }
}
