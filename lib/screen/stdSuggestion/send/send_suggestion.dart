import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:slits_project/color/constant_color.dart';
import 'package:slits_project/netwrok/api/api_services.dart';
import 'package:slits_project/screen/stdSuggestion/model/suggestion_model.dart';
import 'package:slits_project/validation/form_validation.dart';
import 'package:slits_project/widgets/text_field_description.dart';
import 'package:slits_project/widgets/text_filed_widget.dart';
import 'package:slits_project/widgets/widgetError.dart';
import 'package:slits_project/widgets/widgetSuccess.dart';

class SendSuggestion extends StatelessWidget {
  SendSuggestion({Key? key, required this.user_id, required this.name})
      : super(key: key);

  String? user_id;
  String? name;
  var textTitle = TextEditingController();
  var textDescription = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Send Suggestion"),
        centerTitle: true,
        backgroundColor: appColor,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormFiledWidget(
                    textController: textTitle,
                    hintText: "Suggestion Title",
                    iconData: Icons.title,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) {
                      return FormValidation.checkEmpty(value!);
                    }),
                SizedBox(height: 10),
                TextFormFiledDescription(
                    textController: textDescription,
                    hintText: "Description",
                    iconData: Icons.description,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) {
                      return FormValidation.checkEmpty(value!);
                    }),
                SizedBox(height: 30),
                CupertinoButton(
                  color: appColor,
                  child: Text(
                    "Submit",
                    style: textColorWhite,
                  ),
                  onPressed: () {
                    send();
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void send() {
    if (_formKey.currentState!.validate()) {
      SuggestionModel model = SuggestionModel(
          s_title: textTitle.text,
          s_description: textDescription.text,
          user_id: user_id,
          name: name);
      ApiServices.sendSuggestion(model).then((value) {
        if (value != null) {
          if (value == "submitted Successful") {
            Get.back();
            widgetSuccessSnackBar(value);
          } else {
            widgetErrorSnackBar(value);
          }
        } else {
          print("Somthing went wrong");
        }
      });
    }
  }
}
