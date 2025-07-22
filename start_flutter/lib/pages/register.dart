import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
  Padding _passapol_input(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.text,
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            _passapol_input("ชื่อ-นามสกุล"),
            _passapol_input("หมายเลขโทรศัพท์"),
            _passapol_input("อีเมล"),
            _passapol_input("รหัสผ่าน"),
            _passapol_input("ยืนยันรหัสผ่าน"),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
    );
  }
}
