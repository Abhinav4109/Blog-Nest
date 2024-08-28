import 'package:blog_nest/core/theme/theme.dart';
import 'package:blog_nest/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_nest/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog Nest',
      theme: AppTheme.darkThemeMode,
      home: const SignupPage(),
    );
  }
}
