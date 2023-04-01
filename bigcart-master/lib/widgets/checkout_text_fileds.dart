import 'package:flutter/material.dart';

class CheckOutTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  CheckOutTextField({required this.controller, required this.title});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        validator: (currentValue) {
          var nonNullable = currentValue ?? "";
          if (nonNullable.isEmpty) {
            return "$title field can't be empty!";
          }
          return null;
        },
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: title,
            prefixIcon: const Icon(Icons.person),
            hintStyle: const TextStyle(fontFamily: "Poppins"),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10))));
  }
}
