import 'package:flutter/material.dart';
import 'package:start_flutter/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: "MyApp", home: LoginPage());
  }
}
