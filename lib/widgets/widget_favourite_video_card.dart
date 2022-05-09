import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:slits_project/netwrok/api/api_services.dart';
import 'package:slits_project/screen/favourites/model/favourite_model.dart';
import 'package:slits_project/screen/videoplay/view/videoplay_screen.dart';
import 'package:slits_project/widgets/widgetError.dart';
import 'package:slits_project/widgets/widgetSuccess.dart';

widgetFavouriteVideoCard(FavouriteModel model) {
  return ListTile(
    onTap: () {
      Get.to(VideoPlayScreen(
        user_id: model.user_id,
        v_id: model.v_id,
        thumb_img: model.thumb_img,
        videoUrl: model.video_url,
        title: model.v_title,
        description: model.v_description,
        isShow: false,
      ));
    },
    title: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
                image: NetworkImage("${model.thumb_img}"),
              ),
            ),
            InkWell(
              onTap: () {
                Get.defaultDialog(
                    title: "Alert",
                    middleText: "Do you want to delete?",
                    textCancel: "No",
                    textConfirm: "Yes",
                    onConfirm: () {
                      String user_id = "${model.user_id}";
                      String v_id = "${model.v_id}";
                      ApiServices.deleteFavourite(user_id, v_id).then((value) {
                        if (value != null) {
                          if (value == "removed from favourite") {
                            Get.back();
                            widgetSuccessSnackBar(value);
                          } else {
                            widgetErrorSnackBar(value);
                          }
                        } else {
                          widgetErrorSnackBar(value);
                        }
                      });
                    });
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.delete,
                  size: 30,
                  color: Colors.black26,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 10,
              right: 0,
              bottom: 0,
              child: Icon(
                Icons.play_circle_fill,
                size: 60,
                color: Colors.white,
              ),
            ),
          ]),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(
              "${model.v_title}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              "${model.v_description}",
              style: TextStyle(color: Colors.black26),
            ),
          ),
        ],
      ),
    ),
  );
}
