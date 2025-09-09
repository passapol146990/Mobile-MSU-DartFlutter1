import 'package:flutter/material.dart';
import 'package:start_flutter/services/APIService.dart';
import 'package:start_flutter/type/response/responseDTrips.dart';

class TripPage extends StatefulWidget {
  final int idx;
  const TripPage({super.key, required this.idx});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  late ResponseDTrips data;
  late Future<void> loadData;

  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("รายละเอียดทริป")),
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // รูปปก
                Image.network(
                  data.coverimage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 220,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, size: 100),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ชื่อทริป
                      Text(
                        data.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // ประเทศ + โซน
                      Row(
                        children: [
                          const Icon(Icons.flag, size: 18, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text("${data.country} (${data.destinationZone})"),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // ราคา
                      Row(
                        children: [
                          const Icon(
                            Icons.attach_money,
                            size: 20,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${data.price} บาท",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // ระยะเวลา
                      Row(
                        children: [
                          const Icon(
                            Icons.timer,
                            size: 18,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 4),
                          Text("${data.duration} วัน"),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // รายละเอียด
                      const Text(
                        "รายละเอียดทริป",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(data.detail, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // โหลดข้อมูลจาก API
  Future<void> loadDataAsync() async {
    final response = await ApiService().getDTrips(widget.idx);
    data = response;
  }
}
