import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:slits_project/color/constant_color.dart';
import 'package:slits_project/netwrok/api/api_services.dart';
import 'package:slits_project/screen/teacherTutorial/AdminSuggestion/model/admin_suggestion_model.dart';
import 'package:slits_project/widgets/widgetError.dart';
import 'package:slits_project/widgets/widgetSuccess.dart';

class ReplySuggestion extends StatelessWidget {
  ReplySuggestion(
      {Key? key,
      required this.title,
      required this.description,
      required this.user_id,
      this.admin_id})
      : super(key: key);
  String? title;
  String? description;
  String? user_id;
  String? admin_id;
  var textTilte = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reply"),
        centerTitle: true,
        backgroundColor: appColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(width: 1.5, color: appColor),
                ),
                title: Text("${title}"),
                subtitle: Text("$description"),
              ),
              SizedBox(
                height: 30,
              ),
              CupertinoButton(
                  color: appColor,
                  child: Text(
                    "Reply",
                    style: textColorWhite,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Reply"),
                            content: Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: textTilte,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter text";
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: "Please Enter your reply"),
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      AdminSuggestionModel model =
                                          AdminSuggestionModel(
                                              user_id: user_id,
                                              admin_id: admin_id,
                                              s_title:
                                                  "$title: ${textTilte.text}");
                                      print(model.toJson());
                                      ApiServices.reply(model).then((value) {
                                        if (value != null) {
                                          if (value == "Sent Successful") {
                                            Get.back();
                                            widgetSuccessSnackBar(value);
                                          } else {
                                            widgetErrorSnackBar(value);
                                          }
                                        } else {
                                          print("something went wrong");
                                        }
                                      });
                                    } else {
                                      print("somthing wrong");
                                    }
                                  },
                                  child: Text("Reply"))
                            ],
                          );
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
