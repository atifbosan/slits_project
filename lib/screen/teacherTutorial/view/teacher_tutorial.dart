import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slits_project/color/constant_color.dart';
import 'package:slits_project/netwrok/api/api_services.dart';
import 'package:slits_project/screen/teacherTutorial/addTutorial/view/add_tutorial_screen.dart';
import 'package:slits_project/screen/tutorial/model/video_streaming_model.dart';
import 'package:slits_project/screen/teacherTutorial/update/view/update_screen.dart';
import 'package:slits_project/widgets/widgetError.dart';
import 'package:slits_project/widgets/widgetSuccess.dart';

class TeacherTutorial extends StatefulWidget {
  TeacherTutorial({Key? key}) : super(key: key);

  @override
  State<TeacherTutorial> createState() => _TeacherTutorialState();
}

class _TeacherTutorialState extends State<TeacherTutorial> {
  bool isLoading = false;
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
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
        backgroundColor: appColor,
        title: Text("SLITS"),
      ),
      body: FutureBuilder<List<VideoStreamingModel>>(
        future: ApiServices.getVideoStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("No Data found!"),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var videos = snapshot.data![index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(videos.thumbImg),
                            height: 80,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${videos.vTitle}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${videos.vDescription}",
                                style: TextStyle(color: Colors.black26),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.to(UpdateScreen(
                                      title: videos.vTitle,
                                      description: videos.vDescription,
                                      v_id: videos.vId));
                                },
                                icon: Icon(Icons.edit),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              IconButton(
                                onPressed: () {
                                  //print("ID: " + videos.vId!);
                                  Get.defaultDialog(
                                      title: "Alert",
                                      middleText: "Do you want to delete?",
                                      textCancel: "No",
                                      confirmTextColor: Colors.white,
                                      textConfirm: "Yes",
                                      onConfirm: () {
                                        delete(videos.vId!);
                                      });
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ],
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColor,
        onPressed: () {
          Get.to(AddTutorialScreen());
        },
        child: Icon(CupertinoIcons.add),
      ),
    );
  }

  void delete(String? v_id) async {
    try {
      setState(() {
        isLoading = true;
      });
      var result = await ApiServices.deleteData(v_id!);
      if (result != null) {
        setState(() {
          isLoading = false;
        });
        if (result == "Deletion Successful!") {
          widgetSuccessSnackBar("Deleted Successfully");
        } else {
          widgetErrorSnackBar(result);
        }
        Navigator.pop(context);
      } else {
        widgetErrorSnackBar(result);
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
