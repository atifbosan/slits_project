import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slits_project/color/constant_color.dart';
import 'package:http/http.dart' as http;
import 'package:slits_project/netwrok/root/url_root.dart';
import 'package:slits_project/preference/mypreferences.dart';
import 'package:slits_project/screen/teacherTutorial/addTutorial/model/video_add_model.dart';
import 'package:slits_project/validation/form_validation.dart';
import 'package:slits_project/widgets/text_field_description.dart';
import 'package:slits_project/widgets/text_filed_widget.dart';
import 'package:slits_project/widgets/widgetError.dart';
import 'package:slits_project/widgets/widgetSuccess.dart';

class AddTutorialScreen extends StatefulWidget {
  const AddTutorialScreen({Key? key}) : super(key: key);

  @override
  _AddTutorialScreenState createState() => _AddTutorialScreenState();
}

class _AddTutorialScreenState extends State<AddTutorialScreen> {
  var videoUrl;
  var textTitle = TextEditingController();
  var textDescription = TextEditingController();
  File? fileVideo;
  File? thumbnail;
  var _formKey = GlobalKey<FormState>();
  bool isUploading = false;
  String? user_id;
  @override
  void initState() {
    // TODO: implement initState
    getSharevalue();
    super.initState();
  }

  String? progress;
  @override
  Widget build(BuildContext context) {
    final fileName =
        fileVideo != null ? basename(fileVideo!.path) : "Select Video";
    final fileImage =
        thumbnail != null ? basename(thumbnail!.path) : "Select Thumbnail";
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text("Upload Tutorial"),
        centerTitle: true,
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
                    hintText: "Title",
                    iconData: Icons.title,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) {
                      return FormValidation.checkEmpty(value!);
                    }),
                SizedBox(
                  height: 5,
                ),
                TextFormFiledDescription(
                    textController: textDescription,
                    hintText: "Description",
                    iconData: Icons.description,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) {
                      return FormValidation.checkEmpty(value!);
                    }),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: selectVideo,
                    label: Text("$fileName"),
                    icon: Icon(Icons.attach_file),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: selectThumbnail,
                    label: Text("$fileImage"),
                    icon: Icon(Icons.attach_file),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CupertinoButton(
                    color: appColor,
                    child: Text(
                      "Upload",
                      style: textColorWhite,
                    ),
                    onPressed: uploadTest),
                SizedBox(
                  height: 10,
                ),
                Text(progress == null ? "" : "$progress"),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future selectVideo() async {
    var ressult = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.video);
    if (ressult != null) {
      final path = ressult.files.single.path;
      PlatformFile file = ressult.files.first;
      setState(() {
        fileVideo = File(path!);
        videoUrl = file.path;
      });
    }
  }

  Future selectThumbnail() async {
    var ressult = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    if (ressult != null) {
      final path = ressult.files.single.path;
      setState(() {
        thumbnail = File(path!);
      });
    }
  }

  /* uploadVideo() async {
    if (_formKey.currentState!.validate()) {
      if (fileVideo == null || thumbnail == null) {
        widgetErrorSnackBar("Please make sure both files selected or not!");
      } else {
        var request =
            http.MultipartRequest('POST', Uri.parse(UrlRoot.VIDEOS_UPLOAD));
        request.fields['admin_id'] = user_id!;
        request.fields['v_title'] = textTitle.text;
        request.fields['v_description'] = textDescription.text;

        var video = await http.MultipartFile.fromPath('video', videoUrl);
        var image = await http.MultipartFile.fromPath('image', thumbnail!.path);
        request.files.add(video);
        request.files.add(image);
        var response = await request.send();
        if (response.statusCode == 200) {
          print(response.reasonPhrase);
        }
      }
    } else {
      //------
    }
  }*/

  Future uploadTest() async {
    String uploadurl = UrlRoot.VIDEOS_UPLOAD;
    if (_formKey.currentState!.validate()) {
      if (fileVideo == null || thumbnail == null) {
        widgetErrorSnackBar("Please make sure both files selected or not!");
      } else {
        FormData formdata = FormData.fromMap({
          'admin_id': "2",
          'v_title': textTitle.text,
          'v_description': textDescription.text,
          'image': await MultipartFile.fromFile(thumbnail!.path,
              filename: basename(thumbnail!.path)),
          "video": await MultipartFile.fromFile(videoUrl,
              filename: basename(videoUrl)
              //show only filename from path
              ),
        });
        //-----------
        var response = await Dio().post(
          uploadurl,
          data: formdata,
          onSendProgress: (int sent, int total) {
            String percentage = (sent / total * 100).toStringAsFixed(2);
            setState(() {
              progress = "$sent" +
                  " Bytes of " "$total Bytes - " +
                  percentage +
                  " % uploaded";
              //update the progress
            });
          },
        );
        if (response.statusCode == 200) {
          widgetSuccessSnackBar(
              "Upload Status: " + response.statusMessage.toString());
        } else {
          print("Error during connection to server.");
        }
      }
    } else {
      //------
    }
  }

  getSharevalue() {
    MyPref.instance.getStringValue("user_id").then((value) => {
          setState(() {
            user_id = value;
          }),
        });
  }
}
