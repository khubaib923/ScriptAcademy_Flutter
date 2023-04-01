import 'package:flutter/material.dart';

class MessageField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  MessageField({required this.controller, required this.title});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        maxLines: 8,
        validator: (currentValue) {
          var nonNullable = currentValue ?? "";
          if (nonNullable.isEmpty) {
            return "Message field can't be empty!";
          }else if(nonNullable.length<30){
            return "Message is too short!";
          }
          return null;
        },
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: title,
            hintStyle: const TextStyle(fontFamily: "Poppins"),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10))));
  }
}
