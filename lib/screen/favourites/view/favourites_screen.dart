import 'dart:async';

import 'package:flutter/material.dart';
import 'package:slits_project/color/constant_color.dart';
import 'package:slits_project/netwrok/api/api_services.dart';
import 'package:slits_project/preference/mypreferences.dart';
import 'package:slits_project/screen/favourites/model/favourite_model.dart';
import 'package:slits_project/widgets/widget_favourite_video_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Timer? _timer;
  String? user_id;

  @override
  void initState() {
    // TODO: implement initState
    getSharevalue();
    _timer = new Timer.periodic(Duration(milliseconds: 1000), (Timer timer) {
      setState(() {
        ApiServices.fetchFavourite(user_id.toString());
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite"),
        centerTitle: true,
        backgroundColor: appColor,
      ),
      body: SafeArea(
        child: FutureBuilder<List<FavouriteModel>>(
          future: ApiServices.fetchFavourite(user_id.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("No Favourite List Found"),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final itemsFavourite = snapshot.data![index];
                    return widgetFavouriteVideoCard(itemsFavourite);
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  getSharevalue() {
    MyPref.instance.getStringValue("user_id").then((value) => {
          setState(() {
            user_id = value;
          }),
        });
  }
}
