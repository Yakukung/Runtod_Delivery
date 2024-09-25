import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:runtod_app/pages/intro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:runtod_app/pages/user/home/homeUser.dart';

Future<void> main() async {
  await GetStorage.init();

  final GetStorage storage = GetStorage();
  final int? uid = storage.read<int>('uid');
  final int? type = storage.read<int>('type');

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(MyApp(uid: uid, type: type));
}

class MyApp extends StatelessWidget {
  final int? uid;
  final int? type;

  const MyApp({super.key, this.uid, this.type});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'รันทด เดลิเวอรี่',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      home: _getHomePage(),
    );
  }

  Widget _getHomePage() {
    if (uid != null) {
      switch (type) {
        case 0:
        case 1:
          return HomeUserPage();
        default:
          return const IntroPage();
      }
    }
    return const IntroPage();
  }
}
