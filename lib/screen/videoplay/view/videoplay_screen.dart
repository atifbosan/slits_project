import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:slits_project/netwrok/api/api_services.dart';
import 'package:slits_project/screen/favourites/model/favourite_model.dart';
import 'package:slits_project/widgets/widgetError.dart';
import 'package:slits_project/widgets/widgetSuccess.dart';

class VideoPlayScreen extends StatelessWidget {
  VideoPlayScreen(
      {Key? key,
      required this.user_id,
      required this.v_id,
      required this.videoUrl,
      required this.thumb_img,
      required this.title,
      required this.description,
      required this.isShow})
      : super(key: key);
  final String? user_id;
  final String? v_id;
  final String? videoUrl;
  final String? thumb_img;
  final String? title;
  final String? description;
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 155, 107, 1),
        title: Text("Play Video"),
        actions: [
          isShow == true
              ? Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          FavouriteModel model = FavouriteModel(
                              v_id: v_id,
                              v_title: title,
                              v_description: description,
                              thumb_img: thumb_img,
                              video_url: videoUrl,
                              user_id: user_id);
                          ApiServices.addFavourite(model).then((value) {
                            if (value != null) {
                              if (value == "Added to favourite") {
                                widgetSuccessSnackBar(value);
                              } else {
                                widgetErrorSnackBar("$value");
                              }
                            } else {
                              widgetErrorSnackBar("Something went wrong");
                            }
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.download_sharp,
                          color: Colors.white,
                        )),
                  ],
                )
              : Container(),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer.network("$videoUrl"),
            ),
            SizedBox(
              height: 9,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$title"),
                    Text(
                      "$description",
                      style: TextStyle(color: Colors.black26),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
