import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:start_flutter/config/config.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  TextEditingController fullname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  String message = "";
  var color = Colors.red;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  Padding _passapol_input(
    String text,
    TextEditingController controller,
    TextInputType type,
    bool hide,
  ) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: controller,
            keyboardType: type,
            obscureText: hide,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
              hintText: text,
              labelText: text,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ลงทะเบียนสมาชิกใหม่')),
      body: Expanded(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    _passapol_input(
                      "ชื่อ-นามสกุล",
                      fullname,
                      TextInputType.text,
                      false,
                    ),
                    _passapol_input(
                      "หมายเลขโทรศัพท์",
                      phone,
                      TextInputType.phone,
                      false,
                    ),
                    _passapol_input(
                      "อีเมล",
                      email,
                      TextInputType.emailAddress,
                      false,
                    ),
                    _passapol_input(
                      "รหัสผ่าน",
                      password,
                      TextInputType.visiblePassword,
                      true,
                    ),
                    _passapol_input(
                      "ยืนยันรหัสผ่าน",
                      confirmPassword,
                      TextInputType.visiblePassword,
                      true,
                    ),
                    Text(message, style: TextStyle(color: color)),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => register(
                                fullname.text,
                                phone.text,
                                email.text,
                                password.text,
                                confirmPassword.text,
                              ),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.deepPurple,
                                ),
                              ),
                              child: Text(
                                "สมัครสมาชิก",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("หากมีบัญชีอยู่แล้ว?"),
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Text(
                                  "เข้าสู่ระบบ",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 15,
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
        ),
      ),
    );
  }

  String url = '';

  void register(
    String name,
    String phone,
    String email,
    String password,
    String confirmpassword,
  ) {
    var data = {
      "fullname": name,
      "phone": phone,
      "email": email,
      "password": password,
      "confirmpassword": confirmpassword,
    };

    http.post(
      Uri.parse("$url/customers"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    // .then((e) => {print(jsonDecode(e.body.message))});
  }
}
