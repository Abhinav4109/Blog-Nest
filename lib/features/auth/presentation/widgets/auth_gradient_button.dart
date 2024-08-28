import 'package:blog_nest/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  const AuthGradientButton({super.key, required this.buttonText});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppPallete.gradient1,
              AppPallete.gradient2,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(7)),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 55),
              foregroundColor: AppPallete.whiteColor,
              backgroundColor: AppPallete.transparentColor,
              shadowColor: AppPallete.transparentColor),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }
}
