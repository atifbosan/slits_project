import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slits_project/netwrok/api/api_services.dart';
import 'package:slits_project/screen/bottom/view/main_page.dart';
import 'package:slits_project/screen/signup/view/signup_screen.dart';
import 'package:slits_project/validation/form_validation.dart';
import 'package:slits_project/widgets/text_filed_widget.dart';
import 'package:slits_project/widgets/text_form_filed_pass.dart';
import 'package:slits_project/widgets/widgetError.dart';
import 'package:slits_project/widgets/widgetSuccess.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List user_list = ['User', 'Admin'];
  String? selecteduser;
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFiledWidget(
                    textController: emailTextController,
                    hintText: "Email",
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.done,
                    iconData: Icons.alternate_email,
                    validator: (value) {
                      return FormValidation.checkEmail(value!);
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormFiledPass(
                    textController: passwordTextController,
                    hintText: "Password",
                    inputType: TextInputType.visiblePassword,
                    inputAction: TextInputAction.done,
                    iconData: Icons.password,
                    validator: (value) {
                      return FormValidation.checkPassword(value!);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    //margin: EdgeInsets.only(left: 20, right: 20),
                    height: 57,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.5, color: Colors.black26),
                        borderRadius: BorderRadius.circular(12)),
                    child: DropdownButton(
                      hint: Text(
                        "Please Select User Type",
                        style: TextStyle(color: Colors.black),
                      ),
                      value: selecteduser,
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      style: TextStyle(color: Colors.black),
                      focusColor: Colors.white,
                      underline: Container(),
                      onChanged: (value) {
                        setState(() {
                          selecteduser = value.toString();
                        });
                      },
                      items: user_list.map((valueItem) {
                        return DropdownMenuItem(
                            value: valueItem, child: Text("$valueItem"));
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                      color: Colors.green,
                      child: Text("Login"),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (selecteduser == null) {
                            widgetErrorSnackBar("Please Select User Type");
                          } else {
                            ApiServices.login(emailTextController.text,
                                    passwordTextController.text, selecteduser!)
                                .then((value) => {
                                      if (value == "Bad Request")
                                        {
                                          setState(() {
                                            isLoading = false;
                                          }),
                                          widgetErrorSnackBar("Bad Request"),
                                        }
                                      else if (value ==
                                          "You are logged in successfully")
                                        {
                                          widgetSuccessSnackBar(
                                              "You are logged in successfully"),
                                          setState(() {
                                            isLoading = false;
                                          }),
                                          Get.offAll(MainPage()),
                                        }
                                      else
                                        {
                                          widgetErrorSnackBar("$value"),
                                          setState(() {
                                            isLoading = false;
                                          }),
                                        }
                                    });
                          }
                        }
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
                      Text("Create an account? "),
                      TextButton(
                          onPressed: () {
                            Get.to(SignupScreen());
                          },
                          child: Text("Signup"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
