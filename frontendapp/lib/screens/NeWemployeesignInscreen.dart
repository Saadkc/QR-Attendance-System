import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import 'addemployee.dart';


class newEmployeeSignIN extends StatefulWidget {
  const newEmployeeSignIN({Key? key}) : super(key: key);

  @override
  State<newEmployeeSignIN> createState() => _newEmployeeSignINState();
}

class _newEmployeeSignINState extends State<newEmployeeSignIN> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void signup(String _email,String _password)async{

    String _email = email.text.trim();
    String _password = password.text.trim();
    // try{
      // final _auth = FirebaseAuth.instance;
      // UserCredential userCredential=await  _auth.createUserWithEmailAndPassword(email: _email, password: _password );

        //String id = user.user!.uid;
        //print(id);
    //   print(userCredential.user!.uid);
    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>addNewEmployee(
    //        uid: userCredential.user!.uid
    //     ))).then((value) => Get.snackbar("added",""));

    // }on FirebaseAuthException catch(e){
    //   Get.snackbar("error",e.toString(),
    //   snackPosition: SnackPosition.BOTTOM);
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register New Employee"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              CupertinoButton(child: Text("SignUp"), onPressed: (){
                signup(email.text,password.text);
              })
            ],
          ),
        ),
      ),
    );
  }
}
