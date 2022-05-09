import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slits_project/netwrok/api/api_services.dart';
import 'package:slits_project/screen/signup/model/user_model.dart';
import 'package:slits_project/validation/form_validation.dart';
import 'package:slits_project/widgets/text_filed_widget.dart';
import 'package:slits_project/widgets/text_form_filed_pass.dart';
import 'package:slits_project/widgets/widgetError.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var nameTextController = TextEditingController();
  var phoneTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  var confirmPasswordTextController = TextEditingController();
  var formKeySignup = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Form(
            key: formKeySignup,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Registration",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormFiledWidget(
                    textController: nameTextController,
                    hintText: "Name",
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    iconData: CupertinoIcons.person,
                    validator: (value) {
                      return FormValidation.checkEmpty(value!);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFiledWidget(
                    textController: phoneTextController,
                    hintText: "Phone Number",
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.next,
                    iconData: CupertinoIcons.phone,
                    validator: (value) {
                      return FormValidation.checkEmpty(value!);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFiledWidget(
                    textController: emailTextController,
                    hintText: "Email",
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    iconData: CupertinoIcons.at,
                    validator: (value) {
                      return FormValidation.checkEmail(value!);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFiledPass(
                    textController: passwordTextController,
                    hintText: "Password",
                    inputType: TextInputType.visiblePassword,
                    inputAction: TextInputAction.next,
                    iconData: Icons.password,
                    validator: (value) {
                      return FormValidation.checkPassword(value!);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFiledPass(
                    textController: confirmPasswordTextController,
                    hintText: "Confirm Password",
                    inputType: TextInputType.visiblePassword,
                    inputAction: TextInputAction.done,
                    iconData: Icons.password,
                    validator: (value) {
                      return FormValidation.checkPassword(value!);
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CupertinoButton(
                      color: Colors.green,
                      child: Text("SignUp"),
                      onPressed: () {
                        checkValidate();
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
                  Text("OR"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Login to your account?"),
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Login"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  checkValidate() {
    if (formKeySignup.currentState!.validate()) {
      if (passwordTextController.text != confirmPasswordTextController.text) {
        widgetErrorSnackBar("Password Not Matched!");
      } else {
        UserModel userModel = UserModel(
            email: emailTextController.text,
            name: nameTextController.text,
            phoneNumber: phoneTextController.text,
            password: passwordTextController.text);

        insertData(userModel);
      }
    }
  }

  void insertData(UserModel userModel) async {
    try {
      setState(() {
        isLoading = true;
      });
      var res = await ApiServices.registration(userModel);
      if (res != null) {
        setState(() {
          isLoading = false;
        });
        if (res == "Registration Successful") {
          Navigator.pop(context);
          Get.snackbar('Response', '$res',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green);
        } else {
          Get.snackbar('Response', '$res',
              snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
        }
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
