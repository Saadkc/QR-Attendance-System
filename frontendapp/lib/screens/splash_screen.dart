import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'homescreen.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () {
      Get.to(HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height * 0.3,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/office_logo.png"),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
