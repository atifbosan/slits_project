import 'package:flutter/material.dart';

class TextFormFiledDescription extends StatelessWidget {
  TextFormFiledDescription(
      {Key? key,
      required this.textController,
      required this.hintText,
      required this.iconData,
      required this.inputType,
      required this.inputAction,
      required this.validator})
      : super(key: key);
  var textController = TextEditingController();
  TextInputAction inputAction = TextInputAction.next;
  TextInputType inputType = TextInputType.text;
  IconData? iconData;
  String? hintText;
  final FormFieldValidator<String> validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      textInputAction: inputAction,
      keyboardType: inputType,
      validator: validator,
      enabled: true,
      maxLines: 4,
      decoration: InputDecoration(
        focusColor: Colors.grey.shade600,
        prefixIcon: Icon(
          iconData,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        fillColor: Colors.grey.shade600,
        hintText: "$hintText",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontFamily: "verdana_regular",
          fontWeight: FontWeight.w400,
        ),
        labelText: '$hintText',
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontFamily: "verdana_regular",
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
