import 'dart:developer';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:runtod_app/config/internal_config.dart';
import 'package:runtod_app/model/Request/RaiderRegisterPostRequest.dart';
import 'package:runtod_app/pages/login.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

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

  File? _image;
  final picker = ImagePicker();
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _isCameraReady = false;
  List<CameraDescription> cameras = [];
  bool _isRearCameraSelected = true;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
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
                GestureDetector(
                  onTap: _showImageSourceActionSheet,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? const Icon(Icons.add_a_photo,
                            size: 40, color: Colors.white)
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

  void showSnackbar(String title, String message,
      {Color backgroundColor = Colors.blue}) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'SukhumvitSet',
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontFamily: 'SukhumvitSet',
        ),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(30),
      borderRadius: 22,
    );
  }

  Future<void> _Register() async {
    // ตรวจสอบว่าข้อมูลว่างหรือมีช่องว่าง
    if (usernameCtl.text.trim().isEmpty ||
        fullnameCtl.text.trim().isEmpty ||
        emailCtl.text.trim().isEmpty ||
        phoneCtl.text.trim().isEmpty ||
        license_plateCtl.text.trim().isEmpty ||
        passwordCtl.text.trim().isEmpty ||
        confirmpasswordtCtl.text.trim().isEmpty) {
      showSnackbar(
        'สร้างบัญชีไม่สำเร็จ!',
        'กรุณาป้อนข้อมูลให้ครบทุกช่อง',
        backgroundColor: const Color(0xFFF92A47),
      );
      return;
    }

    if (_image == null) {
      showSnackbar(
        'สร้างบัญชีไม่สำเร็จ!',
        'กรุณาเลือกภาพโปรไฟล์',
        backgroundColor: const Color(0xFFF92A47),
      );
      return;
    }

    // ตรวจสอบว่าหมายเลขโทรศัพท์มีความยาว 10 หลัก
    if (phoneCtl.text.trim().length != 10) {
      showSnackbar(
          'หมายเลขโทรศัพท์ไม่ถูกต้อง!', 'กรุณากรอกหมายเลขโทรศัพท์ 10 หลัก',
          backgroundColor: const Color(0xFFF92A47));
      return;
    }

    // ตรวจสอบว่ารหัสผ่านตรงกัน
    if (confirmpasswordtCtl.text.trim() != passwordCtl.text.trim()) {
      showSnackbar('รหัสผ่านไม่ตรงกัน!', 'กรุณากรอกรหัสผ่านให้ตรงกัน',
          backgroundColor: const Color(0xFFF92A47));
      return;
    }

    // ตรวจสอบว่าอีเมลมีเครื่องหมาย @
    if (!emailCtl.text.trim().contains('@')) {
      showSnackbar('อีเมลไม่ถูกต้อง!', 'กรุณากรอกอีเมลให้ถูกต้อง',
          backgroundColor: const Color(0xFFF92A47));
      return;
    }

    String? imageUrl;
    if (_image != null) {
      String phone = phoneCtl.text.trim();
      imageUrl = await uploadImageToFirebase(phone, _image!);
      if (imageUrl == null) {
        showSnackbar('สร้างบัญชีไม่สำเร็จ!', 'ไม่สามารถอัปโหลดรูปภาพได้!');
        return;
      }
    }

    var data = RiderRegisterPostRequest(
      username: usernameCtl.text.trim(),
      fullname: fullnameCtl.text.trim(),
      email: emailCtl.text.trim(),
      phone: phoneCtl.text.trim(),
      license_plateCtl: license_plateCtl.text.trim(),
      password: passwordCtl.text.trim(),
      image_profile: imageUrl ?? '',
    );
    log('Sending data: ${jsonEncode(data.toJson())}');

    try {
      var response = await http.post(
        Uri.parse('$API_ENDPOINT/register/rider'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode(data.toJson()),
      );
      log('Status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        showSnackbar('สร้างบัญชีสำเร็จ!', 'คุณสร้างบัญชีคุณสำเร็จแล้ว',
            backgroundColor: Colors.blue);
        Get.to(() => const LoginPage());
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
            backgroundColor: const Color(0xFFF92A47));
      }
    } catch (e) {
      log('Error: $e');
      showSnackbar(
          'สร้างบัญชีไม่สำเร็จ!', 'ไม่สามารถลงทะเบียนได้ ลองใหม่อีกครั้ง',
          backgroundColor: const Color(0xFFF92A47));
    }
  }

  Future<String?> uploadImageToFirebase(String uid, File imageFile) async {
    try {
      // ตรวจสอบขนาดไฟล์
      final int fileSizeInBytes = await imageFile.length();
      if (fileSizeInBytes > 5 * 1024 * 1024) {
        // จำกัดขนาด 5MB
        debugPrint('File size too large: ${fileSizeInBytes / 1024 / 1024} MB');
        return null;
      }

      // ตรวจสอบนามสกุลไฟล์
      final String extension = path.extension(imageFile.path).toLowerCase();
      if (!['.jpg', '.jpeg', '.png'].contains(extension)) {
        debugPrint('Invalid file type: $extension');
        return null;
      }

      try {
        final String fileName =
            DateTime.now().millisecondsSinceEpoch.toString();
        final Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images/$uid/$fileName');

        final UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);

        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          debugPrint(
              'Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
        }, onError: (e) {
          debugPrint('Upload error: $e');
        });

        final TaskSnapshot taskSnapshot = await uploadTask;
        final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        debugPrint('Upload successful. Download URL: $downloadUrl');
        return downloadUrl;
      } catch (e) {
        debugPrint('Error in uploadImageToFirebase: $e');
        return null;
      }
    } catch (e) {
      debugPrint('Error in uploadImageToFirebase: $e');
      return null;
    }
  }

  Future<void> getImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        print("Image selected: ${_image!.path}");
      } else {
        print('ไม่ได้เลือกรูปภาพ');
      }
    } catch (e) {
      print('Error in getImage: $e');
      _showSnackbar('Error', 'Failed to access gallery. Please try again.');
    }
  }

  void _showImageSourceActionSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'เลือกแหล่งที่มาของรูปภาพ',
          style: TextStyle(
            fontFamily: 'SukhumvitSet',
          ),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text(
              'คลังรูปภาพ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'SukhumvitSet',
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              getImage(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'กล้องถ่ายภาพ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'SukhumvitSet',
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              _showCameraPreview();
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            'ยกเลิก',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'SukhumvitSet',
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    final firstCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller!.initialize();
    _initializeControllerFuture!.then((_) {
      setState(() {
        _isCameraReady = true;
      });
    });
  }

  void _toggleCameraFacing() async {
    _isRearCameraSelected = !_isRearCameraSelected;
    final newCamera = cameras.firstWhere(
      (camera) => _isRearCameraSelected
          ? camera.lensDirection == CameraLensDirection.back
          : camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    Navigator.of(context).pop();
    await _initializeCameraController(newCamera);

    _showCameraPreview();
  }

  Future<void> _initializeCameraController(
      CameraDescription cameraDescription) async {
    if (_controller != null) {
      await _controller!.dispose();
    }
    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller!.initialize();

    if (mounted) {
      setState(() {
        _isCameraReady = true;
      });
    }
  }

  Future<void> _takePicture() async {
    if (!_isCameraReady) return;
    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();

      if (!_isRearCameraSelected) {
        final originalImage =
            img.decodeImage(await File(image.path).readAsBytes());
        final flippedImage = img.flipHorizontal(originalImage!);
        final newPath = '${image.path}_flipped.jpg';
        await File(newPath).writeAsBytes(img.encodeJpg(flippedImage));

        setState(() {
          _image = File(newPath);
        });
      } else {
        setState(() {
          _image = File(image.path);
        });
      }

      Navigator.pop(context);
    } catch (e) {
      print(e);
      _showSnackbar('Error', 'Failed to take picture. Please try again.');
    }
  }

  void _showCameraPreview() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 300,
            height: 300,
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Transform.scale(
                          scaleX: _isRearCameraSelected ? 1 : -1,
                          child: CameraPreview(_controller!),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          icon: Icon(
                            _isRearCameraSelected
                                ? Icons.camera_front
                                : Icons.camera_rear,
                            color: Colors.white,
                          ),
                          onPressed: _toggleCameraFacing,
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: _takePicture,
              child: const Text(
                'ถ่ายภาพ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SukhumvitSet',
                ),
              ),
            ),
            TextButton(
              child: const Text(
                'ยกเลิก',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SukhumvitSet',
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showSnackbar(String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title: $message')),
    );
  }
}
