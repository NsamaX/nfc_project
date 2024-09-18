import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/theme.dart';
import 'package:project/screen/signin.dart';

void main() {
  // ล็อกการหมุนหน้าจอให้เป็นแนวตั้งทุกหน้า
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true, // แอปอยู่ในช่วงกำลังพัฒนา
      theme: themeData(),
      home: const ScreenWelcome(),
      //   home: const Scaffold(
      //     body: Center(child: Text('hello world')),
      //   ),
    );
  }
}
