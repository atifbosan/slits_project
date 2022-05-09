import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:slits_project/color/constant_color.dart';
import 'package:slits_project/netwrok/api/api_services.dart';
import 'package:slits_project/preference/mypreferences.dart';
import 'package:slits_project/screen/stdSuggestion/model/suggestion_model.dart';
import 'package:slits_project/screen/stdSuggestion/send/send_suggestion.dart';

class StudentSuggestion extends StatefulWidget {
  const StudentSuggestion({Key? key}) : super(key: key);

  @override
  _StudentSuggestionState createState() => _StudentSuggestionState();
}

class _StudentSuggestionState extends State<StudentSuggestion> {
  String? user_id;
  String? name;
  @override
  void initState() {
    // TODO: implement initState
    getSharevalue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sugestions"),
        centerTitle: true,
        backgroundColor: appColor,
      ),
      body: SafeArea(
          child: FutureBuilder<List<SuggestionModel>>(
        future: ApiServices.fetchSuggestion(user_id.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("No Data Found"),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var items = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text("${items.s_title}"),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.5, color: appColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColor,
        onPressed: () {
          Get.to(SendSuggestion(
            user_id: user_id,
            name: name,
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  getSharevalue() {
    MyPref.instance.getStringValue("user_id").then((value) => {
          setState(() {
            user_id = value;
          }),
        });
    MyPref.instance.getStringValue("name").then((value) => {
          setState(() {
            name = value;
          }),
        });
  }
}
