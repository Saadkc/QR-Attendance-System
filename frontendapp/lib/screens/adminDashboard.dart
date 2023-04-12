import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'NeWemployeesignInscreen.dart';
import 'addemployee.dart';
import 'allemployee.dart';
import 'homescreen.dart';
import 'searchEmployee.dart';


class admindashboard extends StatefulWidget {
  const admindashboard({super.key});

  @override
  State<admindashboard> createState() => _admindashboardState();
}

class _admindashboardState extends State<admindashboard> {
  final _auth = FirebaseAuth.instance;
  void signout() async {
    await _auth.signOut();
    Get.to(HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Admin Dashboard"),
        actions: [
          IconButton(
              onPressed: () {
                signout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            shrinkWrap: true,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(searchEmployee());
                },
                child: Card(
                  elevation: 10,
                  child: Center(
                      child: Text(
                        "Serach for\n Attandance",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(allEmployeeScreen()),
                child: Card(
                  elevation: 10,
                  child: Center(
                    child: Text("All employee",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(newEmployeeSignIN()),
                child: Card(
                  elevation: 10,
                  child: Center(
                    child: Text("Add New \n employee",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
