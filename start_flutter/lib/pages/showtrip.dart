import 'package:flutter/material.dart';

// CardTrip StatelessWidget remains unchanged and is perfectly fine.
class CardTrip extends StatelessWidget {
  final String title;
  final String img;
  final String country;
  final String datetime;
  final String price;

  const CardTrip(
    this.title,
    this.img,
    this.country,
    this.datetime,
    this.price, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 15.0,
      ), // Adjust padding for vertical list
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
                title,
                style: const TextStyle(
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
                      img,
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
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
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
                        Text(country, style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(datetime, style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(
                          price,
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
                            onPressed: () {
                              // Handle button press, e.g., navigate to detail page
                              print("รายละเอียดเพิ่มเติมสำหรับ: $title");
                            },
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
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
    );
  }
}

// ShowtripPage (StatefulWidget)
class ShowtripPage extends StatefulWidget {
  const ShowtripPage({super.key});

  @override
  State<ShowtripPage> createState() => _ShowtripPageState();
}

class _ShowtripPageState extends State<ShowtripPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<String> zone = ["ทั้งหมด", "เอเชีย", "ยุโรป", "อาเซียน", "ไทย"];
  List<Map<String, String>> trips = [
    {
      "title": "อันซันสวิตเซอร์แลนด์",
      "img":
          "https://static.amarintv.com/media/PJVlR0ljpN93yYFmwUH51mKzCj3KBj8f2mmG5zgiD3WqoM122Suv7ej6dCIKDeEKrL.jpg",
      "country": "ประเทศไทย",
      "datetime": "ระยะเวลา 10 วัน",
      "price": "ราคา 90,000 บาท",
    },
    {
      "title": "ภูเขาไฟฟูจิ ญี่ปุ่น",
      "img":
          "https://static.amarintv.com/media/PJVlR0ljpN93yYFmwUH51mKzCj3KBj8f2mmG5zgiD3WqoM122Suv7ej6dCIKDeEKrL.jpg",
      "country": "ญี่ปุ่น",
      "datetime": "ระยะเวลา 7 วัน",
      "price": "ราคา 65,000 บาท",
    },
    {
      "title": "หอไอเฟล ปารีส",
      "img":
          "https://static.amarintv.com/media/PJVlR0ljpN93yYFmwUH51mKzCj3KBj8f2mmG5zgiD3WqoM122Suv7ej6dCIKDeEKrL.jpg",
      "country": "ฝรั่งเศส",
      "datetime": "ระยะเวลา 8 วัน",
      "price": "ราคา 120,000 บาท",
    },
    {
      "title": "อันซันสวิตเซอร์แลนด์",
      "img":
          "https://static.amarintv.com/media/PJVlR0ljpN93yYFmwUH51mKzCj3KBj8f2mmG5zgiD3WqoM122Suv7ej6dCIKDeEKrL.jpg",
      "country": "ประเทศไทย",
      "datetime": "ระยะเวลา 10 วัน",
      "price": "ราคา 90,000 บาท",
    },
    {
      "title": "ภูเขาไฟฟูจิ ญี่ปุ่น",
      "img":
          "https://static.amarintv.com/media/PJVlR0ljpN93yYFmwUH51mKzCj3KBj8f2mmG5zgiD3WqoM122Suv7ej6dCIKDeEKrL.jpg",
      "country": "ญี่ปุ่น",
      "datetime": "ระยะเวลา 7 วัน",
      "price": "ราคา 65,000 บาท",
    },
    {
      "title": "หอไอเฟล ปารีส",
      "img":
          "https://static.amarintv.com/media/PJVlR0ljpN93yYFmwUH51mKzCj3KBj8f2mmG5zgiD3WqoM122Suv7ej6dCIKDeEKrL.jpg",
      "country": "ฝรั่งเศส",
      "datetime": "ระยะเวลา 8 วัน",
      "price": "ราคา 120,000 บาท",
    },
  ];

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
      appBar: AppBar(
        title: const Text("รายการทริป"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 8.0,
            ),
            child: Text(
              "ปลายทาง",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: zone.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilledButton(onPressed: () {}, child: Text(item)),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: trips.map((item) {
                return CardTrip(
                  item["title"]!,
                  item["img"]!,
                  item["country"]!,
                  item["datetime"]!,
                  item["price"]!,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
