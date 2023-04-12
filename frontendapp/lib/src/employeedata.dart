// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class employyedataScareen extends StatefulWidget {
  String pic;
  String id;
  String first_name;
  String last_name;
  String age;
  String designation;
  String joining_date;
  String qualification;
  String shift_time;
  employyedataScareen(
      {required this.id,
        required this.pic,
        required this.first_name,
        required this.last_name,
        required this.age,
        required this.designation,
        required this.joining_date,
        required this.qualification,
        required this.shift_time,
        super.key});

  @override
  State<employyedataScareen> createState() => _employyedataScareenState();
}

class _employyedataScareenState extends State<employyedataScareen> {
  // var first_name = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Employee Data"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(CupertinoIcons.backward)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.pic),
                  backgroundColor: Colors.cyan,
                  radius: 80,
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 110, vertical: 20),
                child: Text(
                  widget.first_name + " " + widget.last_name,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text("age : ${widget.age}"),
              Text("qualification : ${widget.qualification}"),
              Text("designation : ${widget.designation}"),
              Text("Joining Date : ${widget.joining_date}"),
              Text("Shift time : ${widget.shift_time}"),
            ],
          ),
        ));
  }
}
