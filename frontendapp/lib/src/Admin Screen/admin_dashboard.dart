import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../NeWemployeesignInscreen.dart';
import '../home/homescreen.dart';
import '../searchEmployee.dart';


class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // final _auth = FirebaseAuth.instance;
  void signout() async {
    // await _auth.signOut();
    Get.to(const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
              onPressed: () {
                signout();
              },
              icon: const Icon(Icons.logout))
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
                  Get.to(const searchEmployee());
                },
                child: const Card(
                  elevation: 10,
                  child: Center(
                      child: Text(
                        "Serach for\n Attandance",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Card(
                  elevation: 10,
                  child: Center(
                    child: Text("All employee",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(const newEmployeeSignIN()),
                child: const Card(
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
