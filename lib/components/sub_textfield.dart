import 'package:flutter/material.dart';

class SubTextField extends StatelessWidget {
  const SubTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.prefixIcons,
    this.enableInteractiveSelection = true,
    this.focusNode,
    this.onTap,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcons;
  final bool enableInteractiveSelection;
  final FocusNode? focusNode;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (onTap == null) ? null : () {},
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
        enableInteractiveSelection: enableInteractiveSelection,
        focusNode: focusNode,
        decoration: InputDecoration(
          prefixIcon: (prefixIcons == null)
              ? null
              : Icon(
                  prefixIcons,
                  color: Colors.white60,
                ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
