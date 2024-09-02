import 'package:flutter/material.dart';

class Homeee extends StatelessWidget {
  const Homeee({super.key});
 static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      body:  Center(
        child: Text('You have done it'),
      ),
    );
  }
}