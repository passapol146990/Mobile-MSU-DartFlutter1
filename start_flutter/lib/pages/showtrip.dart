import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:start_flutter/config/config.dart';
import 'package:start_flutter/model/response/TripsGetResponse.dart';

class CardTrip extends StatelessWidget {
  final String title;
  final String img;
  final String country;
  final int datetime;
  final int price;

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
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
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
                        Text(
                          datetime.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          price.toString(),
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

class ShowtripPage extends StatefulWidget {
  const ShowtripPage({super.key});

  @override
  State<ShowtripPage> createState() => _ShowtripPageState();
}

class _ShowtripPageState extends State<ShowtripPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<String> zone = ["ทั้งหมด", "เอเชีย", "ยุโรป", "อาเซียน", "ไทย"];
  List<TripsGetResponse> tripsGetResponse = [];

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

  String API_ENDPOINT = "";

  void getTrips() async {
    await Configuration.getConfig().then((config) {
      API_ENDPOINT = config['apiEndPoint'];
    });
    log("$API_ENDPOINT/trips");
    http.get(Uri.parse("$API_ENDPOINT/trips")).then((value) {
      log(value.body);
      setState(() {
        tripsGetResponse = tripsGetResponseFromJson(value.body);
        log(tripsGetResponse.length.toString());
      });
    });
  }

  // @override
  // void setState(VoidCallback fn) {
  // TODO: implement setState
  // super.setState(getTrips);
  // }

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
                    child: FilledButton(onPressed: getTrips, child: Text(item)),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: tripsGetResponse.map((e) {
                return CardTrip(
                  e.name,
                  e.coverimage,
                  e.country,
                  e.duration,
                  e.price,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
