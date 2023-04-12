import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: must_be_immutable
class MiniHome extends StatelessWidget {
  MiniHome({super.key});

  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomeScreen"),
        centerTitle: true,
      ),
      body: Column(
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
              SharedPreferences.getInstance().then((value) {
                value.setString("name", name.text);
              });
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}