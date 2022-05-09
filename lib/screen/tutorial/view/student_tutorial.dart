import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slits_project/netwrok/api/api_services.dart';
import 'package:slits_project/preference/mypreferences.dart';

import 'package:slits_project/screen/tutorial/model/video_streaming_model.dart';
import 'package:slits_project/screen/videoplay/view/videoplay_screen.dart';
import 'package:video_player/video_player.dart';

class StudentTutorial extends StatefulWidget {
  StudentTutorial({Key? key}) : super(key: key);

  @override
  State<StudentTutorial> createState() => _StudentTutorialState();
}

class _StudentTutorialState extends State<StudentTutorial> {
  bool isLoading = false;
  Timer? _timer;
  String? user_id;
  @override
  void initState() {
    // TODO: implement initState
    getSharevalue();
    _timer = new Timer.periodic(Duration(milliseconds: 1000), (Timer timer) {
      setState(() {
        ApiServices.getVideoStream();
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
        backgroundColor: Color.fromRGBO(28, 155, 107, 1),
        title: Text("Tutorial"),
      ),
      body: SafeArea(
        child: FutureBuilder<List<VideoStreamingModel>>(
          future: ApiServices.getVideoStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("No Data Found"),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var videos = snapshot.data![index];
                    return ListTile(
                      onTap: () {
                        Get.to(VideoPlayScreen(
                          user_id: user_id,
                          v_id: videos.vId,
                          thumb_img: videos.thumbImg,
                          videoUrl: videos.videoUrl,
                          title: videos.vTitle,
                          description: videos.vDescription,
                          isShow: true,
                        ));
                      },
                      title: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
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
                                  image: NetworkImage("${videos.thumbImg}"),
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
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Text(
                                "${videos.vTitle}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 8.0),
                              child: Text(
                                "${videos.vDescription}",
                                style: TextStyle(color: Colors.black26),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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
