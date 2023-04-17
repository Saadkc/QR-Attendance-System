import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/auth/login.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  // final _auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    "assets/office_logo.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                        hintText: "Email",
                        suffixIcon: Icon(CupertinoIcons.person),
                        border: OutlineInputBorder()),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Email cannot be empty";
                          }
                          return null;
                        },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: "Password",
                        suffixIcon: Icon(CupertinoIcons.lock),
                        border: OutlineInputBorder()),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Password cannot be empty";
                          }
                          return null;
                        },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                      color: Colors.blue,
                      child: const Text("Login"),
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          signIn(email.text, password.text);
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
