import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:officeproject/src/home/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: must_be_immutable
class MiniHome extends StatelessWidget {
  MiniHome({super.key});

  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("HomeScreen"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 40,
            
            ),
            ElevatedButton(
              onPressed: () {
                if(name.text != ""){
                SharedPreferences.getInstance().then((value) {
                  value.setString("name", name.text);
                  Get.off(const HomePage());
                });
                }else{
                  Get.snackbar("Error", "Please enter your name",
                  snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}