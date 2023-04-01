import 'package:bigcart/screens/app_dashboard.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {

  final TextEditingController controller;
  final String title;

  SearchField({required this.controller, required this.title});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
            fillColor: Color(0xFFF4F5F9),
            filled: true,
            hintText: title,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: Icon(Icons.sort),
            hintStyle: const TextStyle(
                fontFamily: "Poppins"
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)))
    );
  }
}
