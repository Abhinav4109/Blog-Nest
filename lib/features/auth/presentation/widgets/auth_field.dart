import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscureText;
  final IconButton? suffixIcon;
  const AuthField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isObscureText = false,
    this.suffixIcon,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: suffixIcon,
        ),
      ),
    );
  }
}
