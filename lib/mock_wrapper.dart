import 'package:flutter/material.dart';

class Mockwrapper extends StatelessWidget {
  final Widget child;
  const Mockwrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: child,
      ),
    );
  }
}
