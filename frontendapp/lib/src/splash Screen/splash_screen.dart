import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:officeproject/src/home/mini_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      if (value.containsKey("name")) {
        Timer(const Duration(seconds: 4), () {
          Get.to(const HomePage());
        });
      }else{
        Timer(const Duration(seconds: 4), () {
          Get.to(MiniHome());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height * 0.3,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/office_logo.png"),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
