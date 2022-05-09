import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:slits_project/screen/stdSuggestion/view/student_Suggestion.dart';
import 'package:slits_project/screen/teacherTutorial/AdminSuggestion/view/admin_suggestion.dart';
import 'package:slits_project/screen/teacherTutorial/view/teacher_tutorial.dart';
import 'package:slits_project/screen/tutorial/view/student_tutorial.dart';
import 'package:slits_project/widgets/dashboard_card.dart';

class DashboardWidget extends StatelessWidget {
  DashboardWidget({Key? key, required this.user_type}) : super(key: key);
  String? user_type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          user_type == "User"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentTutorial()));
                      },
                      child: DashboarsCard(
                        imageUrl: "images/students.png",
                        text1: "",
                        text2: "Tutorials",
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(StudentSuggestion());
                      },
                      child: DashboarsCard(
                        imageUrl: "images/suggestion_img.png",
                        text1: "",
                        text2: "Suggestion",
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeacherTutorial()));
                      },
                      child: DashboarsCard(
                        imageUrl: "images/teacher.png",
                        text1: "",
                        text2: "Tutorials",
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(AdminSuggestion());
                      },
                      child: DashboarsCard(
                        imageUrl: "images/suggestion_img.png",
                        text1: "",
                        text2: "Suggestion",
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
