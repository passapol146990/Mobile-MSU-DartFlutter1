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
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "อันซันสวิตเซอร์แลนด์",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            "https://static.amarintv.com/media/PJVlR0ljpN93yYFmwUH51mKzCj3KBj8f2mmG5zgiD3WqoM122Suv7ej6dCIKDeEKrL.jpg",
                            width: 150,
                            height: 100,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return SizedBox(
                                width: 150,
                                height: 100,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value:
                                        loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress
                                                  .expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return SizedBox(
                                width: 150,
                                height: 100,
                                child: Icon(Icons.error, color: Colors.red),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("ประเทศไทย", style: TextStyle(fontSize: 16)),
                              const SizedBox(height: 4),
                              Text(
                                "ระยะเวลา 10 วัน",
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "ราคา 90,000 บาท",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[700],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: FilledButton(
                                  onPressed: () {},
                                  style: FilledButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text("รายละเอียดเพิ่มเติม"),
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
          ),
        ],
      ),
    );
  }
}
