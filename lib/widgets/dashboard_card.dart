import 'package:flutter/material.dart';

class DashboarsCard extends StatelessWidget {
  DashboarsCard(
      {Key? key,
      required this.imageUrl,
      required this.text1,
      required this.text2})
      : super(key: key);

  final String imageUrl;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 8, bottom: 8),
      child: Row(
        children: [
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    width: 100,
                    image: AssetImage(
                      imageUrl,
                    ),
                  ),
                  SizedBox(width: 5),
                  Row(
                    children: [
                      Text(
                        "$text2",
                        style: TextStyle(
                          color: Color.fromRGBO(28, 155, 107, 1.0),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
