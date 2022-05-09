import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:slits_project/screen/downloads/view/downloads_screen.dart';
import 'package:slits_project/screen/favourites/view/favourites_screen.dart';
import 'package:slits_project/screen/home/view/my_home_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var tabIndex = 0;

  void changeTabIndex(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final List<Widget> Screens = [
    MyHomeScreen(),
    FavoritesScreen(),
    DownloadScreen()
  ];

  Color pickColor = Color.fromRGBO(20, 172, 116, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IndexedStack(
          index: tabIndex,
          children: [
            MyHomeScreen(),
            FavoritesScreen(),
            DownloadScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: changeTabIndex,
        currentIndex: tabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.suit_heart,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.tray_arrow_down,
            ),
            label: 'Downloads',
          ),
        ],
      ),
    );
  }
}
