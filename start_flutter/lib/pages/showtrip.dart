import 'package:flutter/material.dart';

class ShowtripPage extends StatefulWidget {
  const ShowtripPage({super.key});

  @override
  State<ShowtripPage> createState() => _ShowtripPageState();
}

class _ShowtripPageState extends State<ShowtripPage>
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รายการทริป")),
      body: Container(),
    );
  }
}
