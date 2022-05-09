import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:slits_project/screen/bottom/view/main_page.dart';
import 'package:slits_project/screen/login/view/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.user_id}) : super(key: key);
  final String? user_id;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "SLITS",
      debugShowCheckedModeBanner: false,
      home: user_id != null ? MainPage() : LoginScreen(),
    );
  }
}
