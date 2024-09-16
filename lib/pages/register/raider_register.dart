import 'dart:developer';

import 'package:flutter/material.dart';

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
  TextEditingController confirmpasswordCtl = TextEditingController();
  TextEditingController numberPlateCtl = TextEditingController();

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
                  controller: confirmpasswordCtl,
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
                  controller: numberPlateCtl,
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
                  onPressed: _RaiderRegister,
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
      _obscureText = !_obscureText; // Update the state here
      print('Password visibility toggled: $_obscureText');
    });
  }

  void _toggleCFPasswordVisibility() {
    setState(() {
      _obscureTextCF = !_obscureTextCF; // Update the state here
      print('Confirm password visibility toggled: $_obscureTextCF');
    });
  }

  void _RaiderRegister() {}
}
