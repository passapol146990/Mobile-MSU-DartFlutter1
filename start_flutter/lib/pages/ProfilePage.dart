import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:start_flutter/services/APIService.dart';
import 'package:start_flutter/type/response/responseDUser.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<void> loadData;
  late ResponseDUser data;

  final _formKey = GlobalKey<FormState>();
  final _fullnameCtr = TextEditingController();
  final _phoneCtr = TextEditingController();
  final _emailCtr = TextEditingController();
  final _imageCtr = TextEditingController();

  bool _isEditing = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync();
  }

  @override
  void dispose() {
    _fullnameCtr.dispose();
    _phoneCtr.dispose();
    _emailCtr.dispose();
    _imageCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลส่วนตัว'),
        actions: [
          // ปุ่มสามจุด …
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'delete') _onDeleteUser();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, color: Colors.red),
                    SizedBox(width: 8),
                    Text('ลบผู้ใช้', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
          // ปุ่มแก้ไข/ยกเลิก
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'แก้ไข',
              onPressed: () => setState(() => _isEditing = true),
            )
          else
            IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'ยกเลิก',
              onPressed: () {
                _fillControllersFromData(); // ย้อนค่ากลับ
                setState(() => _isEditing = false);
              },
            ),
        ],
      ),
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
          }

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(64),
                    child: _imageCtr.text.isEmpty
                        ? Container(
                            width: 128,
                            height: 128,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.person, size: 64),
                          )
                        : Image.network(
                            _imageCtr.text,
                            width: 128,
                            height: 128,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 128,
                              height: 128,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.broken_image, size: 48),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    const Icon(Icons.badge_outlined, size: 18),
                    const SizedBox(width: 8),
                    Text('รหัสผู้ใช้: ${data.idx}'),
                  ],
                ),
                const SizedBox(height: 16),

                _buildText(
                  label: 'ชื่อ–นามสกุล',
                  ctr: _fullnameCtr,
                  enabled: _isEditing,
                  icon: Icons.person_outline,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'กรอกชื่อ' : null,
                ),
                _buildText(
                  label: 'เบอร์โทร',
                  ctr: _phoneCtr,
                  enabled: _isEditing,
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'กรอกเบอร์โทร';
                    if (v.length < 9) return 'เบอร์โทรไม่ถูกต้อง';
                    return null;
                  },
                ),
                _buildText(
                  label: 'อีเมล',
                  ctr: _emailCtr,
                  enabled: _isEditing,
                  icon: Icons.alternate_email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'กรอกอีเมล';
                    final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v);
                    return ok ? null : 'อีเมลไม่ถูกต้อง';
                  },
                ),
                _buildText(
                  label: 'รูปโปรไฟล์ (URL)',
                  ctr: _imageCtr,
                  enabled: _isEditing,
                  icon: Icons.image_outlined,
                  onChanged: (_) => setState(() {}), // พรีวิวรูปใหม่
                ),

                const SizedBox(height: 24),

                if (_isEditing)
                  SizedBox(
                    height: 48,
                    child: FilledButton.icon(
                      onPressed: _isSaving ? null : _onSave,
                      icon: _isSaving
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.save_outlined),
                      label: const Text('บันทึก'),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  // โหลดข้อมูลจาก API แล้วเติมลง form
  Future<void> loadDataAsync() async {
    data = await ApiService().getDUser();
    _fillControllersFromData();
  }

  void _fillControllersFromData() {
    _fullnameCtr.text = data.fullname;
    _phoneCtr.text = data.phone;
    _emailCtr.text = data.email;
    _imageCtr.text = data.image;
  }

  Widget _buildText({
    required String label,
    required TextEditingController ctr,
    bool enabled = true,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    IconData? icon,
    void Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: ctr,
        enabled: enabled,
        validator: validator,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon == null ? null : Icon(icon),
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: !enabled,
          fillColor: enabled ? null : Colors.grey.withOpacity(0.08),
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final payload = {
      "idx": data.idx,
      "fullname": _fullnameCtr.text.trim(),
      "phone": _phoneCtr.text.trim(),
      "email": _emailCtr.text.trim(),
      "image": _imageCtr.text.trim(),
    };

    await ApiService().UpdateUser(
      _fullnameCtr.text.trim(),
      _phoneCtr.text.trim(),
      _emailCtr.text.trim(),
      _imageCtr.text.trim(),
    );

    print("UPDATE USER PAYLOAD => ${jsonEncode(payload)}");

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('บันทึกข้อมูลเรียบร้อย (printed payload)'),
          backgroundColor: Colors.green,
        ),
      );
    }

    setState(() {
      _isSaving = false;
      _isEditing = false;
    });
  }

  Future<void> _onDeleteUser() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('ยืนยันการลบผู้ใช้'),
        content: Text('ต้องการลบผู้ใช้รหัส ${data.idx} ใช่ไหม?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('ยกเลิก'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('ลบ'),
          ),
        ],
      ),
    );

    if (ok != true) return;
    await ApiService().DeleteUser();

    print("DELETE USER REQUEST => {\"idx\": ${data.idx}}");

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ลบผู้ใช้ (printed request)'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
