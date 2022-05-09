import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slits_project/color/constant_color.dart';
import 'package:slits_project/netwrok/api/api_services.dart';

import 'package:slits_project/validation/form_validation.dart';
import 'package:slits_project/widgets/text_filed_widget.dart';
import 'package:slits_project/widgets/widgetError.dart';
import 'package:slits_project/widgets/widgetSuccess.dart';

class UpdateScreen extends StatefulWidget {
  UpdateScreen(
      {Key? key,
      required this.title,
      required this.description,
      required this.v_id})
      : super(key: key);
  final String? v_id;
  final String? title;
  final String? description;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  var formKeyControl = GlobalKey<FormState>();

  var textTitle = TextEditingController();

  var textdescription = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    textTitle.text = widget.title!;
    textdescription.text = widget.description!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text("Update Details"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: formKeyControl,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormFiledWidget(
                    textController: textTitle,
                    hintText: "title",
                    iconData: Icons.title,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) {
                      return FormValidation.checkEmpty(value!);
                    }),
                SizedBox(
                  height: 10,
                ),
                TextFormFiledWidget(
                    textController: textdescription,
                    hintText: "Description",
                    iconData: Icons.title,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) {
                      return FormValidation.checkEmpty(value!);
                    }),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CupertinoButton(
                      color: appColor,
                      child: Text("Update"),
                      onPressed: () {
                        updateData(
                            widget.v_id!, textTitle.text, textdescription.text);
                      }),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void updateData(String v_id, String title, String description) async {
    try {
      setState(() {
        isLoading = true;
      });

      var result = await ApiServices.updateVideoData(v_id, title, description);
      if (result != null) {
        setState(() {
          isLoading = false;
        });

        if (result == "Updation Successful!") {
          Navigator.pop(context);
          widgetSuccessSnackBar("Updation Successful!");
        } else {
          widgetErrorSnackBar(result);
        }
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
