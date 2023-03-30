import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'binding/init_bindings.dart';
import 'home_screen.dart';

void main() async {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      initialBinding: InitBinding(),
      home: const HomeScreen(),
    ),
  );
}
