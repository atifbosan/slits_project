import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:slits_project/color/constant_color.dart';
import 'package:slits_project/netwrok/api/api_services.dart';
import 'package:slits_project/preference/mypreferences.dart';
import 'package:slits_project/screen/teacherTutorial/AdminSuggestion/model/admin_suggestion_model.dart';
import 'package:slits_project/screen/teacherTutorial/AdminSuggestion/reply/reply_suggestion.dart';

class AdminSuggestion extends StatefulWidget {
  const AdminSuggestion({Key? key}) : super(key: key);

  @override
  State<AdminSuggestion> createState() => _AdminSuggestionState();
}

class _AdminSuggestionState extends State<AdminSuggestion> {
  String? user_id;
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    _timer = new Timer.periodic(Duration(milliseconds: 1000), (Timer timer) {
      setState(() {
        ApiServices.fetchAdminMsg();
      });
    });

    getSharevalue();
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
        title: Text("Suggestions"),
        centerTitle: true,
        backgroundColor: appColor,
      ),
      body: SafeArea(
        child: FutureBuilder<List<AdminSuggestionModel>>(
          future: ApiServices.fetchAdminMsg(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("No Data Found!"),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var items = snapshot.data![index];

                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: items.is_view.toString() == "0"
                          ? Colors.red
                          : appColor,
                      child: ListTile(
                        onTap: () {
                          ApiServices.updateStatus(items.s_id.toString())
                              .then((value) {
                            if (value != null) {
                              Get.to(ReplySuggestion(
                                title: items.s_title,
                                description: items.s_description,
                                user_id: items.user_id,
                                admin_id: '2',
                              ));
                              print("Updation Successful");
                            } else {
                              print("updation failed");
                            }
                          });
                        },
                        title: Text(
                          "${items.s_title}",
                          style: textColorWhite,
                        ),
                        subtitle: Text(
                          "${items.s_description}",
                          style: textColorWhite,
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

    /* MyPref.instance.getStringValue("name").then((value) => {
      setState(() {
        name = value;
      }),
    });*/
  }
}
