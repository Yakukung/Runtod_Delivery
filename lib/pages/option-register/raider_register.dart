import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:runtod_app/config/internal_config.dart';
import 'package:runtod_app/model/Request/RaiderRegisterPostRequest.dart';
import 'package:runtod_app/pages/login.dart';
import 'package:http/http.dart' as http;

class RaiderRegisterPage extends StatefulWidget {
  const RaiderRegisterPage({super.key});

  @override
  State<RaiderRegisterPage> createState() => _RaiderRegisterPageState();
}

class _RaiderRegisterPageState extends State<RaiderRegisterPage> {
  bool _obscureText = true;
  bool _obscureTextCF = true;
  String errorText = '';
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController fullnameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  TextEditingController confirmpasswordtCtl = TextEditingController();
  TextEditingController license_plateCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    log(isPortrait ? 'Portrait' : 'Landscape');
    double customPadding = isPortrait ? 35.0 : 70.0;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: 0, left: customPadding, right: customPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'ลงทะเบียน',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SukhumvitSet',
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                const Text(
                  'สร้างบัญชีใหม่สำหรับไรเดอร์ของคุณ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6C6C6C),
                    fontFamily: 'SukhumvitSet',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: usernameCtl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF1D1D1F),
                    hintText: 'ชื่อผู้ใช้',
                    hintStyle: const TextStyle(
                      fontFamily: 'SukhumvitSet',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF7B7B7C),
                    ),
                    prefixIcon: const Icon(Icons.person, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'SukhumvitSet',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: fullnameCtl,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF1D1D1F),
                    hintText: 'ชื่อ-สกุล',
                    hintStyle: const TextStyle(
                      fontFamily: 'SukhumvitSet',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF7B7B7C),
                    ),
                    prefixIcon: const Icon(Icons.person, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'SukhumvitSet',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: emailCtl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF1D1D1F),
                    hintText: 'อีเมล',
                    hintStyle: const TextStyle(
                      fontFamily: 'SukhumvitSet',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF7B7B7C),
                    ),
                    prefixIcon: const Icon(Icons.email, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'SukhumvitSet',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: phoneCtl,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF1D1D1F),
                    hintText: 'โทรศัพท์',
                    hintStyle: const TextStyle(
                      fontFamily: 'SukhumvitSet',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF7B7B7C),
                    ),
                    prefixIcon:
                        const Icon(Icons.phone_iphone, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'SukhumvitSet',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordCtl,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF1D1D1F),
                    hintText: 'รหัสผ่าน',
                    hintStyle: const TextStyle(
                      fontFamily: 'SukhumvitSet',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF7B7B7C),
                    ),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'SukhumvitSet',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: confirmpasswordtCtl,
                  obscureText: _obscureTextCF,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF1D1D1F),
                    hintText: 'ยืนยันรหัสผ่าน',
                    hintStyle: const TextStyle(
                      fontFamily: 'SukhumvitSet',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF7B7B7C),
                    ),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureTextCF
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: _toggleCFPasswordVisibility,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'SukhumvitSet',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: license_plateCtl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF1D1D1F),
                    hintText: 'ทะเบียนรถ',
                    hintStyle: const TextStyle(
                      fontFamily: 'SukhumvitSet',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF7B7B7C),
                    ),
                    prefixIcon:
                        const Icon(Icons.motorcycle, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'SukhumvitSet',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: _Register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF92A47),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'ยืนยันการลงทะเบียน',
                    style: TextStyle(
                      fontFamily: 'SukhumvitSet',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
      print('Password visibility toggled: $_obscureText');
    });
  }

  void _toggleCFPasswordVisibility() {
    setState(() {
      _obscureTextCF = !_obscureTextCF;
      print('Confirm password visibility toggled: $_obscureTextCF');
    });
  }

  Future<void> _Register() async {
    log('username: ${usernameCtl.text}');
    log('fullname: ${fullnameCtl.text}');
    log('email: ${emailCtl.text}');
    log('phone: ${phoneCtl.text}');
    log('password: ${passwordCtl.text}');
    log('confrimpass: ${confirmpasswordtCtl.text}');
    log('license_plate: ${license_plateCtl.text}');

    // ตรวจสอบว่าข้อมูลว่างหรือมีช่องว่าง
    if (usernameCtl.text.trim().isEmpty ||
        fullnameCtl.text.trim().isEmpty ||
        emailCtl.text.trim().isEmpty ||
        phoneCtl.text.trim().isEmpty ||
        passwordCtl.text.trim().isEmpty ||
        license_plateCtl.text.trim().isEmpty ||
        confirmpasswordtCtl.text.trim().isEmpty) {
      _showErrorSnackbar(
          'สร้างบัญชีไม่สำเร็จ!', 'กรุณาป้อนข้อมูลให้ครบทุกช่อง');
      return;
    }

    // ตรวจสอบว่าหมายเลขโทรศัพท์มีความยาว 10 หลัก
    if (phoneCtl.text.trim().length != 10) {
      _showErrorSnackbar(
          'หมายเลขโทรศัพท์ไม่ถูกต้อง!', 'กรุณากรอกหมายเลขโทรศัพท์ 10 หลัก');
      return;
    }

    // ตรวจสอบว่ารหัสผ่านตรงกัน
    if (confirmpasswordtCtl.text.trim() != passwordCtl.text.trim()) {
      _showErrorSnackbar('รหัสผ่านไม่ตรงกัน!', 'กรุณากรอกรหัสผ่านให้ตรงกัน');
      return;
    }

    // ตรวจสอบว่าอีเมลมีรูปแบบที่ถูกต้อง
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(emailCtl.text.trim())) {
      _showErrorSnackbar('อีเมลไม่ถูกต้อง!', 'กรุณากรอกอีเมลให้ถูกต้อง');
      return;
    }

    var data = RaiderRegisterPostRequest(
      username: usernameCtl.text.trim(),
      fullname: fullnameCtl.text.trim(),
      email: emailCtl.text.trim(),
      phone: phoneCtl.text.trim(),
      password: passwordCtl.text.trim(),
      license_plate: license_plateCtl.text.trim(),
    );
    log('Sending data: ${jsonEncode(data.toJson())}');

    try {
      var response = await http.post(
        Uri.parse('$API_ENDPOINT/register/raider'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode(data.toJson()),
      );
      log('Status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Get.snackbar(
          '',
          '',
          titleText: Text(
            'สร้างบัญชีสำเร็จ!',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'SukhumvitSet'),
          ),
          messageText: Text(
            'คุณสร้างบัญชีคุณสำเร็จแล้ว',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: 'SukhumvitSet'),
          ),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.blue,
          margin: EdgeInsets.all(30),
          borderRadius: 22,
        );
        Get.to(() => LoginPage());
      } else {
        var responseData = jsonDecode(response.body);
        log('Response data: $responseData');
        String errorMessage = _getErrorMessage(responseData);
        _showErrorSnackbar('ไม่สามารถลงทะเบียนได้!', errorMessage);
      }
    } catch (e) {
      log('Error: $e');
      _showErrorSnackbar(
          'สร้างบัญชีไม่สำเร็จ!', 'ไม่สามารถลงทะเบียนได้ ลองใหม่อีกครั้ง');
    }
  }

  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'SukhumvitSet'),
      ),
      messageText: Text(
        message,
        style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'SukhumvitSet'),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Color(0xFFF92A47),
      margin: EdgeInsets.all(30),
      borderRadius: 22,
    );
  }

  String _getErrorMessage(Map<String, dynamic> responseData) {
    String errorMessage = 'ไม่สามารถลงทะเบียนได้ ลองใหม่อีกครั้ง';

    if (responseData.containsKey('error')) {
      String errorType = responseData['error'];

      if (errorType.contains('UNIQUE constraint failed')) {
        if (errorType.contains('users.username')) {
          errorMessage = 'ชื่อผู้ใช้นี้มีการใช้งานอยู่แล้ว';
        } else if (errorType.contains('users.email')) {
          errorMessage = 'อีเมลนี้มีการใช้งานอยู่แล้ว';
        } else if (errorType.contains('users.phone')) {
          errorMessage = 'หมายเลขโทรศัพท์นี้มีการใช้งานอยู่แล้ว';
        } else if (errorType.contains('users.license_plate')) {
          errorMessage = 'ทะเบียนรถนี้มีการใช้งานอยู่แล้ว';
        }
      }
    }
    return errorMessage;
  }
}
