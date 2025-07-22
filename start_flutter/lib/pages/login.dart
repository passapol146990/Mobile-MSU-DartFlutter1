import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:start_flutter/pages/register.dart';
import 'package:start_flutter/pages/showtrip.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String text = '';
  int count = 0;
  String phoneNo = '';
  // TextEditingController phoneCtl = TextEditingController();
  var phoneCtl = TextEditingController();
  var password = TextEditingController();

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
                                  hintText: "admin",
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
                                controller: password,
                                obscureText: true,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "admin",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(text, style: TextStyle(color: Colors.white)),
                          ],
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
                                        login(phoneCtl.text, password.text),
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
    if (u == 'admin' && p == "admin") {
      log("login success");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShowtripPage()),
      );
      setState(() {
        text = '';
      });
    } else {
      setState(() {
        text = "เบอร์หรือรหัสผ่านไม่ถูกต้อง";
      });
    }
  }
}
