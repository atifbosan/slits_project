import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slits_project/preference/mypreferences.dart';
import 'package:slits_project/screen/login/view/login_screen.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key, required this.name}) : super(key: key);
  String name;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Stack(
      children: [
        Container(
          color: Color.fromRGBO(28, 155, 107, 1),
          child: ListView(
            children: [
              DrawerHeader(
                  child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("images/man_image.png"),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    name == null ? "Guest" : "$name",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              )),
              Card(
                color: Color.fromRGBO(20, 172, 116, 1),
                child: ListTile(
                  focusColor: Colors.green,
                  leading: Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  title: Text(
                    "About SLITS",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Card(
                color: Color.fromRGBO(20, 172, 116, 1),
                child: ListTile(
                  onTap: () async {
                    MyPref.instance.removeAll();

                    Get.offAll(() => LoginScreen());
                  },
                  focusColor: Colors.green,
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Image(
            image: AssetImage("images/slits_updated .png"),
          ),
        )
      ],
    ));
  }
}
