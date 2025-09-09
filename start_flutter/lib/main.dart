import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:start_flutter/pages/HomePage.dart';
import 'package:start_flutter/pages/login.dart';
import 'package:start_flutter/pages/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
    );
  }
}
