import 'package:flutter/material.dart';

class ShowtripPage extends StatefulWidget {
  const ShowtripPage({super.key});

  @override
  State<ShowtripPage> createState() => _ShowtripPageState();
}

class _ShowtripPageState extends State<ShowtripPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<String> zone = ["ทั้งหมด", "เอเชีย", "ยุโรป", "อาเซียน", "ไทย"];

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
      body: Column(
        children: [
          Column(
            children: [
              Row(children: [Text("ปลายทาง")]),
            ],
          ),
          Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: zone.map((item) {
                    return FilledButton(
                      onPressed: () {},
                      child: Text(item.toString()),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(children: [Text("อันซันสวิตเซอร์แลนด์")]),
                Row(
                  children: [
                    Image.network(
                      width: 150,
                      "https://static.amarintv.com/media/PJVlR0ljpN93yYFmwUH51mKzCj3KBj8f2mmG5zgiD3WqoM122Suv7ej6dCIKDeEKrL.jpg",
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [Text("ประเทศไทย")],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [Text("ระยะเวลา 10 วัน")],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [Text("ราคา 90,000 บาท")],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                              onPressed: () {},
                              child: Text("รายละเอียดเพิ่มเติม"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
