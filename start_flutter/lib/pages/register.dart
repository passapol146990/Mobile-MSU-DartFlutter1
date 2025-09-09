import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:start_flutter/pages/login.dart';
import 'package:start_flutter/services/APIService.dart';

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
                      TextInputType.text,
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
    String fullname,
    String phone,
    String email,
    String password,
    String confirmpassword,
  ) async {
    final response = await ApiService().register(
      fullname,
      phone,
      email,
      password,
      confirmpassword,
    );

    final status = response.status;
    final message = response.message;

    if (!context.mounted) return;

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: status == 200 ? Colors.green : Colors.red,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    if (status == 200) {
      Get.offAll(() => const LoginPage());
    }
  }
}
