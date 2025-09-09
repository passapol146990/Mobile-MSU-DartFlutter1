// lib/services/auth_service.dart
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// -------------------- Models --------------------
class Customer {
  final int idx;
  final String fullname;
  final String phone;
  final String email;
  final String image;

  Customer({
    required this.idx,
    required this.fullname,
    required this.phone,
    required this.email,
    required this.image,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    idx: json['idx'],
    fullname: json['fullname'] ?? '',
    phone: json['phone'] ?? '',
    email: json['email'] ?? '',
    image: json['image'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'idx': idx,
    'fullname': fullname,
    'phone': phone,
    'email': email,
    'image': image,
  };
}

class AuthSession {
  final int status; // 200=success, อื่นๆ=error
  final String message;
  final Customer customer;

  AuthSession({
    required this.status,
    required this.message,
    required this.customer,
  });

  factory AuthSession.fromJson(Map<String, dynamic> json) => AuthSession(
    status: json['status'],
    message: json['message'] ?? '',
    customer: Customer.fromJson(json['customer'] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'customer': customer.toJson(),
  };
}

/// -------------------- Service --------------------
class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  static const _prefsKey = 'auth_session_v1';

  AuthSession? _session;
  final _authController = StreamController<AuthSession?>.broadcast();

  /// ใช้ฟังสถานะ Login/Logout แบบเรียลไทม์
  Stream<AuthSession?> get onAuthStateChanged => _authController.stream;

  /// call ครั้งเดียวตอนเปิดแอป เพื่อโหลด session ที่เคยเก็บไว้
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw != null) {
      try {
        _session = AuthSession.fromJson(jsonDecode(raw));
      } catch (_) {
        // ถ้าแปลงพัง ให้เคลียร์ทิ้ง
        await prefs.remove(_prefsKey);
        _session = null;
      }
    }
    _authController.add(_session);
  }

  bool get isLoggedIn => _session != null;
  AuthSession? get session => _session;
  Customer? get currentUser => _session?.customer;

  /// เซฟ session หลังจาก login สำเร็จ
  Future<void> setSession(AuthSession session) async {
    _session = session;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, jsonEncode(session.toJson()));
    _authController.add(_session);
  }

  /// อัปเดตข้อมูลลูกค้า (เช่น เปลี่ยนรูป/ชื่อ) แล้วเซฟกลับ
  Future<void> updateCustomer(Customer newCustomer) async {
    if (_session == null) return;
    final updated = AuthSession(
      status: _session!.status,
      message: _session!.message,
      customer: newCustomer,
    );
    await setSession(updated);
  }

  /// ล็อกเอาท์ (ลบจากหน่วยความจำและดิสก์)
  Future<void> logout() async {
    _session = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
    _authController.add(null);
  }

  /// ปิดสตรีมเมื่อไม่ใช้แล้ว (ปกติไม่จำเป็น เรียกตอน dispose app)
  void dispose() {
    _authController.close();
  }
}
