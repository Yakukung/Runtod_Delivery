import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:runtod_app/config/internal_config.dart';
import 'package:runtod_app/model/Request/UsersRegisterPostRequest.dart';
import 'package:runtod_app/pages/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage>
    with WidgetsBindingObserver {
  bool _obscureText = true;
  bool _obscureTextCF = true;
  String errorText = '';
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController fullnameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  TextEditingController confirmpasswordtCtl = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        log("Image selected: ${_image!.path}");
      } else {
        print('ไม่ได้เลือกรูปภาพ');
      }
    } catch (e) {
      print('Error in getImage: $e');
      showSnackbar('Error', 'Failed to access gallery. Please try again.');
    }
  }

  Future<String?> uploadImageToFirebase(String uid, File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('profile_images/$uid/$fileName');

      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void _showImageSourceActionSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('เลือกแหล่งที่มาของรูปภาพ'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text('คลังรูปภาพ'),
            onPressed: () {
              Navigator.pop(context);
              getImage(ImageSource.gallery);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('ยกเลิก'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

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
                top: 30, left: customPadding, right: customPadding),
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
                  'สร้างบัญชีใหม่สำหรับผู้ใช้ระบบของคุณ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6C6C6C),
                    fontFamily: 'SukhumvitSet',
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _showImageSourceActionSheet,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? Icon(Icons.add_a_photo, size: 40, color: Colors.white)
                        : null,
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

  void showSnackbar(String title, String message,
      {Color backgroundColor = Colors.blue}) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'SukhumvitSet',
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontFamily: 'SukhumvitSet',
        ),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      margin: EdgeInsets.all(30),
      borderRadius: 22,
    );
  }

  Future<void> _Register() async {
    log('username: ${usernameCtl.text}');
    log('fullname: ${fullnameCtl.text}');
    log('email: ${emailCtl.text}');
    log('phone: ${phoneCtl.text}');
    log('password: ${passwordCtl.text}');
    log('confrimpass: ${confirmpasswordtCtl.text}');

    // ตรวจสอบว่าข้อมูลว่างหรือมีช่องว่าง
    if (usernameCtl.text.trim().isEmpty ||
        fullnameCtl.text.trim().isEmpty ||
        emailCtl.text.trim().isEmpty ||
        phoneCtl.text.trim().isEmpty ||
        passwordCtl.text.trim().isEmpty ||
        confirmpasswordtCtl.text.trim().isEmpty) {
      showSnackbar('สร้างบัญชีไม่สำเร็จ!', 'กรุณาป้อนข้อมูลให้ครบทุกช่อง',
          backgroundColor: Color(0xFFF92A47));
      return;
    }

    // ตรวจสอบว่าหมายเลขโทรศัพท์มีความยาว 10 หลัก
    if (phoneCtl.text.trim().length != 10) {
      showSnackbar(
          'หมายเลขโทรศัพท์ไม่ถูกต้อง!', 'กรุณากรอกหมายเลขโทรศัพท์ 10 หลัก',
          backgroundColor: Color(0xFFF92A47));
      return;
    }

    // ตรวจสอบว่ารหัสผ่านตรงกัน
    if (confirmpasswordtCtl.text.trim() != passwordCtl.text.trim()) {
      showSnackbar('รหัสผ่านไม่ตรงกัน!', 'กรุณากรอกรหัสผ่านให้ตรงกัน',
          backgroundColor: Color(0xFFF92A47));
      return;
    }

    // ตรวจสอบว่าอีเมลมีเครื่องหมาย @
    if (!emailCtl.text.trim().contains('@')) {
      showSnackbar('อีเมลไม่ถูกต้อง!', 'กรุณากรอกอีเมลให้ถูกต้อง',
          backgroundColor: Color(0xFFF92A47));
      return;
    }

    String? imageUrl;
    if (_image != null) {
      String uid = usernameCtl.text.trim();
      imageUrl = await uploadImageToFirebase(uid, _image!);
      if (imageUrl == null) {
        showSnackbar('สร้างบัญชีไม่สำเร็จ!', 'ไม่สามารถอัปโหลดรูปภาพได้!');
        return;
      }
    }

    var data = UsersRegisterPostRequest(
      username: usernameCtl.text.trim(),
      fullname: fullnameCtl.text.trim(),
      email: emailCtl.text.trim(),
      phone: phoneCtl.text.trim(),
      password: passwordCtl.text.trim(),
      profileImage: imageUrl ?? '',
    );
    log('Sending data: ${jsonEncode(data.toJson())}');

    try {
      var response = await http.post(
        Uri.parse('$API_ENDPOINT/register/user'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode(data.toJson()),
      );
      log('Status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        showSnackbar('สร้างบัญชีสำเร็จ!', 'คุณสร้างบัญชีคุณสำเร็จแล้ว',
            backgroundColor: Colors.blue);
        Get.to(() => LoginPage());
      } else {
        var responseData = jsonDecode(response.body);
        log('Response data: $responseData');

        String errorMessage = 'ไม่สามารถลงทะเบียนได้ ลองใหม่อีกครั้ง';

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('error')) {
          String errorType = responseData['error'];

          if (errorType.contains('UNIQUE constraint failed')) {
            if (errorType.contains('users.username')) {
              errorMessage = 'ชื่อผู้ใช้นี้มีการใช้งานอยู่แล้ว';
            } else if (errorType.contains('users.email')) {
              errorMessage = 'อีเมลนี้มีการใช้งานอยู่แล้ว';
            } else if (errorType.contains('users.phone')) {
              errorMessage = 'หมายเลขโทรศัพท์นี้มีการใช้งานอยู่แล้ว';
            }
          }
        }

        showSnackbar('สร้างบัญชีไม่สำเร็จ!', errorMessage,
            backgroundColor: Color(0xFFF92A47));
      }
    } catch (e) {
      log('Error: $e');
      showSnackbar(
          'สร้างบัญชีไม่สำเร็จ!', 'ไม่สามารถลงทะเบียนได้ ลองใหม่อีกครั้ง',
          backgroundColor: Color(0xFFF92A47));
    }
  }
}
