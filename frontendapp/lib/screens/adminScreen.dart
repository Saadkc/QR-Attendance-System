import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'adminDashboard.dart';


class adminscreen extends StatefulWidget {
  const adminscreen({super.key});

  @override
  State<adminscreen> createState() => _adminscreenState();
}

class _adminscreenState extends State<adminscreen> {
  final _auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  login() async {
    // trim() spaces khtm krdeta he
    String _email = email.text.trim();
    String pass = password.text.trim();

    if (_email == '' || pass == '') {
      print("please filled all the fileds");
    } else {
      try {
        print("tryyyyyyyyyyyyyyyyyyyyyyyy");
        // user signin krega email or pass se
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: pass);
        //agr email or pass empty nh hue to ye condition lgegi
        if (userCredential != null) {
          Get.snackbar("Congratz", "you are sucessfully login",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.blue);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => admindashboard()));
          print("login");
        }
      } on FirebaseAuthException catch (ex) {
        Get.snackbar("Error",ex.code.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent);
        print(ex.code.toString());
      }
    }
  }

  void signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: "fahad2001@gmail.com", password: "fahad2001");
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADMIN"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => signUp()),
        child: Icon(Icons.person),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      hintText: "Email",
                      suffixIcon: Icon(CupertinoIcons.person),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(

                      hintText: "Password",
                      suffixIcon: Icon(CupertinoIcons.lock),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoButton(
                    color: Colors.blue,
                    child: Text("Login"),
                    onPressed: () {
                      login();
                      // Get.snackbar("Message", "This button is working",
                      // snackPosition: SnackPosition.BOTTOM,
                      // backgroundColor: Colors.blue);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
