import 'package:flutter/material.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        fontSize: 24,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
      ),
    );
  }
}
