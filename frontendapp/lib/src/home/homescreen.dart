import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    present == 0;
  }

  DateTime now = DateTime.now();
  final firebase = FirebaseFirestore.instance;

  // var status = "In";
  var present = 0;

  // qr code data
  final date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  // void _qrscanner() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   var camerastatus = await Permission.camera.status; //check camera status

  //   try {
  //     if (camerastatus.isGranted) {
  //       String? qrData = await scanner.scan(); //this is open camera

  //       try {
  //         if (prefs.containsKey("status")) {
  //           String docId = prefs.getString("docId")!;
  //           firebase.collection("attendance").doc(docId).update({
  //             "LogOff-time": DateTime.now(),
  //             "Status": "LogOff"
  //           }).then((value) {
  //             prefs.clear();
  //             log("logoff");
  //           });
  //         } else {
  //           log("else");
  //           firebase.collection("attendance").add({
  //             "name": qrData,
  //             "LogIn-time": DateTime.now(),
  //             "Status": "LogIn"
  //           }).then((value) {
  //             prefs.setString("status", "LogIn");
  //             prefs.setString("docId", value.id);
  //             log("login");
  //           });
  //         }
  //       } catch (e) {
  //         log("2nd try catch $e");
  //       }
  //     } else {
  //       var isGrant = await Permission.camera.request();
  //       if (isGrant.isGranted) {
  //         String? qrData = await scanner.scan(); //this is open camera
  //         firebase
  //             .collection("attendance")
  //             .add({"name": qrData, "time": DateTime.now()}).then((value) {});
  //       }
  //     }
  //   } catch (e) {
  //     log("catch error : $e");
  //   }
  // }
  void getData() async {
    try {
      var response =
          await http.get(Uri.parse("http://192.168.0.219:3000/attendance"));
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print("error : $e");
    }
  }

  // void qrscanner() async {
  //   try {
  //     String? qrData = await scanner.scan();
  //     log(qrData.toString());
  //     var data = json.encode({
  //       "employeeName": qrData.toString(),
  //       "status": "Present",
  //       "checkInDate": DateTime.now().toString(),
  //       "checkOutDate": DateTime.now().toString()
  //     });
  //     var response = await http.post(
  //         Uri.parse("http://192.168.0.219:3000/attendance"),
  //         body: data,
  //         headers: {'Content-Type': 'application/json'});

  //     if (response.statusCode == 200) {
  //       // Request was successful, handle the response here
  //       log(response.body);
  //       var data = json.decode(response.body);
  //       var id = data["atten"]["_id"];
  //       log(id);
  //     } else {
  //       // Request failed, handle the error here
  //       log(response.statusCode.toString());
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  void checkbreak() async {
    log("checkbreak method");
    log('updated');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String loginTimeStr = prefs.getString("loginTime")!;
    String docId = prefs.getString("docId")!;
    DateTime currentTime = DateTime.now();
    Duration timeDifference =
        currentTime.difference(DateTime.parse(loginTimeStr));

    //  bool onBreak = prefs.getBool("breakStatus")!;
    // log("onbreak value : $onBreak");
    String? onBreak = prefs.getString("onbreak");
    log("docId $docId");
    //String breaktime = prefs.getString('breakCheckIn')!;
    try {
      log(onBreak.toString());
      // ignore: unnecessary_null_comparison
      if (onBreak == null) {
        var data = json.encode({
          "status": "break-CheckIn",
          // "breakCheckIn": breaktime.toString(),
          "breakCheckIn": DateTime.now().toString(),
          "checkInDate": loginTimeStr.toString()
        });
        await http.put(Uri.parse("http://192.168.0.219:3000/attendance/$docId"),
            body: data, headers: {'Content-Type': 'application/json'});

        // prefs.setBool("breakStatus", false);
        prefs.setString("onbreak", "yes");
        log("break check In");
        prefs.setString("breakCheckInTime", DateTime.now().toString());
      } else {
        log("You are already logged in!");
        log("Time difference since last login: ${timeDifference.inHours} hours ${timeDifference.inMinutes} minute");
        var data = json.encode({
          "status": "break-CheckOut",
          // "breakCheckIn": breaktime.toString(),
          "breakCheckOut": DateTime.now().toString(),
          "checkInDate": loginTimeStr.toString()
        });
        await http.put(Uri.parse("http://192.168.0.219:3000/attendance/$docId"),
            body: data,
            headers: {'Content-Type': 'application/json'}).then((value) {
          //prefs.setString("breakCheckIn", DateTime.now().toString());
        });
        log("break check out");
        prefs.setString("breakCheckOutTime", DateTime.now().toString());
      }
    } catch (e) {
      log('checkBreak method : $e');
    }
  }

  void markattendance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? qrData = await scanner.scan(); //this is open camera
    log("marked attendance method");
    try {
      if (prefs.containsKey("status")) {
        String docId = prefs.getString("docId")!;
        String loginTimeStr = prefs.getString("loginTime")!;

        DateTime currentTime = DateTime.now();
        Duration timeDifference =
            currentTime.difference(DateTime.parse(loginTimeStr));

        if (timeDifference.inHours < 9) {
          // prefs.setBool("breakStatus", true);
          checkbreak();
        } else {
          var data = json.encode({
            "status": "LogOff",
            "checkInDate": loginTimeStr.toString(),
            "checkOutDate": currentTime.toString()
          });
          await http.put(
              Uri.parse("http://192.168.0.219:3000/attendance/$docId"),
              body: data,
              headers: {'Content-Type': 'application/json'});

          log("logoff");
          prefs.clear();
        }
      } else {
        DateTime loginTime = DateTime.now();
        var data = json.encode({
          "employeeName": qrData.toString(),
          "status": "LogIn",
          "checkInDate": loginTime.toString(),
          "breakCheckIn": prefs.getString('breakCheckInTime'),
          "breakCheckOut": prefs.getString('breakCheckOutTime')
        });
        var response = await http.post(
            Uri.parse("http://192.168.0.219:3000/attendance"),
            body: data,
            headers: {'Content-Type': 'application/json'});
        var alp = json.decode(response.body);
        var id = alp["atten"]["_id"].toString();
        log(id);

        log("login");
        prefs.setString("status", "LogIn");
        prefs.setString("docId", id);
        prefs.setString("loginTime", loginTime.toString());
      }
    } catch (e) {
      log("markattendance : $e");
    }
  }

  void _qrscanner() async {
    var camerastatus = await Permission.camera.status; //check camera status

    try {
      if (camerastatus.isGranted) {
        markattendance();
      } else {
        await Permission.camera.request();
        markattendance();
      }
    } catch (e) {
      log("error ${e.toString()}");
    }
  }

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
                    // Get.to(const adminscreen());
                    getData();
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
                    // qrscanner();
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}
