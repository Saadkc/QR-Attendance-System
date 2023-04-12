import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'adminScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    present == 0;
  }

  DateTime now = DateTime.now();
  final firebase = FirebaseFirestore.instance;

  // var status = "In";
  var present = 0;

  // qr code data
  final date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  void _qrscanner() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var camerastatus = await Permission.camera.status; //check camera status

    try {
      if (camerastatus.isGranted) {
        String? qrData = await scanner.scan(); //this is open camera

        try {
          if (prefs.containsKey("status")) {
            String docId = prefs.getString("docId")!;
            firebase.collection("attendance").doc(docId).update({
              "LogOff-time": DateTime.now(),
              "Status": "LogOff"
            }).then((value) {
              prefs.clear();
              log("logoff");
            });
          } else {
            log("else");
            firebase.collection("attendance").add({
              "name": qrData,
              "LogIn-time": DateTime.now(),
              "Status": "LogIn"
            }).then((value) {
              prefs.setString("status", "LogIn");
              prefs.setString("docId", value.id);
              log("login");
            });
          }
        } catch (e) {
          log("2nd try catch $e");
        }
      } else {
        var isGrant = await Permission.camera.request();
        if (isGrant.isGranted) {
          String? qrData = await scanner.scan(); //this is open camera
          firebase
              .collection("attendance")
              .add({"name": qrData, "time": DateTime.now()}).then((value) {});
        }
      }
    } catch (e) {
      log("catch error : $e");
    }
  }

  // void _qrscanner() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   var camerastatus = await Permission.camera.status; //check camera status

  //   try {
  //     if (camerastatus.isGranted) {
  //       String? qrData = await scanner.scan(); //this is open camera
  //       log(qrData.toString());
  //       if (prefs.containsKey("status")) {
  //         String docId = prefs.getString("docId")!;
  //         DateTime loginTime =
  //             DateTime.parse(prefs.getString("loginTime").toString());
  //         DateTime logoutTime = DateTime.now();
  //         Duration diff = logoutTime.difference(loginTime);
  //         // int breakTime = diff.inMinutes - 540; // 540 minutes = 9 hours
  //         log(diff.toString());
  //         firebase.collection("attandance").doc(docId).update({
  //           "LogOff-time": logoutTime,
  //           "Status": "LogOff",
  //           //  "Break-time": breakTime
  //         }).then((value) {
  //           prefs.clear();
  //         });
  //       } else {
  //         DateTime loginTime = DateTime.now();
  //         firebase.collection("attandance").add({
  //           "name": qrData,
  //           "LogIn-time": loginTime,
  //           "Status": "LogIn"
  //         }).then((value) {
  //           prefs.setString("status", "LogIn");
  //           prefs.setString("docId", value.id);
  //           prefs.setString("loginTime", loginTime.toString());
  //         });
  //       }
  //     } else {
  //       var isGrant = await Permission.camera.request();
  //       if (isGrant.isGranted) {
  //         String? qrData = await scanner.scan(); //this is open camera
  //         firebase
  //             .collection("attandance")
  //             .add({"name": qrData, "time": DateTime.now()}).then((value) {});
  //       }
  //     }
  //   } catch (e) {
  //     log("error ${e.toString()}");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Scan Qr Code"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            width: Get.width * 0.7,
            height: Get.height * 0.3,
            decoration: const BoxDecoration(
                //  color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage("assets/office_logo.png"),
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CupertinoButton(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: const Text("Login as Admin"),
                  onPressed: () {
                    Get.to(const adminscreen());
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CupertinoButton(
                  color: Colors.blue,
                  child: const Text("Attandance"),
                  onPressed: () {
                    _qrscanner();
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}
