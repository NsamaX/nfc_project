// Figma: https://www.figma.com/design/XXe4eUS6hs0ECBIo2CLMPG/Project?node-id=0-1&t=QsAlRDSO3bLKm2F5-0
import 'package:flutter/material.dart';
import 'package:nfc_project/theme.dart';
import 'package:nfc_project/screen/section0/introduction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: themeData(),
      home: const IntroductionScreen(),
    );
  }
}
