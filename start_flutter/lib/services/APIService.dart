import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:start_flutter/model/response/Responsetrips.dart';
import 'package:start_flutter/services/auth_service.dart';
import 'package:start_flutter/type/response/responseDTrips.dart';
import 'package:start_flutter/type/response/responseDUser.dart';
import 'package:start_flutter/type/response/response_a.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000';

  // static String? _token;

  // 👇 client ที่ข้ามการตรวจ SSL (dev only)
  static final HttpClient _httpClient = HttpClient()
    ..badCertificateCallback = (X509Certificate cert, String host, int port) =>
        true;

  static final IOClient _ioClient = IOClient(_httpClient);

  ApiService() {
    print("ApiService initialized with baseUrl: $baseUrl");
  }

  Future<ResponseA> register(
    fullname,
    phone,
    email,
    password,
    confirmpassword,
  ) async {
    if (password != confirmpassword) {
      return responseAFromJson(
        '{"status": 400, "message": "รหัสผ่านไม่ถูกต้อง"}',
      );
    }

    try {
      final response = await _ioClient.post(
        Uri.parse('$baseUrl/customers'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "fullname": fullname,
          "phone": phone,
          "email": email,
          "image": "",
          "password": password,
        }),
      );
      return responseAFromJson(response.body);
    } catch (err) {
      return responseAFromJson(
        '{"status": 400, "message": "เกิดข้อผิดพลาด ${err}"}',
      );
    }
  }

  Future<Map<String, dynamic>> login(String phone, String password) async {
    try {
      final res = await _ioClient.post(
        Uri.parse('$baseUrl/customers/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"phone": phone, "password": password}),
      );

      final Map<String, dynamic> map = jsonDecode(res.body);

      // ถ้า success → สร้าง AuthSession เก็บไว้
      if ((map['status'] ?? 400) == 200) {
        final session = AuthSession.fromJson(map);
        await AuthService.instance.setSession(session);
      }

      return map;
    } catch (e) {
      return {"status": 400, "message": "เกิดข้อผิดพลาด $e"};
    }
  }

  Future<List<Responsetrips>> getTrips() async {
    final response = await _ioClient.get(
      Uri.parse('$baseUrl/trips'),
      headers: {'Content-Type': 'application/json'},
    );

    // print(response.body);

    return responsetripsFromJson(response.body);
  }

  Future<ResponseDTrips> getDTrips(id) async {
    final response = await _ioClient.get(
      Uri.parse('$baseUrl/trips/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    // print(response.body);

    return responseDTripsFromJson(response.body);
  }

  Future<ResponseDUser> getDUser() async {
    final session = AuthService.instance.session;
    if (session != null) {
      print("ล็อกอินแล้ว: ${session.customer.idx}");
    } else {
      print("ยังไม่ได้ล็อกอิน");
    }

    final response = await _ioClient.get(
      Uri.parse('$baseUrl/customers/${session?.customer.idx}'),
      headers: {'Content-Type': 'application/json'},
    );

    print(response.body);

    return responseDUserFromJson(response.body);
  }

  Future DeleteUser() async {
    final session = AuthService.instance.session;
    if (session != null) {
      print("ล็อกอินแล้ว: ${session.customer.idx}");
    } else {
      print("ยังไม่ได้ล็อกอิน");
    }

    final response = await _ioClient.delete(
      Uri.parse('$baseUrl/customers/${session?.customer.idx}'),
      headers: {'Content-Type': 'application/json'},
    );

    print(response.body);

    return true;
  }

  Future UpdateUser(fullname, phone, email, image) async {
    final session = AuthService.instance.session;
    if (session != null) {
      print("ล็อกอินแล้ว: ${session.customer.idx}");
    } else {
      print("ยังไม่ได้ล็อกอิน");
    }

    final response = await _ioClient.put(
      Uri.parse('$baseUrl/customers/${session?.customer.idx}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "fullname": fullname,
        "phone": phone,
        "email": email,
        "image": image,
      }),
    );

    print(response.body);

    return true;
  }
}
