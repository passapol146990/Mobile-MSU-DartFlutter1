import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:start_flutter/pages/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String text = 'This is my text';
  int count = 0;
  String phoneNo = '';
  // TextEditingController phoneCtl = TextEditingController();
  var phoneCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyApp', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Expanded(
        child: Container(
          color: Colors.black87,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              InkWell(
                onTap: clickImage,
                child: Image.asset('assets/images/hacker.jpg'),
              ),
              // GestureDetector(
              //   onTap: clickImage,
              //   child: Image.asset('assets/images/hacker.jpg'),
              // ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    textAlign: TextAlign.start,
                                    'หมายเลขโทรศัพท์',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              TextField(
                                // onChanged: (value) => {
                                //   setState(() {
                                //     phoneNo = value;
                                //   }),
                                // },
                                controller: phoneCtl,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    textAlign: TextAlign.start,
                                    'รหัสผ่าน',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              TextField(
                                obscureText: true,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => register(),
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                        Colors.transparent,
                                      ),
                                      elevation: WidgetStateProperty.all(0),
                                    ),
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      'ลงทะเบียนใหม่',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () =>
                                        login("username", "password"),
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                        Colors.green,
                                      ),
                                    ),
                                    child: const Text(
                                      'เข้าสู่ระบบ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    text,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clickImage() {
    log("image");
  }

  void register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  void login(String u, String p) {
    log(phoneCtl.text);
    // setState(() {
    //   count++;
    //   text = "Login : $count";
    // });
  }
}
